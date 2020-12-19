#include <Wire.h>

//PIN Setup IXZ-500
int xVref = A0;
int gyroPin = A1;
int state = 0;

//Gyro Axis
int valX = 0;
int valZ = 0;
int valRef = 0;

int axisIndex =0;

int debug = 53;
int az = 2;
int LED = 52;

boolean limit = false;


float gyroVoltage = 5;         //Gyro is running at 5V
float gyroZeroVoltage = 2.5;   //Gyro is zeroed at 2.5V
float gyroSensitivity = .0091;  //Our example gyro is 7mV/deg/sec
float rotationThreshold = 1;   //Minimum deg/sec to keep track of - helps with gyro drifting

float currentAngle = 0;          //Keep track of our current angle
int posx = 0;


void setup()
{
    Serial.begin(9600);
    Wire.begin(2);                // join i2c bus with address #2
    Wire.onRequest(requestEvent); // register event
    Wire.onReceive(receiveEvent); // register event


    pinMode(LED, OUTPUT);
    pinMode(debug, OUTPUT);
    //Timer Setup
    pmc_set_writeprotect(false);
    pmc_enable_periph_clk(ID_TC6);

    TC_Configure(TC2, 0,          /* Channel 0 on TC0                           */
            TC_CMR_TCCLKS_TIMER_CLOCK4  /* Use TCLK1 as source === MCLK/128             */
            | TC_CMR_WAVE               /* Waveform mode                              */
            | TC_CMR_WAVSEL_UP_RC       /* Count upwards to register C (==RC)         */
            );

    TC_SetRC(TC2, 0, 65624); //  -> 10hz

    //Enable RC Compare Interrupt and disable all others
    NVIC_ClearPendingIRQ(TC6_IRQn);
    NVIC_EnableIRQ(TC6_IRQn);

    TC2->TC_CHANNEL[0].TC_IER = TC_IER_CPCS; // IER = interrupt enable register
    TC2->TC_CHANNEL[0].TC_IDR = ~TC_IER_CPCS; // IDR = interrupt disable register

    //get Gyro RefSignal

    pinMode(az, OUTPUT);
    digitalWrite(debug, HIGH);
    digitalWrite(az, 1);
    delay(100);
    gyroZeroVoltage = (analogRead(gyroPin) * gyroVoltage) / 1023;

    for (int i = 0; i <= 1000  ; i += 1)
    {
        gyroZeroVoltage=gyroZeroVoltage *0.99  + ((analogRead(gyroPin) * gyroVoltage) / 1023) * 0.01;
        delay(1);
    }
    Serial.println('x');
    Serial.println(gyroZeroVoltage);
    Serial.println('x');

    digitalWrite(az, 0);

    //gyroZeroVoltage = (analogRead(xVref) * gyroVoltage) / 1023;
    //gyroZeroVoltage = (analogRead(gyroPin) * gyroVoltage) / 1023;

    digitalWrite(debug, LOW);

    TC_Start(TC2, 0);
}

void loop() {

    if (limit)
    {
        int i;
        for (i = 0; i <= 2  ; i += 1)
        {
            digitalWrite(LED, HIGH);
            delay(300);
            digitalWrite(LED, LOW);
            delay(500);
        }
        limit = false;
    }


}






void TC6_Handler()
{
    TC_GetStatus(TC2, 0);


    //This line converts the 0-1023 signal to 0-5V
    float gyroRate = (analogRead(gyroPin) * gyroVoltage) / 1023;
    //Serial.println(gyroRate);
    //This line finds the voltage offset from sitting still
    gyroRate -= gyroZeroVoltage;


    //This line divides the voltage we found by the gyro's sensitivity
    gyroRate /= gyroSensitivity;

    //Ignore the gyro if our angular velocity does not meet our threshold
    if (gyroRate >= rotationThreshold || gyroRate <= -rotationThreshold) {
        //This line divides the value by 100 since we are running in a 100ms loop (1000ms/100ms)
        gyroRate /= 10;
        currentAngle += gyroRate;

    }

    else
    {
        state = !state;
        digitalWrite(debug, state);
    }
    int pos;

    if (currentAngle > 180)
    {
        pos = 180;
        limit = true;
    }
    else if (currentAngle < 0)
    {
        pos = 0;
        limit = true;
    }
    else
    {
        pos = (int) currentAngle;
    }
    Serial.println(pos);
    posx = pos;
}




// function that executes whenever data is requested by master
// this function is registered as an event, see setup()
void requestEvent()
{
    //Wire.write(axis[axisIndex]);
    Wire.write( posx );
    Serial.print("ESTE_");
}

void receiveEvent(int howMany)
{
    while(0 < Wire.available()) // loop through all but the last
    {
        axisIndex = (uint8_t) Wire.read(); // receive byte as a character
        Serial.print(axisIndex);
        Serial.print('\n');

    }
}



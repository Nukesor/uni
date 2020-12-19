#include <Servo.h> 

Servo servo;

int servoControl = 9;
float alignment=90;
int calibrationTime = 5000;
int startTime = millis();

int led=13;
int gyroInXhigh = 2;
int gyroInYhigh = 3;
int gyroInX = 0;
int gyroInY = 1;
int vref = 6;
int vref_value;
int AZ = 7;
int FREQ_1Hz = 100;
float maxEntrop = 0;
int lastmilli= millis();

void startTimer(Tc *tc, uint32_t channel, IRQn_Type irq, uint32_t frequency){

    //Enable or disable write protect of PMC registers.
    pmc_set_writeprotect(false);
    //Enable the specified peripheral clock.
    pmc_enable_periph_clk((uint32_t)irq); 

    TC_Configure(tc, channel, TC_CMR_WAVE|TC_CMR_WAVSEL_UP_RC|TC_CMR_TCCLKS_TIMER_CLOCK4);
    uint32_t rc = VARIANT_MCK/128/frequency;

    TC_SetRA(tc, channel, rc/2);
    TC_SetRC(tc, channel, rc);
    TC_Start(tc, channel);

    tc->TC_CHANNEL[channel].TC_IER = TC_IER_CPCS;
    tc->TC_CHANNEL[channel].TC_IDR = ~TC_IER_CPCS;
    NVIC_ClearPendingIRQ(irq);
    NVIC_EnableIRQ(irq);
}

void setup()
{
    Serial.begin(9600);
    Serial.print("SETUP START\n");  
    vref_value = analogRead(vref);
    servo.attach(servoControl);
    pinMode(led,OUTPUT);
    startTimer(TC0, 1, TC1_IRQn, FREQ_1Hz);
    Serial.println("SETUP DONE\n");
}

void loop(){}

void TC1_Handler()
{
    TC_GetStatus(TC0,1);
    int Xvalue = analogRead(0);
    int Zvalue = analogRead(1);
    int XvalueHighsen = analogRead(2);
    int ZvalueHighsen= analogRead(3);

    float differenceX = vref_value - XvalueHighsen;
    float differenceZ = ((5000.0/1024)*(vref_value - ZvalueHighsen))/9.1;

    if (calibrationTime < (millis() - startTime)) {
        if (differenceZ != 0) {
            if (differenceZ > maxEntrop || differenceZ < -maxEntrop) {
                //Serial.print(differenceZ);
                //Serial.print('\n');
                alignment += differenceZ/100;
                //Serial.print(alignment);
                //Serial.print('\n');
                if (alignment < 24) {
                    alignment = 24;
                    for(int i=0; i< 3; i++) {
                        digitalWrite(led,HIGH);
                        delay(300);
                        digitalWrite(led,LOW);
                        delay(300);
                    }
                }
                else if (alignment > 159) {
                    alignment = 159;
                    for(int i=0; i< 3; i++) 
                        digitalWrite(led,HIGH);
                    delay(300);
                    digitalWrite(led,LOW);
                    delay(300);
                }
            }
        }
    }
}
else {
    if (1000 < (millis() - startTime)) {
        if (abs(differenceZ) > maxEntrop) {
            //Serial.print(maxEntrop);
            maxEntrop = abs(differenceZ);
        } 
    }
}
lastmilli=millis();
servo.write(alignment);
vref_value = analogRead(6);
}


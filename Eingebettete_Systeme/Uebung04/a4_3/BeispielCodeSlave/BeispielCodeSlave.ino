#include <Wire.h>
#include <stdint.h>

int calibrationTime = 5000;
int startTime = millis();
float alignment=90;

uint8_t axis[2];
int gyroInXhigh = 0;
int gyroInYhigh = 1;
int vref = 6;
int vref_value;
int AZ = 7;
int FREQ_1Hz = 100;
float maxEntrop = 0;
int lastmilli= millis();
uint8_t axisIndex = 0;

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
    Wire.begin(2);                // join i2c bus with address #2
    Wire.onRequest(requestEvent); // register event
    Wire.onReceive(receiveEvent); // register event
    vref_value = analogRead(vref);
    startTimer(TC0, 1, TC1_IRQn, FREQ_1Hz);
    axis[0] = 90;
    axis[1] = 90;
}

void loop()
{

    delay(100);
}

// function that executes whenever data is requested by master
// this function is registered as an event, see setup()
void requestEvent()
{
    Wire.write(axis[axisIndex]);
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

void TC1_Handler()
{
    TC_GetStatus(TC0,1);
    int XvalueHighsen = analogRead(2);
    int ZvalueHighsen = analogRead(3);

    float differenceX = ((5000.0/1024)*(vref_value - XvalueHighsen))/9.1;
    float differenceZ = ((5000.0/1024)*(vref_value - ZvalueHighsen))/9.1;

    if (calibrationTime < (millis() - startTime)) {
        if (differenceZ > maxEntrop || differenceZ < -maxEntrop) {
            alignment += differenceZ/100;
            if (alignment < 24) {
                alignment = 24;
            }
            else if (alignment > 159) {
                alignment = 159;
            }
            axis[0] = (uint8_t) alignment;
            Serial.print(differenceZ);
            Serial.print('\n');
        }
        if (differenceX > maxEntrop || differenceX < -maxEntrop) {
            alignment += differenceX/100;
            if (alignment < 24) {
                alignment = 24;
            }
            else if (alignment > 159) {
                alignment = 159;
            }
            axis[1] = (uint8_t) alignment;
        }
    }
    else {
        if (1000 < (millis() - startTime)) {
            if (abs(differenceZ) > maxEntrop) {
                //Serial.print(maxEntrop);
                maxEntrop = 13;
            } 
        }
    }
    lastmilli=millis();
    vref_value = analogRead(6);
}


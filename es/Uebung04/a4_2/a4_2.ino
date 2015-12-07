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
    startTimer(TC0, 1, TC1_IRQn, FREQ_1Hz);
    Serial.println("SETUP DONE\n");
    Wire.begin(2);
    Wire.onReceive(requestData);
    axis[0] = 90;
    axis[1] = 90;
    Serial.println("SETUP Fuckedup \n");
}

void requestData(int howMany){
    Serial.print('JOo');
    Serial.print('\n');
    while (0 < Wire.available()){
        Serial.print('jo');
        Serial.print('\n');
        int index = Wire.read();
        Wire.write(axis[index]);
    }
}

void loop(){
    delay(20);
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
                maxEntrop = abs(differenceZ);
            } 
        }
    }
    lastmilli=millis();
    vref_value = analogRead(6);
}


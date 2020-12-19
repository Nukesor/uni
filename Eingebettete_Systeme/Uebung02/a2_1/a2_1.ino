
int led_output = 6;
int led_lower = 11;
int led_higher = 9;
int brightness = 50;
int low_counter = 0;
int high_counter = 0;
int trigger = 100;
int FREQ_1Hz = 1000;


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
    pinMode(led_output, OUTPUT);
    pinMode(led_lower, INPUT);
    pinMode(led_higher, INPUT);

    startTimer(TC0, 0, TC0_IRQn, FREQ_1Hz);

    Serial.println("SETUP DONE\n");
}

void loop()
{
}
void TC0_Handler()
{
    //Serial.print("Interrupt executed\n");
    TC_GetStatus(TC0,0);
    if (digitalRead(led_lower) == LOW)
    {
        low_counter += 1;
        if (low_counter == trigger) {
            Serial.print("Brightness was lowered\n");
            brightness -= 10;
            if (brightness < 0)
            {
                brightness = 0;
            }
            analogWrite(led_output, brightness);
            low_counter = 0;
            Serial.print(brightness);
            Serial.print("\n");
        }
    }
    else {
        low_counter = 0; 
    }
    if (digitalRead(led_higher) == LOW)
    {
        high_counter += 1;
        if (high_counter == trigger) {
            Serial.print("Brightness was hightend\n");
            brightness += 10;
            if (brightness > 255)
            {
                brightness = 255;
            }
            analogWrite(led_output, brightness);
            high_counter = 0;
            Serial.print(brightness);
            Serial.print("\n");
        }
    }
    else {
        high_counter = 0; 
    }

    //TC_GetStatus(TC0,0);
    //Serial.print("Handler TC0 DONE\n");
}

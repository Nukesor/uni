int gyroInXhigh = 2;
int gyroInYhigh = 3;
int gyroInX = 0;
int gyroInY = 1;
int vref = 6;
int vref_value;
int AZ = 7;
int FREQ_1Hz = 3;



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
    vref_value = analogRead(vref);
    Serial.print("SETUP START\n");

    startTimer(TC0, 0, TC0_IRQn, FREQ_1Hz);
    Serial.println("SETUP DONE\n");
}

void loop()
{
}
void TC0_Handler()
{
    int Xvalue = analogRead(0);
    int Zvalue = analogRead(1);
    vref_value = analogRead(6);
    int XvalueHighsen = analogRead(2);
    int ZvalueHighsen= analogRead(3);

    float differenceX = ((5000.0/1024)*(vref_value - XvalueHighsen))/9.1;
    float differenceZ = ((5000.0/1024)*(vref_value - ZvalueHighsen))/9.1;

    TC_GetStatus(TC0,0);
    Serial.print("\nvrev: ");
    Serial.print(vref_value);
    Serial.print("\nValueX: ");
    Serial.print(XvalueHighsen);
    Serial.print("\nValueY: ");
    Serial.print(ZvalueHighsen);
    Serial.print("\nDifferenzX: ");
    Serial.print(differenceX/3);
    Serial.print("\nDifferenzZ: ");
    Serial.print(differenceZ/3);
}

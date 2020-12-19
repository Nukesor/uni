
const int swup = 11;
const int swdown = 12;

boolean upblock = 0;
boolean downblock = 0;

void setup() {
    // put your setup code here, to run once:
    pinMode(swup, INPUT_PULLUP);
    pinMode(swdown, INPUT_PULLUP);
    pinMode(13, OUTPUT);

    Serial.begin(9600);
    Serial3.begin(9600);


}

void loop() {
    // put your main code here, to run repeatedly:

    if (!digitalRead(swup) && !upblock)
    {
        if (!upblock)
        {
            // u = up
            setDevice('1', (byte) 'u');
            upblock = true;
        }
    }
    else
    {
        upblock = false;
    }

    if (!digitalRead(swdown) )
    {
        if (!downblock)
        {
            // d = down
            setDevice('1', (byte) 'd');
            downblock = true;
        }
    }

    else
    {
        downblock = false;
    }

    if (Serial3.available() > 0)
    {
        if (Serial3.read() == 'b')
        {

            for (int i = 0; i < 3 ; ++i)
            {
                digitalWrite(13, HIGH);
                delay(300);
                digitalWrite(13, LOW);
                delay(300);
            }
        }
    }

    delay(100);
}



void setDevice(byte dev, byte value)
{
    byte array[3] = {'0', dev, value};
    Serial.write(array, 3);
    Serial3.write(array, 3);
}

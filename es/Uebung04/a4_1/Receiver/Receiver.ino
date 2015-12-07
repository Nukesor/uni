

const int ledPin = 13;
int ledValue = 0;

void setup() {
    Serial.begin(9600);
    Serial3.begin(9600);
    pinMode(ledPin, OUTPUT);
    digitalWrite(ledPin, 0);
}
void loop() {
    receiveData();
}




void receiveData()
{
    if (Serial3.available() > 2)
    {
        byte readBuffer[3];
        Serial3.readBytes(readBuffer, 3);
        if (readBuffer[1] == '1')
        {

            checkInput(readBuffer);

            analogWrite(ledPin, ledValue);
        }
    }
}

void checkInput(byte *readBuffer)
{
    if (readBuffer[2] == 'u')
    {
        ledValue += 10;

        if (ledValue > 255)
        {
            ledValue = 255;
            Serial3.write('b');
        }
    }

    else if (readBuffer[2] == 'd')
    {
        ledValue -= 10;

        if (ledValue < 0)
        {
            ledValue = 0;
            Serial3.write('b');
        }
    }
}



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


        }
    }
}

void checkInput(byte *readBuffer)
{
    if (readBuffer[2] == 'u')
    {

        while (ledValue < 255)
        {
            analogWrite(ledPin, ++ledValue);
            delay(19);
        }

    }




    else if (readBuffer[2] == 'd')
    {
        while(ledValue > 0)
        {
            analogWrite(ledPin, --ledValue);
            delay(19);
        }

    }


    Serial3.write('b');
}


#include <Wire.h>
#include <Servo.h>
#include <stdint.h>

Servo myservo;

void setup()
{
    myservo.attach(9);
    Wire.begin();        // join i2c bus (address optional for master)
    Serial.begin(9600);  // start serial for output
}

void loop()
{


    Wire.requestFrom(2,1);  // request 6 bytes from slave device #2


    while (Wire.available())   // slave may send less than requested
    {
        uint8_t c = (uint8_t) Wire.read();    // receive a byte as character
        Serial.print(c);
        Serial.print('\n');    // print the character
        myservo.write(c);
    }

    delay(40);
}


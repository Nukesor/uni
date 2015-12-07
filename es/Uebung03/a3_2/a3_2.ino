#include <Servo.h> 

Servo servo;

int servoControl = 9;
int rotDirection=0;
float alignment=90;
float rotation=1;
int maxAlign=160;
int minAlign=25;

void setup()
{
    Serial.begin(9600);
    servo.attach(servoControl);
    Serial.println("SETUP DONE\n");
}

void loop()
{
    if (rotDirection == 0) {
        alignment += 1;
    }
    else {
        alignment -= 1; 
    }
    if (alignment > maxAlign) {
        alignment = maxAlign;
        rotDirection += 1;
        rotDirection = rotDirection % 2;
        minAlign+=5;
        if (maxAlign == 90) {
            maxAlign=160;
            minAlign=25;
        }
    }
    else if (alignment < minAlign) {
        alignment = minAlign;
        rotDirection += 1;
        rotDirection = rotDirection % 2;
        maxAlign-=5;
        if (minAlign == 90) {
            minAlign=25;
            maxAlign=160;
        }
    }

    Serial.print(alignment);
    Serial.print("\n");
    servo.write(alignment);
    delay(2);
}


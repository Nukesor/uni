
#include <Servo.h> 

int led = 13;
int incomingByte = 0;

Servo servo;
int servoControl = 9;
int rotDirection=0;
float alignment=90;
float rotation=1;
int maxAlign=159;
int minAlign=24;


void setup() 
{
    Serial.begin(9600);     // opens serial port, sets data rate to 9600 bps
    pinMode(led,OUTPUT);
    servo.attach(servoControl);
    Serial.print("Alignment goes from 24 to 159\n");
}

void readInput()
{
    // for incoming serial data
    int char_count = 0;
    String input_string = "";
    while(Serial.available() > 0)
    {
        //read the incoming byte:
        incomingByte = Serial.read();
        delay(20);
        input_string += (char)incomingByte;
    }
    if(input_string.length() > 0) 
    {
        parseInput(input_string);
    }
}
void parseInput(String input_string)
{
    String command="";
    String strParameter = "";
    for (int i = 0; i < input_string.indexOf('('); i++) {
        command += input_string.charAt(i);
    }
    for (int i = input_string.indexOf('(')+1; i < input_string.indexOf(')'); i++) {
        strParameter += input_string.charAt(i);
    }
    int parameter = strParameter.toInt();
    if (parameter != 0) {
        if (command == String("moveTo")) {
            if (parameter > minAlign && parameter < maxAlign) {
                Serial.print("SettingAlignment to ");
                Serial.print(parameter);
                Serial.print('\n');
                servo.write(parameter);
            }
            else {
                Serial.print("Parameter out of Range");
                Serial.print('\n');
            }
        }
        else{
            Serial.print("Invalid Command");
            Serial.print('\n');
        }
    }
    else {
        Serial.print("Invalid Parameter. Please enter a number between 24-159");
        Serial.print('\n');
    }
}

void loop()
{
    readInput();
}


int led = 13;
int incomingByte = 0;


void setup() 
{
    Serial.begin(9600);     // opens serial port, sets data rate to 9600 bps
    pinMode(led,OUTPUT);
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
    //  Serial.print("=================\n");
    //  Serial.print(char_count);
    //  Serial.print("\n");
    //  Serial.print(Serial.available());
    //  Serial.print("\n");
    //
    //  Serial.print("=================\n");
}
void parseInput(String input_string)
{
    String input_segments[8];
    int segment_counter = 0;
    strsep(input_string,"(),");
    for(int i = 0; i < segment_counter; i++)
    {
        Serial.print(input_segments[i]);
    }

    if(segment_counter == 1)
    {
        Serial.print(input_string);

        Serial.print("\n");
        if(input_segments[0] == String("ledon"))
        {
            Serial.print("Should be on now\n");
            digitalWrite(led,HIGH);
        }
        else if(input_segments[0] == String("ledoff")) 
        {
            Serial.print("Should be off now\n");
            digitalWrite(led,LOW);
        }
        else
        {
            ///Serial.print("Command not found");
        }
    }
    else
    {

    }
}

void loop()
{
    readInput();
}

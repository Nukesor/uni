#include <SPI.h>
#include <SD.h>
#include <string.h>

#define OUT_SCESD 4
int incomingByte = 0;
int fixIn = 2;
String sentence = "";

// variable for NMEA sentence 

void init_SD()
{
    if(!SD.begin(OUT_SCESD))
    {
        Serial.println("Card failed, or not present");
        return;
    }
    Serial.println("Card initialized");
}

int check_for_file(String strParameter)
{
    char filename[strParameter.length() + 1];
    strParameter.toCharArray(filename, strParameter.length() + 1);
    return SD.exists(filename);
}

String read_file_from_SD(String file_name)
{
    File dataFile = SD.open(file_name, FILE_READ);
    String input = "";
    if (dataFile)
    {
        while (dataFile.available())
        {
            input += (char)dataFile.read();
        }
        dataFile.close();
    }
    return input;
}

void write_file_to_SD(String file_name, String data)
{
    File file = SD.open(file_name,FILE_WRITE);
    file.println(data);
    file.close();
    return;
}

void print_string_to_serial(String data)
{
    Serial.println(data);
}

void setup() {
    // For output to serial monitor
    Serial.begin(9600);
    init_SD();
    pinMode(fixIn, INPUT);
    pinMode(13, OUTPUT);
    // Connection to GPS
    Serial1.begin(9600);
}

void read_gps_data() {
    if (digitalRead(fixIn) > 0) {
        digitalWrite(13, HIGH);
    } else {
        digitalWrite(13, LOW);
    }
    if (Serial1.available() > 0) {
        char c = Serial1.read();
        // Check if end of NMEA sentence
        if(c == '\n') {
            // Check if $GPRMC NMEA sentence
            if(sentence.startsWith("$GPRMC")) {
                bool validString = false;
                // Checksum 
                if (sentence.indexOf('*') != -1) {
                    String toChecksum = sentence.substring(1,sentence.indexOf('*'));
                    int checksum;
                    for (int i = 0; i < toChecksum.length(); i++) {
                        if (i == 0){
                            checksum = (int) toChecksum.charAt(i);
                        } else {
                            checksum = checksum ^ (int) toChecksum.charAt(i);
                        }
                    }
                    char charChecksum [3];
                    sentence.substring(sentence.indexOf('*')+1).toCharArray(charChecksum,3);
                    int validChecksum = (int) strtol(charChecksum, NULL, 16);
                    if (validChecksum == checksum) {
                        validString = true;
                    } else {
                        Serial.print("Invalid Checksum: ");
                        Serial.println(checksum);
                        Serial.print("Compared to validChecksum:");
                        Serial.println(validChecksum);
                    }
                }


                char data[150];
                char *dataPtr = data;
                char *value; 
                sentence.toCharArray(data, sentence.length());
                int i = 0;
                String currentPosition = "";

                // strtok_r is part of C standard library.
                while ((value = strtok_r(dataPtr, ",", &dataPtr)) != NULL) { 
                    char converted [9];
                    if(i == 3 || i == 5) {
                        float position = (float) atof(value);
                        position = position / 100;
                        dtostrf(position, 9, 6, converted);
                        currentPosition += String(converted);
                    } 
                    if (i == 3) {
                        currentPosition += ",";
                    }
                    else if (i == 6) {
                        if (currentPosition.indexOf(' ') != -1){
                            currentPosition.remove(currentPosition.indexOf(' '),1);
                        }
                        write_file_to_SD("arne.txt",currentPosition);
                        break;
                    }
                    i++;
                }
            }
            sentence = "";
        }
        else {
            // Append character if not end of sentence
            sentence += c;
        }
    }
}

void parseInput(String input_string)
{
    Serial.print("Start of parsing \n");
    String command="";
    String strParameter = "";
    for (int i = 0; i < input_string.indexOf('('); i++) {
        command += input_string.charAt(i);
    }
    for (int i = input_string.indexOf('(')+1; i < input_string.indexOf(')'); i++) {
        strParameter += input_string.charAt(i);
    }
    
    if(command == "printFile")
    {
        Serial.print(read_file_from_SD(strParameter));
    }
    return;
}

void readInput()
{
    // for incoming serial data
    String input_string = "";
    incomingByte = -1;
    while(Serial.available() > 0)
    {
        //read the incoming byte:
        incomingByte = Serial.read();
        delay(40);
        input_string += (char)incomingByte;
    }


    if(incomingByte != -1)
    {
        parseInput(input_string);
    }
}

char *dtostrf (double val, signed char width, unsigned char prec, char *sout) {
    char fmt[20];
    sprintf(fmt, "%%%d.%df", width, prec);
    sprintf(sout, fmt, val);
    return sout;
}

void loop()
{
  readInput();
  read_gps_data();
}


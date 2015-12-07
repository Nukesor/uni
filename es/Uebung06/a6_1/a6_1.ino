#include <SPI.h>
#include <SD.h>
#include "font.h"

#define OUT_RST 6
#define OUT_LED 2
#define OUT_DC 5
#define OUT_SCE 10 // 4, 10, 52
#define OUT_SCESD 4

#define WIDTH 84
#define HEIGHT 48
#define BANKS 504
#define PIXELS 4032

byte pixelBuffer[BANKS];
int incomingByte = 0;

void init_SD()
{
    if(!SD.begin(OUT_SCESD))
    {
        Serial.println("Card failed, or not present");
        return;
    }
    Serial.println("Card initialized");
}

void initialize() {

    digitalWrite(OUT_LED, LOW); // turn LED off

    resetDisplay();

    SPI.begin(OUT_SCE);
    SPI.setClockDivider(OUT_SCE, 84);
    delay(100); 

    commandMode();
    delay(100);
    sendByte(0x21); // FUNCTION SET
    sendByte(0x14); // SET BIAS
    sendByte(0b10110000); // SET CONTRAST
    sendByte(0x20); // FUNCTION SET
    sendByte(0x0C); // SET DISPLAY MODE
    dataMode();
    delay(100);
    digitalWrite(OUT_LED, HIGH);
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

void setup()
{
    Serial.begin(9600);
    pinMode(OUT_LED, OUTPUT);
    pinMode(OUT_RST, OUTPUT);
    pinMode(OUT_DC, OUTPUT);

    initialize();
    init_SD();
}

bool test = false;

void loop()
{
    readInput();
    if (test == false) {
        clearDisplay();
        String Text = "Welcome to the party \n";
        printText(Text);
        test = true;
    }
    drawBuffer();
}


void resetDisplay() {
    digitalWrite(OUT_RST, LOW);
    delay(500);
    digitalWrite(OUT_RST, HIGH);
}

void commandMode() {
    digitalWrite(OUT_DC, LOW);
}

void dataMode() {
    digitalWrite(OUT_DC, HIGH);
}

bool isBitSet(byte b, int pos)
{
    return (b & (1 << pos)) != 0;
}

void printChar(int x, int y, unsigned char Char[6]) {
    for (int i = 0; i<6; i++) {
        for (int j = 0; j<8; j++){
            if (isBitSet((byte) Char[i], j)) {
                setPixel(x+i,y+j, true);
            } else {
                setPixel(x+i,y+j, false);
            }
        }
    }
}

void printString(int x, int y, String Name ) {
    for (int i = 0; i < Name.length(); i++) {
        char doTheTrick = Name.charAt(i);
        int index = (int) doTheTrick - 32;
        printChar(x+6*i, y, font[index]);
    }
}

void printText(String Text) {
    Serial.print("Entering printText \n");
    int x = 0;
    int line = 0;
    int currentIndex = 0;
    char currentChar;
    char charArray[Text.length()];
    Text.toCharArray(charArray, Text.length());
    String currentString;

    Serial.print("Starting to parse \n");
    if (Text.length() > 84){
        Serial.print("Text too long. Aborting \n");
        String DebugString = "Text too long";
        printString(0,0,DebugString);
    }
    else {
        while (currentIndex <= Text.length()) {
            Serial.print("New Loop at position ");
            Serial.print(currentIndex);
            Serial.print(" with Char: ");
            Serial.print(charArray[currentIndex]);
            Serial.print("\n");
            if (currentIndex < Text.length() && line < 6) {
                char currentChar = charArray[currentIndex];
                // In case of normal char
                if (currentChar != ' ' && currentChar != '\n') {
                    Serial.print("Next Char \n");
                    currentString += currentChar;
                    ++currentIndex;
                }
                // In case of space
                else if (currentChar == ' ' || currentChar == '\n') {
                    currentString += currentChar;
                    ++currentIndex;
                    // Current word is too long
                    if ((currentString.length()-1)*6 > 84){
                        Serial.print("Word too long for single Line \n");
                        // Beginning of line
                        String DebugString = "Word too long ";
                        printString(x,line*8 ,DebugString);
                        x = DebugString.length()*6;
                        // Going to next line in case of new line
                        if (currentChar == '\n') {
                            ++line;
                        }
                    }
                    else {
                        Serial.print("Printing Word in ");
                        if (x+6*(currentString.length()-1) > 84){
                            Serial.print("Next Line \n");
                            x = 0;
                            ++line;
                            printString(x ,line*8 ,currentString);
                            x = currentString.length()*6;
                        }
                        else {
                            Serial.print("Current Line \n");
                            printString(x ,line*8, currentString);
                            x += currentString.length()*6;
                        }
                        // Going to next line in case of new line
                        if (currentChar == '\n') {
                            ++line;
                        }
                        // Reseting currentString for new word.
                        currentString = "";
                    }
                }
            }
            else if (line > 5) {
                Serial.print("Too many Lines \n");
                currentIndex = 85;
            }
            else {
                Serial.print("Text parsed \n");
                currentIndex = 85;
            }
        }
    }
}


void drawImage(String ImageData) {
    int komma = ImageData.indexOf(',');
    int newLine = ImageData.indexOf('\n');
    int imageHeight = ImageData.substring(0,komma).toInt();
    int imageWidth = ImageData.substring(komma+1,newLine).toInt();
    int startx = WIDTH/2-imageWidth/2;
    int starty = HEIGHT/2-imageHeight/2;

    Serial.print("Printing Image with dimensions: ");
    Serial.print(imageWidth);
    Serial.print(",");
    Serial.print(imageHeight);
    Serial.print(" at position: ");
    Serial.print(startx);
    Serial.print(",");
    Serial.print(starty);
    Serial.print("\n");

    String data = ImageData.substring(newLine+1);
    int pixelAmount = imageWidth*imageWidth;
    for (int i = 0; i < pixelAmount; i++) {
        String currentPixel = "";
        currentPixel += data.charAt(i*2);
        if (currentPixel != "," ){ 
            setPixel(startx+(i%imageWidth), starty+i/imageHeight,currentPixel.toInt());
        }
    }
}

void drawBuffer() {
    for(int i = 0; i < BANKS; ++i) {
        sendByte(pixelBuffer[i]);
    }    
}

void sendByte(byte data) {
    SPI.transfer(OUT_SCE, data);
}

void clearDisplay() {
    for(int i = 0; i < BANKS; ++i) {
        pixelBuffer[i] = 0x00;
    }
}

void makeBlack(){
    for(int i = 0; i < BANKS; ++i) {
        pixelBuffer[i] = 0xFF;
    }
}


void setPixel(int x, int y, bool value) {
    if(x < 0 || x >= WIDTH || y < 0 || y >= HEIGHT) return;

    int row = y / 8;
    int index = row * WIDTH + x;
    int bitnum = y % 8;
    int bitmask = 1 << bitnum;

    if(value) {
        pixelBuffer[index] |= bitmask;
    } else {
        pixelBuffer[index] &= ~bitmask;
    }
}

void printFile(String file_name)
{
    clearDisplay();
    if (check_for_file(file_name)) {
        int n = file_name.indexOf('.');
        delay(20);
        String file_type = file_name.substring(n+1);

        if(file_type == "txt")
        {
            printText(read_file_from_SD(file_name));
            Serial.print("TXT");
            return;
        }
        if(file_type == "img")
        {
            drawImage(read_file_from_SD(file_name));
            return;
        }
        Serial.print("Filetype not supported \n");
        return;
    }
    else {
        Serial.print("No such File");
        String DebugString = "No such file existing";
        printText(DebugString);
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

    // Serial.print(command);
    if(command == "checkFile")
    {
        clearDisplay();
        if (check_for_file(strParameter)){
            String DebugString = "File exists";
            printText(DebugString);
        }
        else {
            String DebugString = "File doesn't exist";
            printText(DebugString);
        }
        return;
    }
    if(command == "printFile")
    {
        printFile(strParameter);
        return;
    }
    clearDisplay();
    String DebugString = "Command not found";
    printText(DebugString);

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


#include <SPI.h>
#include "font.h"

// PIN 8 LED
// PIN 7 serial clock
// PIN 6 MOSI 
// PIN 5 D/C data/command
// PIN 4 RST reset?
// PIN 3 Slave Select
// PIN 2 ground 
// PIN 1 voltage 3.3

#define OUT_RST 6
#define OUT_LED 2
#define OUT_DC 5
#define OUT_SCE 10 // 4, 10, 52

#define WIDTH 84
#define HEIGHT 48
#define BANKS 504
#define PIXELS 4032

byte pixelBuffer[BANKS]; 
String Names[2][2];

void initialize() {
    Names[0][0] = "Arne Beer";
    Names[0][1] = "6489196";            digitalWrite(OUT_LED, 0); // turn LED off
    Names[1][0] = "Olli Heidmann";
    Names[1][1] = "6420331";            resetDisplay();

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

void setup()
{
    Serial.begin(9600);
    pinMode(OUT_LED, OUTPUT);
    pinMode(OUT_RST, OUTPUT);
    pinMode(OUT_DC, OUTPUT);

    initialize();
}

int NameIndex = 0;
int midx = WIDTH/2;    
int midy = HEIGHT/2;

void loop()
{
    clearDisplay();
    for (int i = 0; i < 2; i++) {
        int startx = midx-Names[NameIndex][i].length()*3;
        int starty = midy-4+i*12-8;
        printString(startx, starty, Names[NameIndex][i]);
        drawBuffer();
    }
    ++NameIndex;
    NameIndex = NameIndex % 2;
    drawBuffer();
    delay(5000);
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



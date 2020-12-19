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

void initialize() {
    digitalWrite(OUT_LED, 0); // turn LED off

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

int column = 0;
int row = 0;

void loop()
{
    char doTheTrick = 'A';
    int index = (int) doTheTrick - 32;
    int midx = WIDTH/2;    
    int midy = HEIGHT/2;
    int startx = midx-3;
    int starty = midy-4;
    printChar(startx, starty, font[index]);
    drawBuffer();
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



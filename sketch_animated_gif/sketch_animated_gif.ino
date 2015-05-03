#include "FastLED.h"
#include "SPI.h"
#include "SD.h"

#define NUM_LEDS 150

#define DATA_PIN 9

CRGB leds[NUM_LEDS];

File myFile;

void setup() {  
       FastLED.addLeds<WS2811, DATA_PIN, GRB>(leds, NUM_LEDS);
       Serial.begin(9600);
       Serial.print("Initializing SD card...");
       pinMode(10,OUTPUT);
       
       if (!SD.begin(4)) {
         Serial.println("Initialization failed!.");
         return;
       }
       Serial.println("Initialization done.");
       
       myFile = SD.open("gif.txt");
       if (myFile) {
         Serial.println("gif.txt:");
         
         while (myFile.available()) {
           Serial.write(myFile.read());
         }
         myFile.close();
       }
       else {
         Serial.println("Error opening gif.txt");
       }
}


void loop() {

FastLED.show();
delay(150);
}


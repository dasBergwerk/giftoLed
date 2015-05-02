/**
* GiftoLedTransfer
*
*
* Sketch to convert animated gifs for a led-stripe controlled by arduino & ws2811
* Similiar project Pixelbox
*
* by das_bergWerk, 2015
*
*/

import gifAnimation.*; 
import controlP5.*;


PrintWriter output;
PImage[] myImage;
PImage myAnimation;
int framenumber,x_width,y_height;

String gifPath = "None Chosen";
String outputPath = "None Chosen";

ControlP5 cp5;

void setup () {
  size (500,640);
  cp5 = new ControlP5(this);
  
  cp5.addButton("gifSelect")
     .setSize(130,35)
     .setPosition (43,50)
     .setLabel("1. Select a gif");
 
 cp5.addButton("outputSelect")
    .setSize(130,35)
    .setPosition(43, 130)
    .setLabel("2. Select Output Folder");
 
 cp5.addButton("Run")
    .setSize(130,35)
    .setPosition(43,550)
    .setLabel("3. Run or");
 
 cp5.addButton("Exit")
    .setSize(130,35)
    .setPosition(200,550)
    .setLabel("3. Exit");
  
}



void draw () {
  background (0);
  drawText();
  drawImage();
     
 stroke(255);
 line(43, 220, 453,220);
 line(43,240,453,240);
 line(43,500,453,500); 


}

void drawText () {
  textSize(14);
  text("gif to LED-Matrix Transfer", 150,20);
  textSize(10);
  text(gifPath,43,110);
  text(outputPath,43,190);
}

void drawImage () {
  if (gifPath != "None Chosen") {
      myImage = Gif.getPImages(this, gifPath);
      x_width = myImage[0].width;
      y_height = myImage[0].height;
      framenumber = myImage.length;
      int a = 43 - myImage[0].width;
      for (int i = 0; i < framenumber; i = i+1) {
        a = a + x_width;
        image(myImage[i],a,221);
      }
      
      Gif myAnimation = new Gif(this, gifPath);
      myAnimation.play();
      image(myAnimation,200,380);

      
      
  } else {
    textSize(10);
    text("No Pic", 43,235);
    textSize(12);
    text("No Pic", 200,380);
  }
}


void Exit () {
  exit();
}

public void gifSelect () {
  selectInput("Select a gif File: ","gifProcess");
}

void gifProcess(File selection) {
   if (selection == null) {
    gifPath = "None Chosen";
  } else {
    gifPath = selection.getAbsolutePath();
   
  }
}

public void outputSelect () {
  selectFolder("Select the SD-Card Mainfolder:","outputProcess");
}

void outputProcess (File selection) {
  if (selection == null) {
    outputPath = "None Chosen";
  } else {
    outputPath = selection.getAbsolutePath();
  }
}

void Run () {
  output = createWriter(outputPath+"/gif.txt");
  int a = 43-this.x_width;
  for (int b = 0; b < this.framenumber; b = b +1 ) {
    int pos = -1;
    a = a+this.x_width;
    for (int i = 0; i < this.x_width; i = i + 1) {
      for (int j = 0; j < this.y_height; j = j + 1) {
        color d = get(i+a,221+j);
        pos = pos + 1;
        this.output.println(pos+","+int(red(d))+","+int(green(d))+","+int(blue(d)));
      }
    }
  }
  
  this.output.flush();
  this.output.close();
  exit();
}




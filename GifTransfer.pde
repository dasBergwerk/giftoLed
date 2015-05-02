import gifAnimation.*;

PrintWriter output;
PImage[] myImage;
int x,y,c; 
int count = 0;


void setup () {
  size(320,640);
  background(0);
  output = createWriter("PixelRgB.txt");
  myImage = Gif.getPImages(this, "521.gif");
  // myImage = loadImage("flame.gif");
  c = myImage.length; 
  x=myImage[1].width;
  y=myImage[1].height;
  int a = 0-myImage[1].width;
  for (int i = 0; i < c; i = i+1) {
    a = a + x;
    image(myImage[i],a,0);
  }

}

void draw () {
int a = 0-this.x;
for (int b = 0; b < this.c; b = b+1) {
   int pos = -1;
   a = a + this.x;
    for (int i = 0; i < this.x; i = i+1) {
     for (int j = 0; j < this.y; j = j+1) {
       color d = get(i+a,j);
       pos = pos + 1;
       this.output.println("leds["+pos+"].setRGB("+int(red(d))+","+int(green(d))+","+int(blue(d))+");");
      
   } 
 }
  this.output.println("FastLED.show();");
  this.output.println("delay(150);");
} 
this.output.flush();
this.output.close();
exit();
}


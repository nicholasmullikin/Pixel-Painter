
/*Program: NYC Photo Editor
 Author: Nicholas Mullikin, Yujin Yamahara, Catherine Banner
 Date:   2/20/15
 Notes:    (Nicholas Yujin Catherine)NYC Photo Editor
 The primary and secondary colors are based off of the selected color on the color menu.
 The Close all the the Red circle close the application. 
 All photos taken from www.flaticon.com
 */

import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;
import java.awt.AWTEvent;
import java.awt.MouseInfo;
import java.awt.Toolkit;
import java.awt.event.AWTEventListener;
import java.util.*; 
ControlP5 cp5;

ControlP5 filter1;
ControlP5 filter2;
ControlP5 filter3;
ControlP5 filter4;

ControlFrame cf;
ControlFrame cf1;

int sliderT = 1;
Boolean Tint = false;
Boolean Red1=false;
Boolean Green1=false;
Boolean Blue1=false;
Boolean Red2=false;
Boolean Green2=false;
Boolean Blue2=false;
Boolean Red3=false;
Boolean Green3=false;
Boolean Blue3=false;
Boolean VerticalorHorizontal = false;
PImage tempBeforeFilter;
int filtermode= 5;
int ColorStrength = 1;
int SquareSize = 5;
int filter3i = 0;
int ContrastLevel = 1;

PImage tempBeforeImage;
PImage image;
String filepath = "                                                                           ";
int newphoto = 0;
boolean photomode = false;
int photoX;
int photoY;
boolean click = true;

boolean FilterOnOff;





PImage pencil;
PImage eraser;
PImage square;
PImage line;
PImage ellipsey;
PImage spraycan;
PImage dropper;
PImage triangle;
PImage gridlines;
PImage crop;
PImage gridlines1;
int gridlinesint = -1;
PImage gridlinesimage;
PImage dropperIcon;


color[] customColors = new color[64];
color primary = color(0);
color secondary = color(255);
color palette10 = color(0, 236, 255);//turquoise
int state = 0;
int oldmX, oldmY;
int strokeWidth = 1;
int colorSelect = 1;
int lineSX, lineSY;
int pointX, pointY;
int ellipseX, ellipseY;
int triangleX1, triangleY1, triangleX2, triangleY2, triangleX3, triangleY3;
int triangleCount;
PImage lineBP;
PImage rectBP;
PImage ellipseBP;
PImage triangleBP;



ListBox file;
ListBox edit;
ListBox filter;
int cnt = 0;
String[] nameFile ={"Open", "Open Recent", "Close", "Close All","Save", "Save as PNG", "Save as JPG", "Save as TIFF"};
String[] nameEdit ={"Cut","Copy","Paste","Delete"};
String[] namefilter ={"Filter 1","Filter 2","Filter 3","Filter 4"};




MyColorPicker cp;
MyColorPicker cp1;

void init() {
 
  // trick to make it possible to change the frame properties
  frame.removeNotify(); 
 
  // comment this out to turn OS chrome back on
  frame.setUndecorated(true); 
 
  // comment this out to not have the window "float"
  //frame.setAlwaysOnTop(true); 
 
  frame.setResizable(true);  
  frame.addNotify(); 
 
  // making sure to call PApplet.init() so that things 
  // get  properly set up.
  super.init();
}


void setup() {

  dropperIcon = loadImage("dropperIcon.png");
  pencil = loadImage("pencil.png");
  eraser = loadImage("eraser.png");
  square = loadImage("square.png");
  line = loadImage("line.png");
  ellipsey = loadImage("ellipse.png");
  spraycan = loadImage("spraycan.png");
  dropper = loadImage("dropper.png");
  triangle = loadImage("triangle.png");
  crop = loadImage("crop.png");
  gridlines = loadImage("gridlines.png");
  gridlines1 = loadImage("gridlines1.png");

  size(1000, 600);
  noStroke();
  background(255);
  fill(0);
  cf = addControlFrame("Tools", 140, 600, 1); //other window
  cf1 = addControlFrame("Colors", 150, 600, 2); // other window

 ControlP5.printPublicMethodsFor(ListBox.class);

  cp5 = new ControlP5(this);
  filter1 = new ControlP5(this);
  filter2 = new ControlP5(this);
  filter3 = new ControlP5(this);
  filter4 = new ControlP5(this);




  file = cp5.addListBox("File")
         .setPosition(50, 25)
         .setSize(120, 120)
         .setItemHeight(15)
         .setBarHeight(20)
         .setColorBackground(color(255, 128))
         .setColorActive(color(0))
         .setColorForeground(color(255, 100,0))
         .setOpen(false)
         .setHeight(60)
         ;

  file.captionLabel().toUpperCase(true);
  file.captionLabel().set("File");
  file.captionLabel().setColor(0xffff0000);
  file.captionLabel().style().marginTop = 3;
  file.valueLabel().style().marginTop = 3;
  
  
  ListBoxItem file1;
  for(int i = 0; i < nameFile.length; i++)
  {
    file.addItem(nameFile[i], i);
  }
 
//////////////////////////////////////////////////////////////////////////

  edit = cp5.addListBox("edit")
         .setPosition(175, 25)
         .setSize(120, 120)
         .setItemHeight(15)
         .setBarHeight(20)
         .setColorBackground(color(255, 128))
         .setColorActive(color(0))
         .setColorForeground(color(255, 100,0))
         .setOpen(false)
         .setHeight(60)
         ;

  edit.captionLabel().toUpperCase(true);
  edit.captionLabel().set("edit");
  edit.captionLabel().setColor(0xffff0000);
  edit.captionLabel().style().marginTop = 3;
  edit.valueLabel().style().marginTop = 3;
  
  
  ListBoxItem edit1;
  for(int i = 0; i < nameEdit.length; i++)
  {
    edit.addItem(nameEdit[i], i);
  }



//////////////////////////////////////////////////////


 filter = cp5.addListBox("Filter")
         .setPosition(300, 25)
         .setSize(120, 120)
         .setItemHeight(15)
         .setBarHeight(20)
         .setColorBackground(color(255, 128))
         .setColorActive(color(0))
         .setColorForeground(color(255, 100,0))
         .setOpen(false)
         .setHeight(60)
         ;

  filter.captionLabel().toUpperCase(true);
  filter.captionLabel().set("filter");
  filter.captionLabel().setColor(0xffff0000);
  filter.captionLabel().style().marginTop = 3;
  filter.valueLabel().style().marginTop = 3;
  
  
  ListBoxItem filtera;
  for(int i = 0; i < namefilter.length; i++)
  {
    filter.addItem(namefilter[i], i);
  }







  
  //////////////////////////  //////////////////////////  //////////////////////////  // create a toggle
  filter1.addToggle("Red1")
     .setPosition(480,20)
     .setSize(40,20)
     //.setCaptionLabel("Red");
     //.hide()
     ;
  filter1.addToggle("Green1")
     .setPosition(530,20)
     .setSize(40,20)
     //.hide()
     ;
  filter1.addToggle("Blue1")
     .setPosition(580,20)
     .setSize(40,20)
     //.hide()
     ;
     
  filter1.addSlider("ColorStrength")
     .setPosition(650,30)
     .setWidth(150)
     .setRange(1,4) // values can range from big to small as well
     .setValue(1)
     .setNumberOfTickMarks(4)
     .setSliderMode(Slider.FLEXIBLE)
     //.hide()
     ;
     
 //////////////////////////    //////////////////////////  //////////////////////////  
     
  filter2.addSlider("SquareSize")
     .setPosition(650,30)
     .setWidth(150)
     .setRange(1,50) // values can range from big to small as well
     .setValue(1)
     .setNumberOfTickMarks(5)
     .setSliderMode(Slider.FLEXIBLE)
     //.hide()
     ;  
  filter2.addToggle("Tint")
     .setPosition(860,20)
     .setSize(40,20)
     //.hide()
     ;  
  filter2.addToggle("Red2")
     .setPosition(480,20)
     .setSize(40,20)
     //.hide()
     ;
  filter2.addToggle("Green2")
     .setPosition(530,20)
     .setSize(40,20)
     //.hide()
     ;
  filter2.addToggle("Blue2")
     .setPosition(580,20)
     .setSize(40,20)
     //.hide()
     ;
     
 //////////////////////////  //////////////////////////  //////////////////////////  //////////////////////////      
     
  filter3.addToggle("Vertical/Horizontal")
     .setPosition(750,20)
     .setSize(60,15)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     //.hide()
     ;
  filter3.addSlider("SliderT")
     .setPosition(550,30)
     .setWidth(150)
     .setRange(1,4) // values can range from big to small as well
     .setValue(1)
     .setNumberOfTickMarks(4)
     .setSliderMode(Slider.FLEXIBLE)
     //.hide()
     ;  
     
      //////////////////////////  //////////////////////////  ////////////////////////// 
     
  filter4.addSlider("ContrastLevel")
     .setPosition(650,30)
     .setWidth(150)
     .setRange(1,50) // values can range from big to small as well
     .setValue(1)
     .setNumberOfTickMarks(5)
     .setSliderMode(Slider.FLEXIBLE)
     //.hide()
     ;
  filter4.addToggle("Red3")
     .setPosition(480,20)
     .setSize(40,20)
     //.hide()
     ;
  filter4.addToggle("Green3")
     .setPosition(530,20)
     .setSize(40,20)
     //.hide()
     ;
  filter4.addToggle("Blue3")
     .setPosition(580,20)
     .setSize(40,20)
     //.hide()
     ;    

cp5.addToggle("FilterOnOff")
     .setPosition(925,20)
     .setSize(60,15)
     .setValue(false)
     .setMode(ControlP5.SWITCH)
     //.hide()
     ;



 filter1.hide();
 filter2.hide();
 filter3.hide();
 filter4.hide();

  resetColors();

}
void draw() {


if (filtermode == 0 && FilterOnOff == true){
  //tempBeforeFilter= get();
  roundColorFilter(ColorStrength, Red1, Green1, Blue1); 
}
 
  
  PImage thing = get();
  if (filtermode == 1 && FilterOnOff == true){
   
   set(0, 0, thing);
   patchwork(SquareSize,Tint,color(0));
  
}

  
 if (filtermode == 2 && FilterOnOff == true && filter3i == 0){
   
   set(0, 0, thing);
   noiseWithPerlin(VerticalorHorizontal, sliderT);
  filter3i++;
 } 
if (filtermode == 3 && FilterOnOff == true){
 contrast(ContrastLevel, Red3,Green3, Blue3); 
 
} 
 
 
 if (filtermode == 2 && FilterOnOff == false){
   
   filter3i = 0;
 } 
//  if (filtermode == 3 && FilterOnOff == true){
//  tempBeforeFilter= get();
//  roundColorFilter(ColorStrength, Red1, Green1, Blue1);
//  
//}
//  else{
//   set(0,0,tempBeforeFilter);
//  }
if (filtermode != 5 && FilterOnOff == false)
{
  //image(tempBeforeFilter,0,0);
  
}
if (gridlinesint == 1){
  image(gridlines1,0,0);
}

//println(filter1.Red1.getState());
if (supportCheck(filepath)&& newphoto == 0 &&photomode == false)
{
tempBeforeImage = get();
image = loadImage(filepath);

photomode = true;
//println("photomode is true");
newphoto++;

}
//println(newphoto);
//println(photomode);
if (photomode = true && supportCheck(filepath))
{
  
  println("image is moving");
  image(tempBeforeImage, 0, 0);
  image(image , photoX, photoY);
  //if (click == true){
   photoX = mouseX-image.height/2;
   photoY = mouseY-image.width/2;//}
//   if (click  == false)
//   {
//     photoX = photoX;
//     photoY = photoY;
//   }

  
  
  
  
}  
  
  if (mousePressed) {
    if (state==1) {
      pencil();
    } //tool#1, pencil


      if (state==2) {
      eraser();
    }
    //tool#2, eraser

      if (state==6) {
      sprayCan();
    }//tool 3, spray can
  }
  //println(triangleCount+" "+triangleX1);
  oldmX=mouseX;
  oldmY=mouseY;
  resetColors();
  menus();
  
    fill(0);
  int textx = mouseX;
  int texty = mouseY-80;
  if (texty < 0){
    texty = 0;
  }
  text("Pixel Tracker: " +textx+", " + (texty), 855, 70);

  if(state == 8)
 {
  cursor(dropperIcon); 
 }
 else if (state != 8)
 {
  cursor(ARROW); 
 }
  
}

void mousePressed() {
  //print(triangleCount);
  if (state==3) {
    pointX=mouseX;
    pointY=mouseY;
    rectBP=get(0, 0, width, height);
  }//rect 
  else if (state==4) {
    lineSX=mouseX;
    lineSY=mouseY;
    lineBP=get(0, 0, width, height);
  }//square   
  else if (state==5) {
    ellipseX=mouseX;
    ellipseY=mouseY;
    ellipseBP=get(0, 0, width, height);
  } 
  else if (state==7) {
    triangleBP=get(0, 0, width, height);
  }
  //////////////////////////////////////////////////////////////////////
}//////////////////////////////////////////////////end of mousePressed
void mouseDragged() {
  strokeWeight(strokeWidth);
  if (state==3 && pointY>80) {
    image(rectBP, 0, 0, width, height);
    if (colorSelect == 1)
    {
      if (mouseButton == LEFT)
      {
      stroke(primary);
      fill(secondary);
      }
      if (mouseButton == RIGHT)
      {
      stroke(secondary);
      fill(primary);
      }
    }
    if (colorSelect == 2)
    {
      if (mouseButton == RIGHT)
      {
      stroke(primary);
      fill(secondary);
      }
      if (mouseButton == LEFT)
      {
      stroke(secondary);
      fill(primary);
      }
    }
    rectMode(CORNERS);
    rect(pointX, pointY, mouseX, mouseY);
  } 
  else if (state==4) {
    image(lineBP, 0, 0, width, height);
    if (colorSelect == 1)
    {
      if (mouseButton == LEFT)
      {
      stroke(primary);
      fill(secondary);
      }
      if (mouseButton == RIGHT)
      {
      stroke(secondary);
      fill(primary);
      }
    }
    if (colorSelect == 2)
    {
      if (mouseButton == RIGHT)
      {
      stroke(primary);
      fill(secondary);
      }
      if (mouseButton == LEFT)
      {
      stroke(secondary);
      fill(primary);
      }
    }
    line(lineSX, lineSY, mouseX, mouseY);
  } 
  else if (state==5 && ellipseY>80) {
    image(ellipseBP, 0, 0, width, height);
    if (colorSelect == 1)
    {
      if (mouseButton == LEFT)
      {
      stroke(primary);
      fill(secondary);
      }
      if (mouseButton == RIGHT)
      {
      stroke(secondary);
      fill(primary);
      }
    }
    if (colorSelect == 2)
    {
      if (mouseButton == RIGHT)
      {
      stroke(primary);
      fill(secondary);
      }
      if (mouseButton == LEFT)
      {
      stroke(secondary);
      fill(primary);
      }
    }
    ellipseMode(CORNERS);
    ellipse(ellipseX, ellipseY, mouseX, mouseY);
    ellipseMode(CENTER);
  } 
  else if (state==7) {
    image(triangleBP, 0, 0, width, height);
    if (triangleCount==3) {
      if (colorSelect == 1)
      {
        stroke(primary);
        fill(secondary);
      }
      if (colorSelect == 2)
      {
        stroke(secondary);
        fill(primary);
      }
      triangle(triangleX1, triangleY1, triangleX2, triangleY2, mouseX, mouseY);
      triangleCount=0;
    }
  }
}

void mouseReleased() {
  if (state==4) {
    rectMode(CORNERS);
    line(lineSX, lineSY, mouseX, mouseY);
  }
    if (newphoto == 1)
  {
    
    setPicture(image);
    photomode = false;
    println("photomode = false;");
    filepath = "                                                                                                                                                                                 ";
    newphoto = 0;
  }
}


void menus()
{
  noStroke();
  fill(140);
  rect(0, 0, 1200, 80);
  fill(255,0,0);
  ellipse(8,8,12,12);
  fill(255,255,0);
  ellipse(24,8,12,12);
  strokeWeight(2.1);
  stroke(100);
  line(5,5,10,10);
  line(10,5,5,10);
  line(20,8,26,8);
  //print(MouseInfo.getPointerInfo().getLocation() + " | ");
  ////////////////////////////////////////////////////////////
}////////////////////////////////////////////////////////draw

void mouseClicked() {
  if (sq(mouseX)+sq(24) < 144+64 && sq(mouseX)+576 > 144-576  &&  sq(mouseY)+64 < 144+64 && sq(mouseY)+64 > 144-64)
 {
      frame.setState(Frame.ICONIFIED);
  
 }
 if (sq(mouseX)+64 < 144+64 && sq(mouseX)+64 > 144-64  &&  sq(mouseY)+64 < 144+64 && sq(mouseY)+64 > 144-64)
 {
  exit();
  
 }
   
// if (
// frame.setState(Frame.ICONIFIED);
 //println(sq(mouseX)+64);
  if (state==8) {
    droplet();
  } 
  else if (state==7) {
    strokeWeight(1);
    fill(primary);
    stroke(secondary);
    if (triangleCount==0) {
      triangleCount=1;
    }
    if (triangleCount==1 &&  mouseY>80) {
      triangleX1=mouseX;
      triangleY1=mouseY;
      //ellipse(triangleX1, triangleY1,2,2);
      triangleCount=2;
    } 
    else if (triangleCount==2 && mouseY>80) {
      triangleX2=mouseX;
      triangleY2=mouseY;
      //ellipse(triangleX2, triangleY2,2,2);
      triangleCount=3;
    } 
    else if (triangleCount==3) {
      triangleX3=mouseX;
      triangleY3=mouseY;
      image(triangleBP, 0, 0, width, height);
      if (colorSelect == 1)
      {
        stroke(primary);
        fill(secondary);
      }
      if (colorSelect == 2)
      {
        stroke(secondary);
        fill(primary);
      }
      triangle(triangleX1, triangleY1, triangleX2, triangleY2, triangleX3, triangleY3);
      triangleCount=0;

    }
  }
 if (state != 8)
  {
    cursor(ARROW);
  }




  // }


  //////////////////////////////////////////////////////////////////////
}//////////////////////////////////////////////////end of mouseClicked



boolean square(int x, int y, int rad, int myx, int myy)
{

  if (x+rad>myx && x-rad<myx && y+rad>myy && y-rad<myy)
  {
    return true;
  }
  return false;
}







public void controlEvent(ControlEvent c) { //////////////////////////////////////////////color slider
  // when a value change from a ColorPicker is received, extract the ARGB values/////////
  // from the controller's array value
  if (c.isFrom(cp)) {
    int r = int(c.getArrayValue(0));
    int g = int(c.getArrayValue(1));
    int b = int(c.getArrayValue(2));
    int a = int(c.getArrayValue(3));
    color col = color(r, g, b, a);
    //println("event\talpha:"+a+"\tred:"+r+"\tgreen:"+g+"\tblue:"+b+"\tcol"+col);
  }
 
 

    if (c.isGroup()) {
    // an event from a group e.g. scrollList
    println(c.group().value()+" from "+c.group());
  }
  if(c.isGroup() && c.name().equals("File") && c.group().value() == 2.0){
    fill(255);
    rect(0,0,1000,1000);
  }
  if(c.isGroup() && c.name().equals("File") && c.group().value() == 3.0){
    exit();
  }
  if(c.isGroup() && c.name().equals("File") && c.group().value() == 4.0){
    save("image.tiff");
    save("image.png");
    save("image.jpg");
  }
  if(c.isGroup() && c.name().equals("File") && c.group().value() == 5.0){
    
    save("image.png");
  }
  if(c.isGroup() && c.name().equals("File") && c.group().value() == 6.0){

    save("image.jpg");
  }
  if(c.isGroup() && c.name().equals("File") && c.group().value() == 7.0){
    save("image.tiff");

  }
  
  if(c.isGroup() && c.name().equals("File") && c.group().value() == 0.0){

  selectInput("Select a file to process:", "fileSelected");
//println(filepath);
    //print(0);
}
if(c.isController()) { 
if(c.controller().name().equals("Red1")) {
      if(c.controller().value()==1){Red1 = true;
      }
      if(c.controller().value()==0){Red1 = false;
      }
}
if(c.controller().name().equals("Green1")) {
      if(c.controller().value()==1){Green1 = true;
      }
      if(c.controller().value()==0){Green1 = false;
      }
}
if(c.controller().name().equals("Blue1")) {
      if(c.controller().value()==1){Blue1 = true;
      }
      if(c.controller().value()==0){Blue1 = false;
      }
}
if(c.controller().name().equals("Red2")) {
      if(c.controller().value()==1){Red2 = true;
      }
      if(c.controller().value()==0){Red2 = false;
      }
}
if(c.controller().name().equals("Green2")) {
      if(c.controller().value()==1){Green2 = true;
      }
      if(c.controller().value()==0){Green2 = false;
      }
}
if(c.controller().name().equals("Blue2")) {
      if(c.controller().value()==1){Blue2 = true;
      }
      if(c.controller().value()==0){Blue2 = false;
      }
}
if(c.controller().name().equals("Red3")) {
      if(c.controller().value()==1){Red3 = true;
      }
      if(c.controller().value()==0){Red3 = false;
      }
}
if(c.controller().name().equals("Green3")) {
      if(c.controller().value()==1){Red3 = true;
      }
      if(c.controller().value()==0){Red3 = false;
      }
}
if(c.controller().name().equals("Blue3")) {
      if(c.controller().value()==1){Red3 = true;
      }
      if(c.controller().value()==0){Red3 = false;
      }
}
if(c.controller().name().equals("Tint")) {
      if(c.controller().value()==1){Red3 = true;
      }
      if(c.controller().value()==0){Red3 = false;
      }
}

if (c.controller().name().equals("SquareSize")){
SquareSize =int(c.controller().value());
}

if (c.controller().name().equals("ContrastLevel")){
ContrastLevel =int(c.controller().value());
}


if (c.controller().name().equals("Vertical/Horizontal")){
  if(c.controller().value()==1){
VerticalorHorizontal = true;}
if(c.controller().value()==0)
VerticalorHorizontal = true;}

if (c.controller().name().equals("SliderT")){
sliderT =int(c.controller().value());
}
} 
 if(c.isGroup() && c.name().equals("Filter") && c.group().value() == 0.0){
 filter1.show();
 filter2.hide();
 filter3.hide();
 filter4.hide();
 filtermode = 0;
 }
 if(c.isGroup() && c.name().equals("Filter") && c.group().value() == 1.0){
 filter1.hide();
 filter2.show();
 filter3.hide();
 filter4.hide();
 filtermode = 1;
 }
 if(c.isGroup() && c.name().equals("Filter") && c.group().value() == 2.0){
 filter1.hide();
 filter2.hide();
 filter3.show();
 filter4.hide();
 filtermode = 2;
 }
 if(c.isGroup() && c.name().equals("Filter") && c.group().value() == 3.0){
 filter1.hide();
 filter2.hide();
 filter3.hide();
 filter4.show();
 filtermode = 3;
 }
}

class MyColorPicker extends ColorPicker { ////allows for a resizing 
  MyColorPicker(ControlP5 cp5, String theName) {
    super(cp5, cp5.getTab("default"), theName, 0, 0, 100, 10);
  }

  void setItemSize(int w, int h) {
    sliderRed.setSize(w, h);
    sliderGreen.setSize(w, h);
    sliderBlue.setSize(w, h);
    sliderAlpha.setSize(w, h);

    // you gotta move the sliders as well or they will overlap
    sliderGreen.setPosition(PVector.add(sliderGreen.getPosition(), new PVector(0, h-10)));
    sliderBlue.setPosition(PVector.add(sliderBlue.getPosition(), new PVector(0, 2*(h-10))));
    sliderAlpha.setPosition(PVector.add(sliderAlpha.getPosition(), new PVector(0, 3*(h-10))));
  }
}

void eraser() {

  if (colorSelect == 1)
{
  if( mouseButton == LEFT)
  {
  fill(primary);
  stroke(primary);
  }
  
  
}
if (colorSelect == 2)
{

  if( mouseButton == LEFT)
  {
  fill(secondary);
  stroke(secondary);
  }
  
}
  strokeWeight(strokeWidth);
  line(mouseX, mouseY, oldmX, oldmY);
  noStroke();
}

void pencil() {
if (colorSelect == 1)
{
  if( mouseButton == LEFT)
  {
  fill(primary);
  stroke(primary);
  }
  if( mouseButton == RIGHT)
  {
  fill(secondary);
  stroke(secondary);
  }
  
}
if (colorSelect == 2)
{
  if( mouseButton == RIGHT)
  {
  fill(primary);
  stroke(primary);
  }
  if( mouseButton == LEFT)
  {
  fill(secondary);
  stroke(secondary);
  }
  
}
  strokeWeight(strokeWidth);
  line(mouseX, mouseY, oldmX, oldmY);
  noStroke();
}

void droplet() {
  color c=get(mouseX, mouseY);
if (colorSelect == 1)
{
  if (mouseButton==LEFT) { 
    primary=c;
    cp.setColorValue(color(c));
  }
  if (mouseButton==RIGHT) {
    secondary=c;
    cp1.setColorValue(color(c));
  }
}
if (colorSelect == 2)
{
  if (mouseButton==RIGHT) { 
    primary=c;
    cp.setColorValue(color(c));
  }
  if (mouseButton==LEFT) {
    secondary=c;
    cp1.setColorValue(color(c));
  }
}
}

void sprayCan() {
  strokeWeight(1);
float[] distributionx = new float[int(sq(strokeWidth))];
float[] distributiony = new float[int(sq(strokeWidth))];
if (colorSelect == 1)
  {
  if( mouseButton == LEFT)
    {
    fill(primary);
    stroke(primary);
    }
  if( mouseButton == RIGHT)
    {
    fill(secondary);
    stroke(secondary);
    }
}

if (colorSelect == 2)
{
  if( mouseButton == RIGHT)
  {
  fill(primary);
  stroke(primary);
  }
  if( mouseButton == LEFT)
  {
  fill(secondary);
  stroke(secondary);
  }

}
  {
  for (int i = 0; i < distributionx.length; i++) {
    distributionx[i] = int(randomGaussian() * strokeWidth/2);
  }
   for (int i = 0; i < distributiony.length; i++) {
    distributiony[i] = int(randomGaussian() * strokeWidth/2);
  }
  

  for (int i = 0; i < distributionx.length; i++) {
    float distx = distributionx[i];
    float disty = distributiony[i];
    point(mouseX+distx, mouseY+disty);
  }
}
//  ellipse(mouseX+random(-9, 9), mouseY+random(-9, 9), 1, 1);
//  ellipse(mouseX+random(-8, 8), mouseY+random(-9, 9), 1, 1);
//  ellipse(mouseX+random(-7, 7), mouseY+random(-9, 9), 1, 1);
//  ellipse(mouseX+random(-6, 6), mouseY+random(-9, 9), 1, 1);
//  ellipse(mouseX+random(-5, 5), mouseY+random(-9, 9), 1, 1);
//  ellipse(mouseX+random(-4, 4), mouseY+random(-9, 9), 1, 1);
}




ControlFrame addControlFrame(String theName, int theWidth, int theHeight, int I) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight, I);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  if (I == 1)
  {
    f.setLocation(100, 100);
  } 
  else
  {
    f.setLocation(1200, 100);
  }

  f.setResizable(false);
  f.setVisible(true);

  return p;
}
///////////for new windows


/////////////////////////////////////////////// the ControlFrame class extends PApplet, so we 
/////////////////////////////////////////////// are creating a new processing applet inside a
/////////////////////////////////////////////// new frame with a controlP5 object loaded
public class ControlFrame extends PApplet {


  int w, h, ID ;

  int abc = 100;
  ControlP5 cp5;

  Object parent;

  public void setup() {



    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);
    //MyColorPicker cp;
    //MyColorPicker cp1;
    if (ID == 1) //// color window
    {
      cp5 = new ControlP5(this);                                          ////
      cp = new MyColorPicker(cp5, "Primary");                          //// slider
      cp.setPosition(5, 5).setColorValue(color(255, 255, 255, 255));      ////
      cp.setItemSize(130, 20);                                             ////

      cp1 = new MyColorPicker(cp5, "Secondary");                          //// slider
      cp1.setPosition(5, 205).setColorValue(color(0, 0, 0, 255));      ////
      cp1.setItemSize(130, 20);
    } 
    else {


      cp5.addButton("+")
        .setValue(100)
          .setPosition(75, 400)
            .setSize(50, 50)
              ;
      cp5.addButton("-")
        .setValue(100)
          .setPosition(75, 490)
            .setSize(50, 50)
              .updateSize()
                ;
    }
  }

  public void draw() {
    background(200);
    if (ID == 1) ////color window
    {
      noStroke();
      primary = cp.getColorValue();
      secondary = cp1.getColorValue();
      strokeWeight(4.4);
      if (square(69, 138, 37, mouseX, mouseY)&&mousePressed)
      {
        colorSelect =1;
      }

      if (square(69, 338, 37, mouseX, mouseY)&&mousePressed)
      {
        colorSelect =2;
      }

      if (colorSelect == 1)
      {
        stroke(0);
      }
      fill(primary);////////primary squares
      rect(32, 100, 75, 75);
    
      
      noStroke(); 
      if (colorSelect == 2)
      {
        stroke(0);
      }
      fill(secondary);////////secondary squares
      rect(32, 300, 75, 75);
      noStroke(); 
      
//        stroke(0);
//      strokeWeight(2);
//      line(6,390,100,390);
//      noStroke();


      for (int i = 0; i < 8; i++)
      {
        for (int e = 0; e < 8; e++)
        {
          fill(customColors[i*8+e]);
          rect(10 + i*15, 410 + e *20, 12, 12);
        }
      }
    }  
    if (ID == 2)//////tool window
    {

      fill(2, 49, 80);
      rect(75, 462, 50, 20);
      fill(255);
      text(strokeWidth, 85, 475);
      image(pencil, 10, 50);
      image(eraser, 10, 50+45);
      image(square, 10, 50+45*2);
      image(line, 10, 50+45*3);
      image(ellipsey, 10, 50+45*4);
      image(spraycan, 10, 50+45*5);
      image(triangle, 10, 50+45*6);
      image(dropper, 10, 50+45*7);
      image(gridlines, 10, 50+45*8);
      //image(crop, 10, 50+45*9);
    }
  }
  public void mouseClicked()
  {
    if (ID == 1)
    {
      for (int i = 0; i < 8; i++)
      {
        for (int e = 0; e < 8; e++)
        {
          if (square( 16 + i*15, 410 + e *20 +6, 6, mouseX, mouseY))
                 //rect(10 + i*15, 410 + e *20, 12, 12);
          { 
            if (mouseButton == RIGHT)
            {
              if (colorSelect == 1)
              {
                primary = customColors[i*8+e] ;
                cp.setColorValue(color(primary));
              }
              if (colorSelect == 2)
              {
                secondary = customColors[i*8+e];
                cp1.setColorValue(color(secondary));
              }
            }

            if (mouseButton == LEFT)
            {
              if (colorSelect == 1)
              {
                customColors[i*8+e] = primary;
              }
              if (colorSelect == 2)
              {
                customColors[i*8+e] = secondary;
              }
            }
          }
        }
      }
    }
    if (ID == 2)
    {
      for (int i = 0; i < 11; i++)
      {
        if (square(15, 65 + i* 45, 30, mouseX, mouseY)) ////// this makes the buttons on the left side work
        {
          state = i+1;
        }
      }
     if (square(15, 65 + 8* 45, 30, mouseX, mouseY)){
      if (gridlinesint == 1)
      {
        gridlinesimage = get();
        set(0,0 ,gridlinesimage);
          
        
      }
      gridlinesint *= -1;
      
     }
      
      
      
      if (square(100, 515, 25, mouseX, mouseY))
      {
        strokeWidth -=1;
      }
      if (square(100, 425, 25, mouseX, mouseY))
      {
        strokeWidth +=1;
      }
      if (strokeWidth < 1)
      {
       strokeWidth = 1; 
      }
    }
  }


  //  public void controlEvent(ControlEvent theEvent) {
  //  //println(theEvent.getController().getName());
  //}

  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight, int I) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
    ID = I;
  }


  public ControlP5 control() {
    return cp5;
  }
}

void resetColors() {
  customColors[0] = (color(0));//black
  customColors[8] = color(255);//white
  customColors[16] = color(165, 42, 42);//brown
  customColors[24] = color(255, 0, 0);//red
  customColors[32] = color(255, 150, 0);//orange
  customColors[40] = color(255, 255, 0);//yellow
  customColors[48] = color(0, 255, 0);//green
  customColors[56] = color(0, 0, 255);//blue
  customColors[1] = color(255, 0, 255);//purple
  customColors[9] = color(0, 236, 255);//turquoise
}

void fileSelected(File selection) {
  if (selection == null) {
    println("null");
  } else { 
    filepath = selection.getAbsolutePath();
  }
}

boolean supportCheck(String filename){
  String ss1 = filename.substring(int(filename.length())-4);
  if ((ss1.equals(".jpg"))|| (ss1.equals(".png")  )|| (ss1.equals(".gif")))
  {
  return true;
  }
  String ss2 = filename.substring(int(filename.length())-5); 
  if (ss1.equals(".tiff"))
  {
  return true;
  }
  
  return false; 
}
void setPicture(PImage photo){
 for (int i = 0; i < photo.width; i++){
  for (int j = 0; j < photo.height; j++){
    stroke(photo.get(i,j));
   point(i+(photo.height/2-mouseY),j+(photo.width/2-mouseY));
    //+(mouseY-photo.height/2)
  }
}

}

void roundColorFilter(int sliderNumber, boolean red, boolean green, boolean blue){
int count;
int interval = 0;

//sliderNumber1-5

  for(int px=0; px<width; px++){
    for(int py=80; py<(height); py++){
        color c= get(px, py);
        //float r=red(c);
        float r=c>>16& 0xFF;
        float g=c >> 8 & 0xFF;;
        float b=c & 0xFF;
        
      if (sliderNumber==1) interval=20;
      else if (sliderNumber==2) interval=30;
      else if (sliderNumber==3) interval=40;
      else if (sliderNumber==4) interval=50;
      else if (sliderNumber==5) interval=100;
        
      if ( red==true){
        if (r<50) r=50;
        else if (r<50+interval) r=50+interval;
        else if (r<interval+interval+50) r=interval+interval+50;
        else if (r<interval+interval+interval+50) r=interval+interval+interval+50;
        else r=(4*interval)+50;
      }
      
      if ( green==true){
        if (g<50) g=50;
        else if (g<50+interval) g=50+interval;
        else if (g<interval+interval+50) g=interval+interval+50;
        else if (g<interval+interval+interval+50) g=interval+interval+interval+50;
        else g=(4*interval)+50;
      }
//      if ( green==true){
//        if (g<60) g=60;
//        else if (g<120) g=120;
//        else if (g<180) g=180;
//        else if (g<240) g=240;
//        else g=255;
//      }
      if ( blue==true){
        if (b<50) b=50;
        else if (b<50+interval) b=50+interval;
        else if (b<interval+interval+50) b=interval+interval+50;
        else if (b<interval+interval+interval+50) b=interval+interval+interval+50;
        else b=(4*interval)+50;
      }
        set(px, py, color(r, g, b));
    }
    
  }
  
  
  
}























////Filter 2: Patchwork-squareSize changes the size of the squares, tint is a boolean turns tint on and off, and tintColor changes the tint color to red green or blue
//PImage picture;
//color newColor;
//int suma,sumr,sumg,sumb;
//int a,r,g,b;
//int squareSize;
//boolean tint;
//color tintColor;
//int tintDirection;
//


void patchwork(int squareSize, boolean tint,color tintColor){

color newColor;
int suma,sumr,sumg,sumb;
int a,r,g,b;



int tintDirection;
 noStroke();
 for(int x=0;x<width;x+=squareSize){
  for(int y=80;y<height;y+=squareSize){
    if(tint==true){
      stroke(tintColor);  
      fill(255,255,255,0);
      rect(x,y,15,15);  
    }
    
    suma=0;
    sumr=0;
    sumg=0;
    sumb=0;
    for(int i=0;i<squareSize;i++){
     for(int j=0;j<squareSize;j++){
       color pixel=get(x+i,y+j);
       a = (pixel >> 24) & 0xFF;
       r = (pixel >> 16) & 0xFF; 
       g = (pixel >> 8) & 0xFF;   
       b = pixel & 0xFF;          
       suma+=a;
       sumr+=r;
       sumg+=g;
       sumb+=b;    
       if(tint==true){
         newColor=color(sumr/sq(squareSize),sumg/sq(squareSize),sumb/sq(squareSize),suma/sq(squareSize));  
         set(x+i,y+j,newColor); 
       }
     } 
    }
    if(x+squareSize<width && y+squareSize<height && tint==false){ 
      newColor=color(sumr/sq(squareSize),sumg/sq(squareSize),sumb/sq(squareSize),suma/sq(squareSize));  
      fill(newColor);
      rect(x,y,squareSize,squareSize);
    }  
      

  }
 } 
  
}















//Filter 3= noise with Perlin (need a better name)

//int numStudents = 40;
//int radius = 7;
//Random generator = new Random();
//PImage pic;
//int count;
//int interval;
//int sliderT; float t;

void noiseWithPerlin(boolean vertical,int sliderT){
int numStudents = 40;
int radius = 7;
Random generator = new Random();
PImage pic;
int count;
int interval;
float t = 0.1;
  noiseSeed((int)random(255));
 
  if (sliderT==1) t= 0.1;
  if (sliderT==2) t=0.01;
  if (sliderT==3) t=0.001;
  if(sliderT==4) t=0.0001;
  
 
  
  noStroke();
  
  if(vertical == true){
  for (int j = 0; j<width; j++){
    for(int i=80; i<height; i++){
      int r = int( map(noise(t), 0, 1,0,255) );
//      int g = int( map(noise(t), 0, 1,0,255) );
//      int b = int( map(noise(t), 0, 1,0,255) );
      println(r);
      stroke(r,40);
      point(j,i);

    
      t+=0.01;
//      z+=0.5;
//      f+=0.5;
    }
  }//perlin-random sequence, change from one to next is locally predicable
 
  } 
  
   if(vertical == false){
  for (int j = 0; j<height; j++){
    for(int i=80; i<width; i++){
      int r = int( map(noise(t), 0, 1,0,255) );
//      int g = int( map(noise(t), 0, 1,0,255) );
//      int b = int( map(noise(t), 0, 1,0,255) );
      println(r);
      stroke(r,40);
      point(i,j);

    
      t+=0.01;
//      z+=0.5;
//      f+=0.5;
    }
  }//perlin-random sequence, change from one to next is locally predicable
 
  }
}

























//Filter 4=Contrast: contrastLevel is how much it’s being contrasted, red, blue, green
//
//PImage picture;
//int constrastLevel;
//int count;
//boolean red,blue,green;
//


   



void contrast(int contrastLevel, boolean red, boolean green, boolean blue){
int constrastLevel;
int count;


 for(int i=0;i<width;i++){
  for(int j=80;j<height;j++){
    color c=get(i, j);
    int r=int(red(c));
    int g=int(green(c));
    int b=int(blue(c));  
    int biggest=findBiggest(r,g,b);
    if(biggest==r && red==true){
      color pixel=color(r+contrastLevel*(255-r)/5,g,b);
      set(i,j,pixel);
    }
    else if(biggest==g && green==true){
      color pixel=color(r,g+contrastLevel*(255-g)/5,b);
      set(i,j,pixel);
    }
    else if(biggest==b && blue==true){
      color pixel=color(r,g,b+contrastLevel*(255-b)/5);
      set(i,j,pixel);    
    }
  }
   
 }
  
}

int findBiggest(int a,int b,int c){
   int biggest;
   if(a>=b && a>=c){
      biggest=a;
    }
    else if(b>=c){
      biggest=b; 
    }
    else{
      biggest=c; 
    }
    return biggest;
}










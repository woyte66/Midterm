//// Midterm code for 59CST112

/**************************************************************
BE SURE TO CHANGE THE NEXT SEVERAL LINES, USING YOUR REAL NAME.

    MY FIRST NAME IS......Emmett
    MY MIDDLE NAME IS.....Calder
    MY LAST NAME IS.......Woytovich
    
PICK 3 WORDS THAT START WITH YOUR INITIALS, using lower case letters:

    first word............Emerald
    second word...........Cerulean
    third word............Wine
    
USE THESE 3 WORDS TO NAME ALL VARIABLES FOR 3 POOL BALLS.
(You may abbreviate any words, but start with same letter.)
***************************************************************/


//// GLOBALS FOR 3 colored balls ////
float ballD = 30;
float emeraldX,  emeraldY,  emeraldDX,  emeraldDY;          
float ceruleanX,  ceruleanY,  ceruleanDX,  ceruleanDY;              
float wineX,  wineY,  wineDX,  wineDY;      


//// OTHER GLOBALS:  strings, pool table, etc ////

String title=  "CST112 MIDTERM EXAM";
String news=   "Click any ball to reset it to right half of table.";
String buttons= "Red resets all, Green toggles the barrier, Purple sends the mouse, Blue toggles table color";
String author=  "Emmett Woytovich";

float left,right,top,bottom,wallH;        // Table boundaries

boolean wall=true;

int tableRed, tableGreen, tableBlue;      // green pool table


boolean pB = false;

float buttonS = 30;
boolean m;
float mx,my;
int numcol;
int counter;

//// SETUP:  size and table
void setup() {
    size( 700, 500 );    
    textAlign(CENTER,CENTER);
    rectMode( CORNERS );
    frameRate(60);
    left = 50;
    right = width - 50;
    top = 100;
    bottom = height - 50;
    wallH = left + (right - left) /2;
    
    mx = 0;
    my = height - 40;
    reset();
 }

void reset() {
  emeraldX = random(wallH + 20, right);  emeraldY = random(top,bottom);
  ceruleanX = random(wallH + 20, right); ceruleanY = random(top,bottom);
  wineX = random(wallH + 20, right);     wineY = random(top,bottom);
  
  if(dist(emeraldX,emeraldY, ceruleanX,ceruleanY) <= ballD) reset();
  if(dist(emeraldX,emeraldY, wineX,wineY) <= ballD)         reset();
  if(dist(wineX,wineY, ceruleanX,ceruleanY) <= ballD)       reset();
  
  emeraldDX = random(-5,5);  emeraldDY = random(-5,5);
  ceruleanDX = random(-5,5); ceruleanDY = random(-5,5);
  wineDX = random(-5,5);     wineDY = random(-5,5);
  
  pB = false;
  m = false;
  tableRed=150;   tableGreen=250;   tableBlue=150;
  numcol = 0;
  counter = 0;
}
//// NEXT FRAME:  table, bounce off walls, collisions, show all
void draw() {
  background( 250,250,200 );
  if(pB){ tableRed=242;tableGreen=129;tableBlue= 55;}
  else  { tableRed=150;tableGreen=250;tableBlue=150;}
  table( left, top, right, bottom );
  buttons();
  bounce();
  collisions();
  show();
  messages();
  mouse();
}

void mouse(){
  if(mx < width + 25 && m == true){
    mx += 5;
    counter++;
    fill(0); stroke(0);strokeWeight(5);
    if(counter/20%2 != 0){
      line(mx-5,my, mx-20,my+20);
      line(mx+5,my, mx+10,my+25);
    }
    else{
      line(mx-5,my, mx-10,my+25);
      line(mx+5,my, mx+20,my+20);
    }
    noStroke();
    fill(255); ellipse(mx,my, 50,30);
    fill(240,120,50); ellipse(mx+25,my,10,10);
    fill(0,0,200); ellipse(mx+17,my-5,6,9);
  }
}


//// HANDLERS:  keys, click
void keyPressed() {
  if (key == 'q') { exit();       }
  if (key == 'r') { reset();      }
  if (key == 'p') { 
    if (pB){pB = false;}
    else   {pB = true; }
    }
  if (key == 'w') { 
    if(wall) {wall = false; }
    else     {wall = true;  }
  }
  if (key == 'm') { mx = 0; m = true;     }
  if (key == '1') { 
    emeraldX = random(wallH + 20, right);emeraldY = random(top,bottom);
    emeraldDX = random(-5,5);emeraldDY = random(-5,5);
  }
  if (key == '2') {
  ceruleanX = random(wallH + 20, right);ceruleanY = random(top,bottom);
  ceruleanDX = random(-5,5);ceruleanDY = random(-5,5);
  }
  if (key == '3') {
  wineX = random(wallH + 20, right);wineY = random(top,bottom);
  wineDX = random(-5,5);wineDY = random(-5,5);
  }
}


//// SCENE:  draw the table with wall down the middle
void table( float east, float north, float west, float south ) {
  fill( tableRed, tableGreen, tableBlue );    // pool table
  strokeWeight(20);
  stroke( 127, 0, 0 );      // Brown walls
  rect( east-20, north-20, west+20, south+20 );

            //++++ MODIFY THIS CODE, as necessary. ++++

  // Start with a WALL down the middle of the table! 
  if (wall) {
    float middle=  (east+west)/2;    
    stroke( 0, 127, 0 );
    line( middle,north+10, middle,south-10 );
  }
  stroke(0);
  strokeWeight(1);
}

//// ACTION:  bounce off walls, collisions
void bounce() {
  
    if(wall){
      if(emeraldX<=wallH +10 && emeraldX >= wallH -10) emeraldDX = -emeraldDX;
      if(ceruleanX<=wallH +10 && ceruleanX >= wallH -10) ceruleanDX = -ceruleanDX;
      if(wineX<=wallH +10 && wineX >= wallH -10) wineDX = -wineDX;
    }
    
    emeraldX += emeraldDX; if(emeraldX<=left || emeraldX>=right) emeraldDX = -emeraldDX;
    emeraldY += emeraldDY; if(emeraldY<=top || emeraldY>=bottom) emeraldDY = -emeraldDY;
    
    ceruleanX += ceruleanDX; if(ceruleanX<=left || ceruleanX>=right) ceruleanDX = -ceruleanDX;
    ceruleanY += ceruleanDY; if(ceruleanY<=top || ceruleanY>=bottom) ceruleanDY = -ceruleanDY;
    
    wineX += wineDX; if(wineX<=left || wineX>=right) wineDX = -wineDX;
    wineY += wineDY; if(wineY<=top || wineY>=bottom) wineDY = -wineDY;
      
    
    
}
void collisions() {
    float temp;
    
    if(dist(emeraldX,emeraldY, ceruleanX,ceruleanY) <= ballD){
      temp = ceruleanDX; ceruleanDX = emeraldDX; emeraldDX = temp;
      temp = ceruleanDY; ceruleanDY = emeraldDY; emeraldDY = temp;
      numcol++;
    }
    
    if(dist(emeraldX,emeraldY, wineX,wineY) <= ballD){
      temp = wineDX; wineDX = emeraldDX; emeraldDX = temp;
      temp = wineDY; wineDY = emeraldDY; emeraldDY = temp;
      numcol++;
    }
    
    if(dist(ceruleanX,ceruleanY, wineX,wineY) <= ballD){
      temp = wineDX; wineDX = ceruleanDX; ceruleanDX = temp;
      temp = wineDY; wineDY = ceruleanDY; ceruleanDY = temp;
      numcol++;
    }
    
    
}


//// SHOW:  balls, messages, etc.
void show() {
    noStroke();
    
    fill(80,200,120); ellipse(emeraldX,emeraldY, ballD, ballD);
    fill(0);          text("Emerald", emeraldX,emeraldY);
    
    fill(0,123,167);  ellipse(ceruleanX,ceruleanY, ballD,ballD);
    fill(0);          text("Cerulean", ceruleanX, ceruleanY);
    
    fill(114,47,55);  ellipse(wineX,wineY, ballD,ballD);
    fill(0);          text("Wine", wineX,wineY);
    
}
void buttons() {
    fill(200,0,0); rect(10,33, 10 + buttonS,33 + buttonS);
    fill(0,200,0); rect(50,33, 50 + buttonS,33 + buttonS);
    fill(0,0,200); rect(width - 10 - buttonS,33, width - 10,33 + buttonS);
    fill(100,0,200); rect(width - 50 - buttonS,33, width - 50,33 + buttonS);
}

void mousePressed(){
  if(mouseY > 33 && mouseY < 33 + buttonS){
    if(mouseX > 10 && mouseX < 10 + buttonS) { reset(); }

    if(mouseX > 50 && mouseX < 50 + buttonS + buttonS) {
      if(wall) {wall = false; }
      else     {wall = true;  }
    }
 
    if(mouseX > width - 10 - buttonS && mouseX < width - 10) {
      if (pB){pB = false;}
      else   {pB = true; } 
    }
  
    if(mouseX > width - 50 - buttonS && mouseX < width - 50) { mx = 0; m = true; }
  }
  if(dist(mouseX,mouseY, emeraldX,emeraldY) < ballD){
    emeraldX = random(wallH + 20, right);emeraldY = random(top,bottom);
    emeraldDX = random(-5,5);emeraldDY = random(-5,5);
  }
  
   if(dist(mouseX,mouseY, ceruleanX,ceruleanY) < ballD){
    ceruleanX = random(wallH + 20, right);ceruleanY = random(top,bottom);
    ceruleanDX = random(-5,5);ceruleanDY = random(-5,5);
  }
  
  if(dist(mouseX,mouseY, wineX,wineY) < ballD){
    wineX = random(wallH + 20, right);wineY = random(top,bottom);
    wineDX = random(-5,5);wineDY = random(-5,5);
  }
}

void messages() {
  fill(0);
  text( title, width/2, 10 );
  text( news, width/2 +10, 25 );
  text( buttons, width/2 +10, 40 );
  text( author, 55, height-10 );
  text( numcol, width - 10,10);

 

}

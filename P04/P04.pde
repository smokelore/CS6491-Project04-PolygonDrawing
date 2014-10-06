/**************************** HEADER ****************************
 LecturesInGraphics: Template for Processing sketches in 2D
 Template author: Jarek ROSSIGNAC
 Class: CS3451 Fall 2014
 Student: Miranda Bradley and Sebastian Monroy
 Project number: 4
 Project title: Graphs!
 Date of submission: ??
 *****************************************************************/


//**************************** global variables ****************************

//*************** text drawn on the canvas for name, title and help  *******************
String title ="CS3451, Fall 2014, Project 04: Graphs!", name ="Miranda Bradley and Sebastian Monroy", // enter project number and your name
menu="?:(show/hide) help, !:snap picture, ~:(start/stop) recording frames for movie, Q:quit", 
guide="Press&drag mouse to move dot. 'x', 'y' restrict motion"; // help info
// velocityDisplay=Float.toString(velocity)

ArrayList<Corner> masterCs = new ArrayList<Corner>();
ArrayList<Vertex> masterVs = new ArrayList<Vertex>();
IntList masterFs = new IntList();

VertexHandler vertexHandler = new VertexHandler();

boolean mouseClick, mouseDrag;
PVector mouseDragStart;

//**************************** initialization ****************************
void setup() {               // executed once at the begining 
  size(600, 600);            // window size
  frameRate(30);             // render 30 frames per second
  smooth();                  // turn on antialiasing
  myFace = loadImage("data/pic.jpg");  // loads image from file pic.jpg in folder data, replace it with a clear pic of your face
  myFace2 = loadImage("data/pic2.jpg");
  power = loadImage("data/power.png"); // loads power image
  
  
  //hard coded points! for testing
  vertexHandler.AddVertex(50, 50, -1);
  vertexHandler.AddVertex(250, 250, 0);
  vertexHandler.AddVertex(300, 400, 1);
  vertexHandler.AddVertex(400, 250, 2);
  vertexHandler.AddVertex(100, 250, 1);
 // vertexHandler.AddVertex(55, 55, 1);

  //PVector temp = new PVector(-1,0);
  //println("/////////" + temp.heading());
}

//**************************** display current frame ****************************
void draw() {      // executed at each frame
  background(white); // clear screen and paints white background
  pen(black, 3); // sets stroke color (to balck) and width (to 3 pixels)

  if (keyPressed) {
    fill(black); 
    text(key, mouseX-2, mouseY);
  } // writes the character of key if still pressed
  if (!mousePressed && !keyPressed) scribeMouseCoordinates(); // writes current mouse coordinates if nothing pressed

  displayHeader();
  if (scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 
  if (filming && (animating || change)) saveFrame("FRAMES/"+nf(frameCounter++, 4)+".tif");  
  change=false; // to avoid capturing frames when nothing happens
  // make sure that animating is set to true at the beginning of an animation and to false at the end

  displayEdges();
  displayVertices();
  displayCorners();
  
}  // end of draw()


//************************* mouse and key actions ****************************
void keyPressed() { // executed each time a key is pressed: the "key" variable contains the correspoinding char, 
  if (key=='?') scribeText=!scribeText; // toggle display of help text and authors picture
  if (key=='!') snapPicture(); // make a picture of the canvas
  if (key=='~') { 
    filming=!filming;
  } // filming on/off capture frames into folder FRAMES
  if (key==' ') {

  } // reset the blue ball at the center of the screen
  if (key=='a') animating=true;  // quit application
  if (key=='Q') exit();  // quit application
  change=true;
}

void keyReleased() { // executed each time a key is released
  if (key=='b') {

  }
  if (key=='a') animating=false;  // quit application
  change=true;
}

void mouseDragged() { // executed when mouse is pressed and moved
  change=true;
  mouseDrag = true;
}

void mouseMoved() { // when mouse is moved
  change=true;
}

void mousePressed(MouseEvent e) { // when mouse key is pressed 
  mouseClick = true;
  mouseDragStart = new PVector(mouseX, mouseY);
}

void mouseReleased(MouseEvent e) { // when mouse key is released 
  mouseClick = false;
  mouseDragStart = new PVector();
  mouseDrag = false;
}

public Corner GetCornerFromID(int cornerID) {
  return masterCs.get(cornerID);
}
 
public Vertex GetVertexFromCornerID(int cornerID) {
  return masterVs.get(masterCs.get(cornerID).vertex);
}

public Vertex GetVertexFromID(int vertexID) {
  return masterVs.get(vertexID);
}




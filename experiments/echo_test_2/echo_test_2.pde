// to instlly peasy cam library, tools > Add tools > search for "peasy"
import peasy.*;
PeasyCam cam;

float angle = 10;
float w = 10;
float ma;
float maxD;

void setup() {
  size(1000, 1000, P3D);
  lights();
  ma = atan(1/sqrt(10));
  maxD = dist(10 , 10, 100, 100);
  
  smooth();

  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(1000);
}

void draw() {
  background(255);
  pointLight(90, 255, 200, mouseX, mouseY, 1000);
  
  
  ortho(-width/2, width/2, -height/2, height/2);

  rotateX(-.5);
  rotateY(-.5);
  
  float detail = 700;
 
  for (float z = 0; z < detail; z += w) {
    for (float x = 0; x < detail; x += w) {
      pushMatrix();
      float d = dist(x, z, detail / 2, detail / 2);
      float offset = map(d, 0, maxD, -PI, 1 );
      float a = angle + offset;
      float h = floor(map(sin(a), -1, 1, 100, 300));
      translate(x - detail / 2, 0, z - detail / 2);

      //objects
      box(w - 1, h/2.5, w - 1);

  
      popMatrix();
    }
  }
  
  // this changes the speed
  angle -= 0.01;
}



void createUI() {
  
}
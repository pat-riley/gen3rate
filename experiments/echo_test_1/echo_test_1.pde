// to instlly peasy cam library, tools > Add tools > search for "peasy"
import peasy.*;
PeasyCam cam;

float angle = 10;
float w = 10;
float ma;
float maxD;

void setup() {
  size(800, 800, P3D);
  ma = atan(1/sqrt(10));
  maxD = dist(10 , 10, 100, 100);
  
  smooth();
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(1000);
}

void draw() {
  background(100);
  
  ortho(-width/2, width/2, -height/2, height/2);

  rotateX(-.5);
  rotateY(-.5);
  
  for (float z = 0; z < height; z += w) {
    for (float x = 0; x < width; x += w) {
      pushMatrix();
      float d = dist(x, z, width / 2, height / 2);
      float offset = map(d, 0, maxD, -PI, PI );
      float a = angle + offset;
      float h = floor(map(sin(a), -1, 1, 100, 300));
      translate(x - width / 2, 0, z - height / 2);

      //objects
      box(w - 2, h/2, w - 2);
      //sphere(h/2);
      
      popMatrix();
    }
  }
  
  // this changes the speed
  angle -= 0.05;
}
// to run, copy and paste this in a new PDE and then run

let angle = 10;
let w = 10;
let ma;
let maxD;

function setup() {
  createCanvas(600, 600, WEBGL);
  ma = atan(1/sqrt(10));
  maxD = dist(10 , 10, 100, 100);
}

function draw() {
  background(100);
  ortho(-400, 400, -400, 400, 0, 1000);
  rotateY(mouseX/50);
  rotateX(mouseY/50);
  
  for (let z = 0; z < height; z += w) {
    for (let x = 0; x < width; x += w) {
      push();
      let d = dist(x, z, width / 2, height / 2);
      let offset = map(d, 0, maxD, -PI, PI );
      let a = angle + offset;
      let h = floor(map(sin(a), -1, 1, 100, 300));
      translate(x - width / 2, 0, z - height / 2);
      normalMaterial();
      box(w - 2, h/2, w - 2);
      sphere(h/50);
      //rect(x - width/2 + w / 2, 0, w - 2, h);
      pop();
    }
  }
  
  angle -= 0.05;
}
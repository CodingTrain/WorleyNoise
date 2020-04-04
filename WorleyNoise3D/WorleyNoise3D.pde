import peasy.PeasyCam;

PVector[] features;
float angle = 0;
PeasyCam cam;

void setup() {
  size(800, 800, P3D);
  cam = new PeasyCam(this, 1600);
  features = new PVector[50];
  for (int i = 0; i < features.length; i++) {
    features[i] = new PVector(
      random(-width/2, width/2), 
      random(-width/2, width/2), 
      random(-width/2, width/2));
  }
}

void draw() {
  background(0);
  //loadPixels();
  //float z = sin(angle) * (width/2);
  int skip = 50;
  for (int x = -width/2; x < width/2; x+=skip) {
    for (int y = -width/2; y < width/2; y+=skip) {
      for (int z = -width/2; z < width/2; z+=skip) {
        float[] distances = new float[features.length];
        for (int i = 0; i < features.length; i++) {
          PVector v = features[i];
          distances[i] = dist(x, y, z, v.x, v.y, v.z);
        }
        distances = sort(distances);
        int n = 1;
        float d = distances[n];
        float sz = map(d, 0, width/8, skip, 0);
        push();
        translate(x, y, z);
        noStroke();
        fill(255, 50);
        box(sz);
        pop();
      }
    }
  }
  //updatePixels();

  //for (int i = 0; i < features.length; i++) {
  //  PVector v = features[i];
  //  v.x += random(-5, 5);
  //  v.y += random(-5, 5);
  //  v.z += random(-5, 5);
  //}

  // println(frameRate);

  //for (int i = 0; i < features.length; i++) {
  //  float sw = map(features[i].z, 0, width, 4, 20);
  //  strokeWeight(sw);
  //  stroke(255, 0, 0);
  //  point(features[i].x, features[i].y);
  //}
  // noLoop();

  //angle += 0.01;
  //saveFrame("worley/worley####.png");
}

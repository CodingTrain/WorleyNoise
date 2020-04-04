Particle[] features;
float angle = 0;
void setup() {
  size(640, 360);
  features = new Particle[20];
  for (int i = 0; i < features.length; i++) {
    features[i] = new Particle();
    //colorMode(HSB,255);
  }
}

void draw() {
  background(0);
  loadPixels();
  float z = sin(angle) * (width/2);
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int index = x + y * width;

      float[] distances = new float[features.length];
      for (int i = 0; i < features.length; i++) {
        PVector v = features[i].position;
        // 3D features
        // float z = map(mouseX, 0, width, -width/2, width/2);
        distances[i] = dist(x, y, z, v.x, v.y, v.z);
        // 2D features
        // distances[i] = dist(x, y, v.x, v.y);
      }
      distances = sort(distances);
      //int n = 3;
      float d0 = distances[0];
      float d1 = distances[1];
      float d2 = distances[2];
      float r = map(d1, 0, width/4, 255, 20) * 2;
      float g = map(d2, 0, width/4, 255, 20) * 2;
      float b = map(d0, 0, width/4, 255, 20) * 2;
      pixels[index] = color(r, g, b);
    }
  }
  updatePixels();

  //for (int i = 0; i < features.length; i++) {
  //  PVector v = features[i];
  //  v.x += random(-5, 5);
  //  v.y += random(-5, 5);
  //  v.z += random(-5, 5);
  //}


  for (int i = 0; i < features.length; i++) {
    Particle p = features[i];
    //p.display();
    p.update();
  }

  // angle += 0.01;
  // saveFrame("worley/worley####.png");
}

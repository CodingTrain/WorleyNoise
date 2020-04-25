import peasy.PeasyCam;

int[] ct = {
  color(146, 83, 161), 
  color(240, 99, 164), 
  color(45, 197, 244), 
  color(252, 238, 33), 
  color(241, 97, 100), 
  color(112, 50, 126), 
  color(164, 41, 99), 
  color(11, 106, 136), 
  color(248, 158, 79), 
  color(146, 83, 161), 
  color(236, 1, 90)
};

PVector[] features = new PVector[20];
float angle = 0;
//PeasyCam cam;

int counter = 0;
boolean slice = false;
float y = 400;
PImage wnoise;

boolean showNoise = true;

int state = 0;

boolean render = false;


void setup() {
  size(800, 800, P3D);
  wnoise = createImage(800, 800, RGB);
  //cam = new PeasyCam(this, 1600);
  for (int i = 0; i < features.length; i++) {
    float x = random(-400, 400);
    float y = random(-400, 400);
    float z = random(-400, 400);
    features[i] = new PVector(x, y, z);
  }
  frameRate(30);
}

void draw() {
  background(ct[0]);
  //lights();
  hint(ENABLE_DEPTH_SORT);

  translate(width/2, height/2, -800);
  rotateX(-PI/8);
  rotateY(-PI/6 + frameCount * 0.005);
  stroke(ct[2]);
  strokeWeight(8);
  noFill();
  box(800);

  if (showNoise) {
    counter = features.length;
    slice = true;
  }
  for (int i = 0; i < counter; i++) {
    PVector p = features[i];
    push();
    noStroke();
    fill(ct[3]);
    translate(p.x, p.z, p.y);
    sphere(16);
    pop();
  }

  if (frameCount > 60) {
    if (frameCount % 2 == 0) {
      if (counter < features.length) {
        counter+=2;
      } else {
        slice = true;
      }
    }
  }

  if (showNoise) {
    wnoise.loadPixels();
    float z = y;
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        int index = x + y * width;

        float[] distances = new float[features.length];
        for (int i = 0; i < features.length; i++) {
          PVector v = features[i];
          // 3D features
          // float z = map(mouseX, 0, width, -width/2, width/2);
          distances[i] = dist(x-400, y-400, z, v.x, v.y, v.z);
          // 2D features
          // distances[i] = dist(x, y, v.x, v.y);
        }
        distances = sort(distances);
        float d0 = distances[0];
        float r = map(d0, 0, width/2, 300, 0);
        wnoise.pixels[index] = color(r);
      }
    }
    wnoise.mask(wnoise);
    wnoise.updatePixels();
  }




  if (slice) {
    float extent = 450;

    float w = wnoise.width;
    strokeWeight(4);
    stroke(ct[1]);
    if (showNoise) {
      noFill();
    } else {
      fill(ct[1], 175);
    }
    translate(0, y, 0);
    beginShape(QUAD);
    vertex(-extent, 0, -extent, -w, -w);
    vertex(extent, 0, -extent, w, -w);
    vertex(extent, 0, extent, w, w);
    vertex(-extent, 0, extent, -w, w);
    endShape();
    y-=10;

    if (showNoise) {
      imageMode(CENTER);
      rotateX(PI/2);
      image(wnoise, 0, 0);
    }
    y = constrain(y, -400, 400);
  }

  if (render) {
    saveFrame("cube2/cube2####.png");
  }
}

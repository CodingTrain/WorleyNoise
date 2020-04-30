PVector[] seed = new PVector[7];

void setup() {
  size(400, 400);
  for (int i = 0; i < seed.length; i++) {
    seed[i] = new PVector(random(width), random(height), random(width));
  }
}

void draw() {


  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int index = x + y * width;
      float[] distances = new float[seed.length];
      for (int i = 0; i < seed.length; i++) {
        PVector v = seed[i];
        //distances[i] = dist(x, y, width/2, v.x, v.y, v.z);
        distances[i] = dist(x, y, v.x, v.y);
      }
      distances = sort(distances);
      float d = map(distances[0],0,width/2,255,0);
      color c = color(d);
      pixels[index] = c;
    }
  }
  updatePixels();
  
   
  int offset = 0;
  for (PVector v : seed) {
    stroke(0, 255, 0);
    strokeWeight(8);
    point(v.x, v.y);
    v.x = map(noise(offset + frameCount * 0.005),0,1,-100,width+100);
    v.y = map(noise(offset + 100000 + frameCount * 0.005),0,1,-100,height+100);
    offset+=1000;
  }
  
  saveFrame("perlin/worley####.png");
}

//this tab declares new class Particles

class Particles
{
  float x;
  float y;
  color c;
  float r, g, b;
  int i, j;
  
 //Particles and void display are functions within the class
  Particles(int wide, int high, color vid, float red, float green, float blue, int pos)
  {
    x = wide;
    y = high;
    c = vid;
    r = red;
    g = green;
    b = blue;
    i = pos;
  }
  
  void display()
  {
    for(int p = 0; p < 5000; p++) //generates ellipses 5000 at a time. this speed is required so the soundwaves being produced in draw dont cover up the video image
    {
      x = random(width);
      y = random(height/20*19-5);
      c = video.get(int(x), int(y)); //pulls colour from video
      /*
        video is not played but rather the ellipses pull from the frames
        that the video produces and uses them as their fill
      */
      fill(c, song.mix.get(i) * 500); //sets video colours as fill for elipses
      strokeWeight(1);
      stroke(r, g, b, song.mix.get(i) * 100); //adds a sound reactive outline to the ellipses
      ellipse(x, y, 10, 10);
    }
  }
}
/*
    Steven Tynan - 12147095
    EndTerm Project CS4049
    
    This project is an artistic visualisation of sound and aims to visually
    depict the feeling of increased excitement and energy a good song can
    give to the listener. The song used in this project is 'Starboy' by 'The
    Weeknd' and I have selected this song due to the depth in the levels and
    the exciting tone to the song, as well as the fact that it has in recent
    times been quite popular in the charts and so is relevent to a current
    work such as this. I use the minim and processing video libraries in this
    project. The inspiration for this piece came from the artistic videos
    created by Petra Cortright and the code was created using what I've
    learned throughout my time in the course as well as with the help of
    processing's help and tutorials and videos by Daniel Schiffman.
*/

//first import libraries
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.video.*;

//declare variables/classes
AudioPlayer song;
Minim minim;
Particles p;

Capture video;
float r, g, b;
int i, j;
int x, y;
color c;

//setup - load files and classes and set size and background
void setup()
{
  size(1280, 720);
  video = new Capture(this, 1280, 720, 26); //sets what video to capture as well as resolution and framerate
  video.start(); //starts the webcam
  minim = new Minim(this); //creates new minim
  song = minim.loadFile("Starboy.mp3", 2048); //loads the file to the variable
  song.loop(); //plays the song in loop
  background(0);
}

void draw()
{
  p = new Particles(x, y, c, r, g, b, i);
  p.display();    //pulls display function from particles class
  
  //for loops to apply the sound sensitive lines and effects
  for (int i = 0; i < song.bufferSize() - 1; i++)
  {
    for (int j = 0; j < 3; j++)
    {
      r = song.mix.get(i) * 300;
      g = 150 - r;
      b = 200 - g - (r/3*2);
      stroke(r, g, b, song.mix.get(i) * 800);
      strokeWeight(3);
      //sound waves
      line(width*j/3 + width/6 + song.mix.get(i)*200, i, width*j/3 + width/6 + song.left.get(i+1)*200, i+ 1);
      line(i, height*j/3 + song.mix.get(i)*200, i+1, height*j/3 + song.left.get(i+1)*200);
    }
  
  }
  
  playHead(); //set up as function and called in draw
  
}

void playHead()
{
  //map converts the length of the song to cositions on the canvas
  float position = map( song.position(), 0, song.length(), width/20, width/20*19);
  strokeWeight(1);
  fill(255);
  stroke(0);
  rect(0, height/20 * 19, width, height/20);
  fill(255,150,0);
  rect(width/20, height/20 * 19, width/20 * 18, height/20);
  triangle(width/40 - 10, height/40*39 - 10, width/40 - 10, height/40*39 + 10, width/40 + 10, height/40*39); //play button
  rect(width/40*39 - 13, height/40*39 - 10, 10, 20); //pause button
  rect(width/40*39 + 3, height/40*39 - 10, 10, 20);
  strokeWeight(5);
  stroke(255);
  line(position, height/20 * 19, position, height ); //playhead marker- shows where song is on timeline
}

void captureEvent(Capture video)  //event to ensure video is captured
{
  video.read();
}

void mousePressed()
{
  // choose a position to cue to based on where the user clicked.
  // the length() method returns the length of recording in milliseconds.
  if(width/20 < mouseX && width/20*19 > mouseX && mouseY > height/20*19) //click to jump to point in song
  {
    int position = int( map( mouseX, width/20, width/20*19, 0, song.length() ) );
    song.cue( position );
  }
  if(0 < mouseX && mouseX < width/20 && mouseY > height/20*19) //play
  {
    song.loop();
  }
  if(width/20*19 < mouseX && mouseX < width && mouseY > height/20*19) //pause
  {
    song.pause();
  }
}
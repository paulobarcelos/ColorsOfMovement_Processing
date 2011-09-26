import javax.media.opengl.*;
import processing.opengl.*;
import processing.video.*;

Capture video;
ColorsOfMovement  cm;
int w, h;

void setup (){
  w = 640;
  h = 480;
  
  Capture.list();// calling this here before size, as a dirty quick fix to avoing a bug when using capture & OPENGL (see more at http://processing.org/bugs/bugzilla/882.html)
  size(w,h, OPENGL);
  
  video = new Capture(this, w, h, 30);
  
  cm = new ColorsOfMovement(); 
  cm.setup( w,    // width
            h,    // height
            30);  // stored frames
}

void draw(){
 if (video.available()) {
    video.read();
    
    PImage img = createImage(w, h, ARGB);
    for (int i = 0; i < video.pixels.length; i++) img.pixels[i] = video.pixels[i];
    
    cm.update(img); // send in a pImage
  
    background(0);
    cm.draw(0, 0, w, h, true);  
 }
}

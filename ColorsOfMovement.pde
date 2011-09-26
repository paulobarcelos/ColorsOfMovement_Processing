/*
 *  ColorsOfMovement
 *
 *  Created by Paulo Barcelos on 09/22/2011.
 *  Copyright 2011 Paulo Barcelos. All rights reserved.
 *
 */
 class ColorsOfMovement
{
  private int       numStoredFrames;
  private int       w, h;
  Vector<PImage>    imgs;
  private boolean   ready;
  
  ColorsOfMovement (){
    imgs = new Vector<PImage>();
    ready = false;
  }
  
  void setup (int w, int h, int numStoredFrames){
    this.numStoredFrames = numStoredFrames;
    imgs.clear();
    ready = false;
  }
  
  void update (PImage img){
    imgs.add(img);
    if(imgs.size() > numStoredFrames){
      imgs.remove(0);
      ready = true;
    }
    else ready = false;
  }
  
  void draw(float x, float y, float w, float h, boolean flipHorizontal){
    w = w*2;
    h = h*2;
    if(ready){
      PGraphicsOpenGL pgl = (PGraphicsOpenGL) g;
      GL gl = pgl.beginGL();
  
      gl.glPushMatrix();
       gl.glEnable(GL.GL_BLEND);
       gl.glTranslatef(x, y, 0);
       if(flipHorizontal)gl.glTranslatef(w/2,0,0);
       if(flipHorizontal)gl.glScalef(-1.f, 1.f, 1.f);  
       
       gl.glBlendFunc(GL.GL_CONSTANT_COLOR, GL.GL_ONE);
        gl.glBlendColor(255,0,0,255);
       image(imgs.firstElement(),0 ,0, w, h);
  		
       gl.glBlendColor(0,255,0,255);
       image(imgs.elementAt(numStoredFrames / 2),0 ,0, w, h);
  		
       gl.glBlendColor(0,0,255,255);
       image(imgs.elementAt(numStoredFrames-5),0 ,0, w, h); // Accessing the 4 last elements is giving a memory leak! WTF!
  		
       gl.glBlendFunc(GL.GL_SRC_ALPHA, GL.GL_ONE_MINUS_SRC_ALPHA);       
       gl.glDisable(GL.GL_BLEND);
      gl.glPopMatrix();  
      pgl.endGL();
    }
  }
  
  boolean isReady(){
    return ready;
  }
}

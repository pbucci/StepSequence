class VideoThread extends Thread {
// Video objects
PImage prevFrame;
Capture video;

// Thread controllers
boolean running;
int wait = 100;

// Video fields
float threshold = 50;
int w = 320;
int h = 240;
int num;

// When building a new VideoThread, set it to not running
// and initialize the video capture sequence
VideoThread() {
 running = false;
 video = new Capture(StepSequence.this, w, h, 10);
}

// On start, set thread to running, and run video
void start() {
 running = true;
 // Create an empty image the same size as the video
 prevFrame = createImage(video.width,video.height,RGB);
 video.start(); 
 super.start();
}

// While we're running, run the video sampler
void run() {
  while(running) {
    runVideo();
  }
}

int getNum() { return num; }

// Samples video
void runVideo() {
  // Capture video
  if (video.available()) {
    // Save previous frame for motion detection
    prevFrame.copy(video,0,0,video.width,video.height,0,0,video.width,video.height); // Before we read the new frame, we always save the previous frame for comparison!
    prevFrame.updatePixels();
        try {
        sleep((long)(wait));
      } catch (Exception e) {
      }
    video.read();
  }
  
  video.loadPixels();
  prevFrame.loadPixels();
  
  num = 0;
  
  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      
      int loc = x + y*video.width;            // Step 1, what is the 1D pixel location
      color current = video.pixels[loc];      // Step 2, what is the current color
      color previous = prevFrame.pixels[loc]; // Step 3, what is the previous color
      
      // Step 4, compare colors (previous vs. current)
      float r1 = red(current); float g1 = green(current); float b1 = blue(current);
      float r2 = red(previous); float g2 = green(previous); float b2 = blue(previous);
      float diff = dist(r1,g1,b1,r2,g2,b2);
      
      // Step 5, How different are the colors?
      // If the color at that pixel has changed, then there is motion at that pixel.
      if (diff > threshold) {
        num++;
      }
    }
  }
 }
}

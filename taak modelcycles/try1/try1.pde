import themidibus.*;

MidiBus myBus;

PVector[] channels;

int oldPitch_1 = 0;

void setup() {

  size(800, 800);
  blendMode(DIFFERENCE);
  background(0, 0, 0, 10);

  MidiBus.list();

  myBus = new MidiBus(this, 0, 3);

  channels = new PVector[6];

  channels[0] = new PVector(0, 0);
  channels[1] = new PVector(0, 0);
  channels[2] = new PVector(0, 0);
  channels[3] = new PVector(0, 0);
  channels[4] = new PVector(0, 0);
  channels[5] = new PVector(0, 0);
}

void draw() {

  background(0);

  //CHANNEL 1: KICK
  if (channels[0].x != 0 && channels[0].y != 0) { 
    kickFunction();
  }

  //CHANNEL 2: HAT / BELL
  if (channels[1].x != 0 && channels[1].y != 0) { 
    hatFunction();
  }

  //CHANNEL 3: SNARE
  if (channels[2].x != 0 && channels[2].y != 0) { 
    snareFunction();
  }

  //CHANNEL 4: LEAD 1 
  if (channels[3].x != 0 && channels[3].y != 0) { 
    lead1Function();
  }

  //CHANNEL 5: LEAD 2
  if (channels[4].x != 0 && channels[4].y != 0) { 
    lead2Function();
  }

  //CHANNEL 6: CHORDS
  if (channels[4].x != 0 && channels[4].y != 0) { 
    chordsFunction();
  }
}


//----------------------------------CHANNEL 1 : KICK----------------------------------------//

float kickDelay = 1;
float kickNoise;
float r;

void kickFunction() {

  float kickPitch = channels[0].x;
  float kickVel = map(channels[0].y, 0, 127, 0, 20);

  noStroke();

  //float kickPos = map(channels[0].x, 127, 0, height/4, height/4 * 3);

  for (int i = 0; i < kickVel; i++) {

    float kickSize = map(i, 0, 127, 50, height);

    if (kickDelay != 0) {

      for (int w = 0; w < width; w += int((width / (kickDelay + 1)))) {

        float wiggle = noise(frameCount) * kickNoise;

        if (kickNoise > 64) {

          pushMatrix();

          translate(width/2, height/2);
          scale(0.5);
          rotate(r);
          ellipse(w + wiggle, height/2, kickSize / kickDelay, kickSize / kickDelay);

          popMatrix();

          r += kickDelay;
        } else {

          ellipse(w + wiggle + ((width / (kickDelay + 1))) * 0.5, height/2, kickSize / kickDelay, kickSize / kickDelay);
        }
      }
    } else {
      ellipse(width/2, height/2, kickSize, kickSize);
    }
  }

  //ellipse(width/2, height/2, kickPitch, kickVel);
}

void t1_Controller(int number, int value) {

  if (number == 12) {

    kickDelay = map(value, 0, 127, 0, 5);
  }

  if (number == 17) {

    kickNoise = value;
  }
}


//-------------------------------CHANNEL 2 : HAT-------------------------------------------//

void hatFunction() {

  float cowPitch = channels[1].x;
  float cowVel = channels[1].y;

  rectMode(CENTER);

  //stroke(0);

  //strokeWeight(10);

  if (oldPitch_1 < cowPitch) {
    strokeWeight(10);
  } else {
    strokeWeight(2);
  }

  for (int i = 0; i < width; i += int(width / cowPitch)) {

    stroke(255);
    //strokeWeight(map(hatContour, 0, 127, 10, 2));
    line(i, 0, i, height);

    int horizontalColor = int(map(hatContour, 0, 127, 255, 0));
    //println(horizontalColor);
    stroke(horizontalColor);

    line(0, i, width, i);


    //println(i);
  }

  oldPitch_1 = int(cowPitch);

  //noStroke();
  //rect(width/2, height/2, cowPitch, cowVel);
}

float hatColor;
float hatContour;

void t2_Controller(int number, int value) {

  if (number == 16) {

    hatColor = value;
  }
  if (number == 19) {

    hatContour = value;
  }
}


//-------------------------------CHANNEL 3 : SNARE-------------------------------------------//

int snareColor;
int snareShape;
int snareSweep;
int snareContour;
int snareDelay;

void snareFunction() {

  float snarePitch = channels[2].x;
  float snareVel = channels[2].y;

  stroke(255);
  strokeWeight(map(snarePitch, 0, 127, 2, 10));

  //if(
  //line(width/2 - hatVel, height/2 - hatPitch, width/2 + hatPitch, height/2 + hatVel);

  for (int i = 0; i < snareColor; i++) {

    line(random(width), random(height), random(width), random(height));
  }
}

void t3_Controller(int number, int value) {

  if (number == 16) {
    snareColor = value;
  }
  if (number == 17) {
    snareShape = value;
  }
  if (number == 18) {
    snareSweep = value;
  }
  if (number == 19) {
    snareContour = value;
  }
}


//------------------------------------CHANNEL 4-------------------------------------------//

void lead1Function() {

  float lead1Pitch = map(channels[3].x, 127, 0, 0, width);
  float lead1Vel = map(channels[3].y, 0, 127, 0, height);
}

void t4_Controller(int number, int value) {
  
  
  
}


//------------------------------------CHANNEL 5-------------------------------------------//


void lead2Function() {

  float lead2Pitch = map(channels[4].x, 127, 0, 0, width);
  float lead2Vel = map(channels[4].y, 0, 127, 0, height);
}

void t5_Controller(int number, int value) {
}


//------------------------------------CHANNEL 6-------------------------------------------//


void chordsFunction() {
}

void t6_Controller(int number, int value) {
}

void noteOn(int channel, int pitch, int velocity) {

  channels[channel] = new PVector(pitch, velocity);

  if (channel == 0) {
    println("1" + ' ' + pitch + ' ' +  velocity);
  }

  if (channel == 1) {
    println("2" + ' ' + pitch + ' ' +  velocity);
  }

  if (channel == 2) {
    println("3" + ' ' + pitch + ' ' +  velocity);
  }

  if (channel == 3) {
    println("4" + ' ' + pitch + ' ' +  velocity);
  }
}

void noteOff(int channel, int pitch, int velocity) {

  channels[channel] = new PVector(0, 0);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange

  if (channel == 0) {
    t1_Controller(number, value);
  }

  if (channel == 1) {
    t2_Controller(number, value);
  }

  if (channel == 2) {
    t3_Controller(number, value);
  }

  if (channel == 3) {
    t4_Controller(number, value);
  }

  if (channel == 4) {
    t5_Controller(number, value);
  }

  if (channel == 5) {
    t6_Controller(number, value);
  }

  println("Controller " + "c" + channel + "n" + number + "v" + value);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

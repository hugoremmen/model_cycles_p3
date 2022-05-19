import themidibus.*;

MidiBus myBus;

PVector[] channels;

void setup() {

  size(800, 800);
  blendMode(DIFFERENCE);
  background(0);

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

  background(255);

  //CHANNEL 1: KICK
  if (channels[0].x != 0 && channels[0].y != 0) { kickFunction(); }

  //CHANNEL 2: HAT / BELL
  if (channels[1].x != 0 && channels[1].y != 0) { hatFunction(); }
  
  //CHANNEL 3: SNARE
  if (channels[2].x != 0 && channels[2].y != 0) { snareFunction(); }
  
  //CHANNEL 4: LEAD 1 
  if (channels[3].x != 0 && channels[3].y != 0) { lead1Function(); }

  //CHANNEL 5: LEAD 2
  if (channels[4].x != 0 && channels[4].y != 0) { lead2Function(); }
  
  //CHANNEL 6: CHORDS
  if (channels[4].x != 0 && channels[4].y != 0) { chordsFunction(); }
}

void kickFunction() {

  float kickPitch = map(channels[0].x, 127, 0, 0, width);
  float kickVel = map(channels[0].y, 0, 127, 0, height);

  noStroke();
  ellipse(width/2, height/2, kickPitch, kickVel);
}

void hatFunction() {

  float cowPitch = map(channels[1].x, 127, 0, width/2, width);
  float cowVel = channels[1].y;

  rectMode(CENTER);
  
  noStroke();
  rect(width/2, height/2, cowPitch, cowVel);
}

void snareFunction() {

  float snarePitch = channels[2].x;
  float snareVel = channels[2].y;

  stroke(255);
  strokeWeight(map(snarePitch, 0, 127, 2, 10));

  //if(
  //line(width/2 - hatVel, height/2 - hatPitch, width/2 + hatPitch, height/2 + hatVel);
  line(random(width), random(height), random(width), random(height));
}

void lead1Function() {

  float lead1Pitch = map(channels[3].x, 127, 0, 0, width);
  float lead1Vel = map(channels[3].y, 0, 127, 0, height);
}

void lead2Function() {

  float lead2Pitch = map(channels[4].x, 127, 0, 0, width);
  float lead2Vel = map(channels[4].y, 0, 127, 0, height);
}

void chordsFunction() {
}

void noteOn(int channel, int pitch, int velocity) {

  channels[channel] = new PVector(pitch, velocity);

  if (channel == 0) {
    println("kick" + ' ' + pitch + ' ' +  velocity);
  }

  if (channel == 1) {
    println("cow" + ' ' + pitch + ' ' +  velocity);
  }

  if (channel == 2) {
    println("snare" + ' ' + pitch + ' ' +  velocity);
  }

  if (channel == 3) {
    println("bass" + ' ' + pitch + ' ' +  velocity);
  }
}

void noteOff(int channel, int pitch, int velocity) {

  channels[channel] = new PVector(0, 0);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

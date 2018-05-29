/* Licença GPL3 - mas atribuição é apreciada!
   Desenho com potenciômetros 
   Arduino + Firmata All Inputs + Potenciômetros  
 Alexandre Villares http://abav.lugaralgum.com
 arteprog - arte e programação http://arteprog.space
 Apresentada originalmente na inauguraço do SESC 24 de maio com Estúdio Hacker
 http://estudiohacker.io
 http://twitter.com/estudiohacker
 */

import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

void setup() {
  size(512, 512);
  //fullScreen();
  frameRate(30);
  noStroke();
  background(0);
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
}

void draw() {
  float X = map(arduino.analogRead(1), 0, 1023, 0, width);
  float Y = map(arduino.analogRead(4), 0, 1023, 0, height);
  fill(random(256), random(256), random(256));
  ellipse(X, Y, 20, 20);
  boolean tilt = (arduino.digitalRead(13) == arduino.HIGH);
  if (tilt) {
    background(0);
  }
}

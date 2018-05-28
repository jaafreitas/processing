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
float a, b, c, d;
int lousaID = 1;

void setup() {
  size(512, 512);
  //fullScreen();
  colorMode(HSB);  // para usar HSB em vez de RGB!
  frameRate(30);
  noStroke();
  background(0);
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
}

void draw() {
  if (keyPressed) {
    if (key == '2') {
      lousaID = 2;
    } else {
      lousaID = 1;
      noStroke();
      background(0);
    }
  }
  if (lousaID == 1) {
    boolean tilt = (arduino.digitalRead(13) == arduino.HIGH);
    if (tilt) {
      background(0);
    }
  
    float X = map(arduino.analogRead(1), 0, 1023, 0, width);
    float Y = map(arduino.analogRead(4), 0, 1023, 0, height);
  
    float tam = arduino.analogRead(2) / 10;  // Tamanho
    float opa = arduino.analogRead(3) / 4;  // Opacidade/Alpha
    float sat = 255;  // Saturação
    
    float F = frameCount;
    // Note modo HSB no setup! (Matiz, Saturação, Brilho, Alfa)
    fill(F % 255, sat, 255, opa);
    ellipse(X, Y, tam, tam);
  }
  else {    
    background(0);
    frameRate(30);
    strokeWeight(2);

    a = map(arduino.analogRead(1), 0, 1023, 0, HALF_PI); // ângulo
    b = map(arduino.analogRead(2), 0, 1023, 0, 10);      //randomização do tamanho do galho
    c = map(arduino.analogRead(3), 0, 1023, -2, 2);      // randomização do ângulo
    d = map(arduino.analogRead(4), 0, 1023, 0, 10);      // profundidade da recursão

    randomSeed(int(d * 10));
    pushMatrix();
    translate(width / 2, height / 2);
    branch(d, a, width / 25 + (width / 75) * b);
    popMatrix();
  }  
}

void branch(float gen, float theta, float branch_size) {
    strokeWeight(gen);
    float cor = (map(gen, 0, d, 255, 0) + frameCount) % 256;
    stroke(cor, 255, 255);
    //# All recursive functions must have an exit condition!!!!
    float h;
    if (gen > 1) {
        pushMatrix();
        h = branch_size * (1 - random(b / 3, b) / 15);
        rotate(theta + c * random(1));  // Rotate by theta
        line(0, 0, 0, -h);  // Draw the branch
        translate(0, -h);  // Move to the end of the branch
        // Ok, now call myself to draw two branches!!
        pushStyle();
        branch(gen - 1, theta, h);
        popStyle();
        popMatrix();              
              
        pushMatrix();
        h = branch_size * (1 - random(b / 3, b) / 15);
        rotate(-theta + c * random(1));
        line(0, 0, 0, -h);
        translate(0, -h);
        pushStyle();
        branch(gen - 1, theta, h);
        popStyle();
        popMatrix();
    }
}

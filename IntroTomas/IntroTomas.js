var unit = 40;
var count;
var mods = [];

function setup() {
  createCanvas(1280, 720);
  noStroke();
  var wideCount = width / unit;
  var highCount = height / unit;
  count = wideCount * highCount;

  var index = 0;
  for (var y = 0; y < highCount; y++) {
    for (var x = 0; x < wideCount; x++) {
      mods[index++] = new Module(x*unit, y*unit, unit/2, unit/2,
        random(0.02, 0.5), unit);
    }
  }
}

function draw() {
  background(255);

  // fill(0);
  // textSize(10);
  // text(Math.trunc(frameRate()), 50, 50);

  fill(255);
  if (frameCount < 600) {
    for (var i = 0; i < count; i++) {
      mods[i].update();
      mods[i].draw();
    }
  }
  if ((frameCount > 25) && (frameCount <= 175)) {
    mostraTexto(frameCount - 25 + 10, "Tomás Valsecchi");
  }
  if ((frameCount > 175) && (frameCount <= 275)) {
    mostraTexto((frameCount - 175) * 2, "Games");
  }
  if ((frameCount > 250) && (frameCount <= 350)) {
    mostraTexto((frameCount - 250) * 2, "vlogs");
  }
  if ((frameCount > 325) && (frameCount <= 425)) {
    mostraTexto((frameCount - 325) * 2, "etc");
  }
  if ((frameCount > 425) && (frameCount <= 575)) {
    mostraTexto(frameCount - 425 + 10, "Tomás Valsecchi");
  }
  // console.log(frameCount);
}

function mostraTexto(tamanhoFonte, texto) {
  fill(color(62, 132, 249, tamanhoFonte * 2));
  textSize(tamanhoFonte);
  textAlign(CENTER);
  text(texto, width / 2, height / 2);
}

function Module(_xOff, _yOff, _x, _y, _speed, _unit) {
  this.xOff = _xOff;
  this.yOff = _yOff;
  this.x = _x;
  this.y = _y;
  this.speed = _speed;
  this.unit = _unit;
  this.xDir = 1;
  this.yDir = 1;
  this.size = random(30, 60);
  this.color = color(random(255), random(255), random(255), 50);
  // Custom method for updating the variables
  this.update = function() {
    this.x = this.x + (this.speed * this.xDir);
    if (this.x >= this.unit || this.x <= 0) {
      this.xDir *= -1;
      this.x = this.x + (1 * this.xDir);
      this.y = this.y + (1 * this.yDir);
    }
    if (this.y >= this.unit || this.y <= 0) {
      this.yDir *= -1;
      this.y = this.y + (1 * this.yDir);
    }
  }
  // Custom method for drawing the object
  this.draw = function() {
    fill(this.color);
    ellipse(this.xOff + this.x, this.yOff + this.y, this.size, this.size);
  }
}

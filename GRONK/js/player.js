class Player {
  constructor() {
    this.body = [];
    this.body.push({x: width/2, y: height/2});
    this.playerRadius = width/GRID_SIZE;
    this.dir = 0;
    this.health = 100;
    this.currentSprite = 0;
  }
//player looks
  draw() {
    for (let b of this.body) {
      image(sprites[this.currentSprite], b.x - this.playerRadius, b.y - this.playerRadius, this.playerRadius * 2, this.playerRadius * 2);
    }
  } //end draw()

  move() {
//player movement when arrow keys held down
    if (keyIsDown(RIGHT_ARROW)) {
      this.body[0].x += 2;
      this.currentSprite = 12;
    } else if (keyIsDown(DOWN_ARROW)) {
      this.body[0].y += 2;
      this.currentSprite = 0;
    } else if (keyIsDown(LEFT_ARROW)) {
      this.body[0].x -= 2;
      this.currentSprite = 4;
    } else if (keyIsDown(UP_ARROW)) {
      this.body[0].y -= 2;
      this.currentSprite = 8;
    } else {
      this.currentSprite = 0;
    }
    this.body[0].x = constrain(this.body[0].x, this.playerRadius, width - this.playerRadius);
    this.body[0].y = constrain(this.body[0].y, this.playerRadius, height - this.playerRadius - 70);
  } //end move()

//detect collision with rat
  ratEncounter(rat) {
    let ratRadius = min(width, height) / (2 * GRID_SIZE);
    let d = dist(this.body[0].x, this.body[0].y, rat.x, rat.y);
    if (d < this.playerRadius + ratRadius) {
      return true;
    } else {
      return false;
    }
  } //end ratEncounter()

  defeatRat(rat) {
    rat.defeated = true;
    rat.visible = false;
  }

  swordGet() {
    let d = dist(this.body[0].x, this.body[0].y, sword.x, sword.y);
    if (d < GRID_SIZE) {
      return true;
    } else {
      return false;
    }
  } //end swordGet()

}
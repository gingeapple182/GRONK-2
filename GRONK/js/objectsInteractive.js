class Rat {
  constructor() {
    this.x = 0;
    this.y = 0;
    this.ratRadius = min(width, height) / (2 * GRID_SIZE); // Define ratRadius here
    this.spawn();
    this.visible = true;
    this.defeated = false;
  }
//allow rat to respawn after encounter
  spawn() {
    console.log('Rat spawned!');
    //randomise spawning location
    let randX, randY;
    do {
      randX = random(10 + this.ratRadius, width - 10 - this.ratRadius);
      randY = random(10 + this.ratRadius, height - 70 - this.ratRadius);
    } while (dist(randX, randY, this.x, this.y) < GRID_SIZE || dist(randX, randY, width / 2, height / 2) < 100);
    this.x = randX - randX % (width / GRID_SIZE) + width/(2*GRID_SIZE);
    this.y = randY - randY % (height / GRID_SIZE) + height/(2*GRID_SIZE);
    // Ensure the rat is within the correct area
    this.x = constrain(this.x, 10 + this.ratRadius, width - 10 - this.ratRadius);
    this.y = constrain(this.y, 10 + this.ratRadius, height - 70 - this.ratRadius);
}
//rat looks
  draw() {
    if (this.visible) {
      fill(128, 128, 128);
      circle(this.x, this.y, this.ratRadius * 2);
    }
  }
}

class Sword {
  constructor() {
    this.x = 660;
    this.y = 20;
    this.visible = true;
  }
  spawn() {
    this.x = 660; // reset x position
    this.y = 20; // reset y position
    this.visible = true; // make the sword visible
  }
  draw() {
    if (this.visible) {
      image(knifeImage, this.x, this.y, 30, 30);
    }
  }
}
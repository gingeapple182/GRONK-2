//GAME STATES FOR HYPERTEXT INTERACTIVITY

function fightEncounter(creature, encounterText, hpLoss) {
  console.log(creature + " encounter function called");
  currentScreen = 5;
  image(screens[currentScreen], 0,0, 700, 700);
  textAlign(CENTER);
  noStroke();
  fill(255);
  textSize(40);
  text('ENCOUNTER', width/2, height/9);
  textAlign(LEFT);
  textSize(20);
  drawText(encounterText, width/12, height/4, 20, 250);
  text("Press 'f' to fight", width/2, height - height/3+30);
  text("Press 'r' to run away", width/2, height - height/3+60);
  fill(255, 0, 0);
  textSize(12);
  text("Lose 10HP", width/2+200, height - height/3+60);
  if (!weapon) {
    text("Lose " + hpLoss + "HP", width/2+200, height - height/3+30);
  } else {
    text('')
  }
  currentScreen = 4;
  image(screens[currentScreen], 0,0, 700, 700);
}

function encounterOutcome(creature, encounterText, outcome, hpLoss, ) {
  console.log(creature + "outcome function called");
  currentScreen = 5;
  image(screens[currentScreen], 0,0, 700, 700);
  textAlign(CENTER);
  noStroke();
  fill(255);
  textSize(40);
  text('ENCOUNTER', width/2, height/9);
  textAlign(LEFT);
  textSize(20);
  drawText(encounterText, width/12, height/4,20, 250);
  text(outcome, width/2, height - height/3+30);
  text("Press 'r' to run away", width/2, height - height/3+60);
  currentScreen = 4;
  image(screens[currentScreen], 0,0, 700, 700);
}

function encounterMisc(misc, encounterTitle, encounterText, outcome) {
  console.log(misc + "outcome function called");
  currentScreen = 5;
  image(screens[currentScreen], 0,0, 700, 700);
  textAlign(CENTER);
  noStroke();
  fill(255);
  textSize(40);
  text(encounterTitle, width/2, height/9);
  textAlign(LEFT);
  textSize(20);
  drawText(encounterText, width/12, height/4, 20, 250);
  drawText(outcome, width/12, height - height/3+30, 20, 500);
  text('Press enter to continue', width/2, height - height/3+60);
  currentScreen = 4;
  image(screens[currentScreen], 0,0, 700, 700);
}

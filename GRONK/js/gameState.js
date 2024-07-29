//this file contains functions which handle the various screens of the core game

function playGame() {
  console.log('playGame function called');
  //levelReached = levelReached + 1; //future levels needed
  textSize(15);
  drawMap();
  player.move();
  player.draw();
  sword.draw();

  //create rats, only 5 at a time, after first 5 defeated stop spawning
  for (let rat of rats) { 
    rat.draw();
    if (player.ratEncounter(rat)) {
      gameState = 'RAT_ENCOUNTER';
      if (ratsDefeated <= 5) {
        console.log('Spawning rat...');
        rat.spawn();
      }
      if (ratsDefeated >= 5) {
        console.log('Dont spawn rat!');
        player.defeatRat(rat);
        rat.spawn();
      }
    } else {
      encounter = '';
    }
  //load in visuals for main game screen
  currentScreen = 1;
  image(screens[currentScreen], 0,0, 700, 700);
  healthBar();
  objective();
  if (weapon == false) {  //can also use (!weapon)
    weaponBox();
  } else {
    weaponEquipped();
    console.log('Weapon found');
  }
  }
  
  if (player.swordGet() && weapon === false) {
    weapon = true;
    sword.visible = false;
    gameState = "WEAPON_FOUND";
  }
  //win/loss condition
  if (player.health <= 0){
    gameState = 'YOU_DIED';
  }
  if (ratsDefeated === 10) {
    gameState = 'VICTORY';
  }
  gameData.level = levelReached;
}

function startMenu() {
  console.log("startMenu function called");
  textAlign(LEFT);
  currentScreen = 0;
  image(screens[currentScreen], 0,0, 700, 700);
  noStroke();
  fill(255);
  textSize(25);
  text("Press enter to start", width/4, height/2);
  //textSize(20);
  text("Press L for leaderboards", width/4, height-(height/3));
  textSize(15);
  text("Created by gingeapple182", width - width/3, height - height / 15);
}

function introductions() {
  console.log('introductions function called');
  textAlign(LEFT);
  currentScreen = 2;
  image(screens[currentScreen], 0, 0, 700, 700);
  noStroke();
  fill(255);
  textSize(25);
  text("What is your name?", width/4, height/2);
  
  // Position the input box relative to the canvas
  let canvasPos = canvas.position();
  nameInput.position(canvasPos.x + width/4 - 350, canvasPos.y + height/2 + 40/* - 350*/);
  nameInput.show(); // Show the input box
  playerName = nameInput.value();
  //update gameData for JSON
  gameData.name = playerName;
}

function leaderBoard() {
  console.log('leaderBoard function called');
  textAlign(LEFT);
  currentScreen = 3;
  image(screens[currentScreen], 0, 0, 700, 700);
  noStroke();
  fill(255);
  textSize(25);
  text("Leaderboard", width/4, height/4);
  //load in and how data from JSON file
  if (leaderBoardData) {
    let leaderBoardText = '';
    for (let i = 0; i<5; i++) {
      if (leaderBoardData[i]) {
        leaderBoardText += (i+1) + '. ' + leaderBoardData[i].name + '\n\n';
       } else { 
        leaderBoardText += (i+1) + '. \n\n';
       }
    }
    drawText(leaderBoardText, width/4, height/4+50, 20, 400);
  }
  text("Press R to return to menu", (width/4), height-(height/5));
}

function levelStart() {
  console.log("levelStart function called");
  currentScreen = 2;
  image(screens[currentScreen], 0,0, 700, 700);
  fill(255);
  textSize(25);
  textAlign(LEFT);
  drawText(playerName + " you must defeat the rats surrounding us!\n\nPress enter to start!", width/4, height/2.5, 25, 250);
  textSize(20);
} 

function pauseScreen() {
  console.log("pauseScreen function called");
  currentScreen = 3;
  image(screens[currentScreen], 0,0, 700, 700);
  fill(255);
  textSize(32);
  textAlign(CENTER);
  text("Game Paused", width/2, height/2);
  textSize(25);
  text("Press 'p' to resume", width/2, height/2+40);
  text("Press 'q' to quit to main menu", width/2, height/2+70);
}

function victory() {
  console.log("victory function called");
  //end timer and calculate play time
  if (!gameEnded) {
    endTime = Date.now();
    gameEnded = true;
  }
  let elapsedTime = ((endTime - startTime)/60000).toFixed(2);
  currentScreen = 3;
  image(screens[currentScreen], 0,0, 700, 700);
  fill(255);
  textSize(40);
  textAlign(LEFT);
  text("Congratulations!", width/4, height/2);
  textSize(25);
  text("Press enter to quit to main menu", width/4, height/2+40);
  text('Time elapsed playing: ' + elapsedTime + ' minutes.', width/4, height/2+70);
  gameData.playTime = elapsedTime;
}  

function youDied() {
  console.log("youDied function called");
  currentScreen = 3;
  image(screens[currentScreen], 0,0, 700, 700);
  fill(255, 0, 0);
  noStroke();
  textSize(40);
  textAlign(LEFT);
  text("You died", width/3, height/3);
  textSize(25);
  text("Press space to continue", width/3, height/3+30);
}

function gameOver() {
  console.log("gameOver function called");
    //end timer and calculate play time
  if (!gameEnded) {
    endTime = Date.now();
    gameEnded = true;
  }
  let elapsedTime = ((endTime - startTime)/60000).toFixed(2);
  currentScreen = 3;
  image(screens[currentScreen], 0,0, 700, 700);
  fill(255, 0, 0);
  textSize(40);
  textAlign(LEFT);
  text("Game Over", width/3, height/3);
  textSize(25);
  text("Press space to restart", width/3, height/3+30);
  text("Press 'r' to go back to home", width/3, height/3+60);
  if (elapsedTime < 1) {
    elapsedTime = elapsedTime * 60;
    text(playerName + ' survived for: ' + elapsedTime + ' seconds.', width/3, height/3+90);
  } else {
    text(playerName + ' survived for: ' + elapsedTime + ' minutes.', width/3, height/3+90);
  }
  gameData.playTime = elapsedTime;
}

function newGame() {
  console.log("newGame function called");
  gameState = "PLAY";
  player.body[0] = {x: width/2, y: height/2};
  player.health = 100;
  sword.spawn();
  weapon = false;
  sword.visible = true;
}

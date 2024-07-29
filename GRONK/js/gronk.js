//MAIN SETUP AND CONTROLS OF GRONK

// Declare the size of the grid
const GRID_SIZE = 25;
let canvas;
//player + enemy
let player, playerName, sword, rats = [];
let encounter = "", ratsDefeated = 0, weapon = false;
let levelReached = 0;
//misc
let startTime, endTime;
let nameInput;
let textBox;
let cubes = [];
let gameState = "START_MENU", gameEnded = false;
//images
let screenState, screenSize = 700, screens = [], currentScreen = 0;
let playerImage, knifeImage, spriteSize = 320, sprites = [];
let gameDataSaved = false, leaderBoardData;
let gameData = {
  name: '',
  level: 0,
  playTime: 0
};

function loadLeaderboard() {
  loadJSON('leaderboard.json', data => {
    leaderBoardData = data;
  });
}

function preload() {
  screenState = loadImage('images/screenStates.png'); //load in ui templates
  playerSprite = loadImage('images/playerJacketSheet.png'); //load in player sprites
  knifeImage = loadImage('images/knifeBasic.png'); //load in weapon sprite
}

// Setup function: creates the canvas, initializes the characters, and generates the cubes
function setup() {
  canvas = createCanvas(700, 700);
  canvas.id('myCanvas');
  nameInput = createInput();
  nameInput.hide();
  player = new Player();
  loadLeaderboard();
  //load spritesheet for game screens
  for (let i = 0; i < 2; i++) {
    for (let j = 0; j < 3; j++) {
      let img = screenState.get(j * screenSize, i * screenSize, screenSize, screenSize);
      screens.push(img);
    }
  }
  //load spritesheet for player
  for (let i = 0; i < 4; i++) {
    for (let j = 0; j < 4; j++) {
      let img = playerSprite.get(j * spriteSize, i * spriteSize, spriteSize, spriteSize);
      sprites.push(img);
    }
  }
  sword = new Sword();
  //spawn in first 5 rats to screen
  for (let i = 0; i < 5; i++) {
    rats[i] = new Rat();
  }
}

function resetGame() {
  // Reset all game variables to their initial state
  player = new Player();
  sword = new Sword();
  rats = [];
  for (let i = 0; i < 5; i++) {
    rats[i] = new Rat();
  }
  ratsDefeated = 0;
  weapon = false;
  encounter = "";
  noStroke();
}

// Draw function: called continuously by p5.js, controls game logic
function draw() {
  // Game state logic
  switch (gameState) {
    case "PLAY":
      playGame();
      break;    
    case "PAUSE":
      pauseScreen();
      break;
    case "START_MENU":
      startMenu();
      break;
    case "LEADERBOARD":
      leaderBoard();
      break;
    case "INTRODUCTIONS":
      introductions();
      break;
    case "START_OBJECTIVE":
      levelStart();
      break;
    case "YOU_DIED":
      youDied();
      break;
    case "GAME_OVER":
      gameOver();
      if (!gameDataSaved) {
        saveJSON(gameData, 'gameData.json');
        gameDataSaved = true;
      }
      break;
    case "VICTORY":
      victory();
      if (!gameDataSaved) {
        saveJSON(gameData, 'gameData.json');
        gameDataSaved = true;
      }
      resetGame();
      break;
    case "WEAPON_FOUND":
      encounterMisc(
        'weapon found', 
        'WEAPON FOUND', 
        'You have found a rusted sword in a bush.\n\n' +
        'You decide to take it with you to defend yourself.', 
        'Weapon obtained - Rusted Sword'
      );
      break;
    case "RAT_ENCOUNTER":
      if (weapon) {
        fightEncounter(
          'rat',
          'You have encountered a wild rat.\n' + 
          '\nYou now have a rusted sword to defend yourself.\n' +
          '\nYou can choose to attack it to scare it off, or try to get away.',
          20
        );
      } else {  
        fightEncounter(
          'rat', 
          'You have encountered a wild rat.\n\n' +
          'It seems just as scared of you as you are of it.\n\n' +
          'You can choose to attack it to scare it off, or try to get away.', 
          20
        );
      }
      break;
    case "RAT_FIGHT":
      if (!weapon) {
        encounterOutcome(
          'rat', 
          'You have encountered a wild rat.\n\n' +
          'You tried to fight the rat without a weapon.\n\n' +
          'You lost.', 
          'Lost 20 HP', 
          20
        );
      } else {
        encounterOutcome(
          'rat', 
          'You have encountered a wild rat.\n\n' +
          'You swung your sword wildly.\n\n' +
          'You defeated the rat.\n\n' +
          'You feel guilty that you murdered an innocent rat.  You monster.', 
          'Rat Defeated', 
          0
        );
      }
      break;
    case "RAT_BITE":
      encounterOutcome(
        'rat', 
        'You have encountered a wild rat.\n\n' +
        'You tried to run away.\n\n' +
        'The rat bit your ankle as you tried to run.', 
        'Lost 10 HP', 
        10
      );
      break;
  }
}

function keyPressed() 
{
  if (key === 'f' || key === 'F'){
    if (gameState === "RAT_ENCOUNTER") {
      if (weapon === false) {
        player.health -= 20;
        gameState = "RAT_FIGHT";
      }
      if (weapon === true) {
        ratsDefeated++;
        gameState = "RAT_FIGHT";
      }
    }
  }
  if (key === 'l' || key === 'L') {
    if (gameState === "START_MENU") {
      gameState = "LEADERBOARD";
    }
  }
  if (key === 'p' || key === 'P') {
    if (gameState === "PLAY") {
      gameState = "PAUSE";
    } else if (gameState === "PAUSE") {
      gameState = "PLAY";
    }
    }
  if (key === 'q' || key === 'Q') {
    if (gameState === "PAUSE") {
      gameState = "START_MENU";
      resetGame();
    }
  }
  if (key === 'r' || key === 'R') {
    if (gameState === "RAT_ENCOUNTER") {
      gameState = "RAT_BITE";
      player.health -= 10;
    } else if (gameState === "RAT_FIGHT") {
      gameState = "PLAY";
    } else if (gameState === "RAT_BITE") {
      gameState = "PLAY";
    } else if (gameState === "GAME_OVER") {
      gameState = "START_MENU";
      resetGame();
    } else if (gameState === "LEADERBOARD") {
      gameState = "START_MENU";
    }
  }
  if (key === ' ') {
    if (gameState === "YOU_DIED") {
      gameState = "GAME_OVER";
    } else if (gameState === "GAME_OVER") {
      newGame();
    }
  }
  if (key === 'Enter') {
    if (gameState === "START_MENU") {
      gameState = "INTRODUCTIONS";
    } else if (gameState === "INTRODUCTIONS") {
      if (nameInput.value() !== "") {
        nameInput.remove();
        nameInput = null;
        gameState = "START_OBJECTIVE";
      }
    } else if (gameState === "START_OBJECTIVE") {
      gameState = "PLAY";
      if (!gameEnded) {
        startTime = Date.now();
      }
      levelReached = levelReached + 1;
    } else if (gameState === "WEAPON_FOUND") {
      gameState = "PLAY";
    } else if (gameState === "VICTORY") {
      gameState = "START_MENU";
    }
  }
} //end keyPressed()



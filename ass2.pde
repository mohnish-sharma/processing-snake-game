boolean gameStarted = true;
boolean gameOver = false;
int gridSize = 40;
int border = 20;
int borderTop = 60;
int numColumns, numRows;
boolean colour;
int snakeLength = 2;
int snakeX, snakeY;
int[] snakeXBody, snakeYBody;
int direction = 1;
int foodX, foodY;
int score = 0;

void setup() {
  size(800, 800);
  background(0, 60, 0);
  frameRate(5);
  drawGrid();
  welcomeScreen();

  numColumns = (width - border * 2) / gridSize;
  numRows = (height - borderTop - border) / gridSize;

  snakeX = numColumns / 2;
  snakeY = numRows / 2;

  snakeXBody = new int[numColumns * numRows];
  snakeYBody = new int[numColumns * numRows];

  placeFood();
}

void drawGrid() {
  for (int y = 0; y < numColumns; y++) {
    for (int x = 0; x < numRows; x++) {
      boolean colour = (x + y) % 2 == 0;
      drawCell(x, y, colour);
    }
  }
}

void drawCell(int x, int y, boolean colour) {
  if (colour) {
    fill(30, 60, 30);
  } else {
    fill(60, 200, 150);
  }
  rect(border + y * gridSize, borderTop + x * gridSize, gridSize, gridSize);
}

void moveSnake() {
  snakeXBody[0] = snakeX;
  snakeYBody[0] = snakeY;

  if (direction == 1) {
    snakeX++;
  } else if (direction == 2) {
    snakeY++;
  } else if (direction == 3) {
    snakeX--;
  } else if (direction == 4) {
    snakeY--;
  }

  // Update body
  for (int i = snakeLength - 1; i > 0; i--) {
    snakeXBody[i] = snakeXBody[i - 1];
    snakeYBody[i] = snakeYBody[i - 1];
  }
}

void collisionCheck() {
  if (snakeX < 1 || snakeX >= numColumns + 1 || snakeY < 1 || snakeY >= numRows + 1) {
    gameStarted = true;
    gameOver = true;
  }

  for (int i = 1; i < snakeLength; i++) {
    if (snakeX == snakeXBody[i] && snakeY == snakeYBody[i]) {
      gameStarted = true;
      gameOver = true;
    }
  }
}

void checkFood() {
  if (snakeX == foodX && snakeY == foodY) {
    snakeLength++;
    score++;
    placeFood();
  }
}

void placeFood() {
  foodX = int(random(1, numColumns + 1));
  foodY = int(random(1, numRows + 1));
}

void drawSnake() {
  fill(0, 0, 175);

  for (int i = 0; i < snakeLength; i++) {
    ellipse(snakeXBody[i] * gridSize + border - 20, snakeYBody[i] * gridSize + borderTop - 20, gridSize, gridSize);
  }
}




void drawFruit(int x, int y) {
  fill(200, 0, 0);
  ellipse(x * gridSize + border - 20, y * gridSize + borderTop - 20, gridSize, gridSize);
}

void drawScoreCounter() {
  fill(255);
  textSize(26);
  text("Score: " + score, 10, 30);
  fill(255, 0, 0);
}

void startCondition() {
  if (keyPressed) {
    if (keyCode == SHIFT && gameStarted != false) {
      gameStarted = false;
      score = 0;
      snakeLength = 2;
      snakeX = numColumns / 2;
      snakeY = numRows / 2;
      direction = 1;
      drawGrid();
    }
  }
}

void winScreen() {
  fill(51, 204, 204);
  rect(width/4, height/4, width/2, height/2);
  textSize(35);
  fill(0);
  text("YOU WIN!!!!!!!!!!!", width/3.1, height/3.4);
  text("________________", width/3.1, height/3.4);
  textSize(20);
  text("Great Job!", width/3.8, height/2.8);
  text("__________________________________", width/3.8, height/2.6);
  text("****************************************", width/3.8, height/2.6);
  textSize(16);
  text("Press the SHIFT key to restart...", width/3.8, height/2);
  fill(255);

  if (keyPressed) {
    if (keyCode == SHIFT) {
      gameStarted = false;
      score = 0;
      snakeLength = 2;
      snakeX = numColumns / 2;
      snakeY = numRows / 2;
      direction = 1;
      drawGrid();
    }
  }
}

void lossScreen() {
  fill(51, 204, 204);
  rect(width/4, height/4, width/2, height/2);
  textSize(35);
  fill(0);
  text("Game over....", width/3.1, height/3.4);
  text("________________", width/3.1, height/3.4);
  textSize(20);
  text("Better luck next time!", width/3.8, height/2.8);
  text("__________________________________", width/3.8, height/2.6);
  text("****************************************", width/3.8, height/2.6);
  textSize(16);
  text("Press the SHIFT key to restart...", width/3.8, height/2);
  fill(255);

  if (keyPressed) {
    if (keyCode == SHIFT) {
      gameStarted = false;
      score = 0;
      snakeLength = 2;
      snakeX = numColumns / 2;
      snakeY = numRows / 2;
      direction = 1;
      drawGrid();
    }
  }
}

void welcomeScreen() {
  fill(51, 204, 204);
  rect(width/4, height/4, width/2, height/2);
  textSize(35);
  fill(0);
  text("Welcome to Snake!", width/3.1, height/3.4);
  text("________________", width/3.1, height/3.4);
  textSize(20);
  text("INSTRUCTIONS:", width/3.8, height/2.8);
  text("__________________________________", width/3.8, height/2.6);
  text("****************************************", width/3.8, height/2.6);
  textSize(16);
  text("Use the UP, DOWN, LEFT, RIGHT arrow keys to move.", width/3.8, height/2.4);
  text("Consume the food to increase your score.", width/3.8, height/2.2);
  text("Press the SHIFT key to begin...", width/3.8, height/2);
  fill(255);
}

void keyPressed() {
  if (keyCode == UP && direction != 2) {
    direction = 4;
  } else if (keyCode == DOWN && direction != 4) {
    direction = 2;
  } else if (keyCode == LEFT && direction != 1) {
    direction = 3;
  } else if (keyCode == RIGHT && direction != 3) {
    direction = 1;
  }
}

void draw() {
  startCondition();

  if (gameStarted == !true && score <10) {
    background(0, 60, 0);
    drawGrid();
    moveSnake();
    collisionCheck();
    checkFood();
    drawSnake();
    drawFruit(foodX, foodY);
    drawScoreCounter();
  } else if (score == 10) {
    winScreen();
  } else if (gameOver == true) {
    lossScreen();
  }
}

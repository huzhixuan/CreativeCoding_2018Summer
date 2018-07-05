import ddf.minim.*;
import processing.serial.*;

AudioPlayer player;
Minim minim;

Serial port;
float val;
int x;
int y;
int score;
light[][] thisdrop =new light[4][4];
char parameter[]={'1', '2', '3', 'A', '4', '5', '6', 'B', '7', '8', '9', 'C', '*', '0', '#', 'D'};
PFont myFont;
boolean testPress1 = false;
boolean testPress2 = false;
boolean testPress3 = false;

void setup() {
  size(800, 900);
  minim = new Minim(this);
  player = minim.loadFile("Tobu - Life.mp3", 1024);
  player.play();
  myFont = createFont("YaHei", 24);
  for (int i = 0; i<4; i++) {
    for (int j = 0; j<4; j++) {
      thisdrop[i][j] = new light(200*j+100, 200*i+200);
    }
  }
  String arduinoPort = Serial.list()[0];             //      接收arduino数据
  port = new Serial(this, arduinoPort, 9600);
}

void draw() {
  fill(0, 20);
  noStroke();
  rect(0, 0, 800, 900);
  displayText();                      //显示文字
  for (int i = 0; i < 5; i++) {                // 画格子
    stroke(106, 223, 245);
    strokeWeight(2);
    line(0, 200*i+100, width, 200*i+100);
    line(200*i, 100, 200*i, height);
  }
  for (int i = 0; i < 4; i++) {          // 生成light
    for (int j = 0; j < 4; j++) {
      thisdrop[i][j].emerge();
    }
  }
  if (port.available()>0) {            // 消除light
    val=(int)port.read();
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (val==parameter[i*4 + j]) {
          thisdrop[i][j].boom();
        }
      }
    }
  }
  endGame();            //     结束
}

void displayText() {
  textFont(myFont);
  textSize(24);
  fill(#F2EB14);
  textAlign(LEFT);      //    防止 endGame() 运行后 textAlign(CENTER) 影响所有 text() 函数
  text("帮助", width-175, 35);
  text("得分："+score, 100, 35);
  text("目标：100", 300, 35);
  text("静音", width-285, 35);
  noFill();
  stroke(255);
  rect(width-200, 10, 100, 30);
  rect(width-310, 10, 100, 30);
  fill(255);
  strokeWeight(5);
}

void mousePressed() {              
  boolean mouseClick1;
  boolean mouseClick2;
  boolean mouseClick3;
  mouseClick1=mouseX<width-100 && mouseX>width-200 && mouseY<40 && mouseY> 10;
  mouseClick2=mouseX<520 && mouseX>280 && mouseY<590 && mouseY> 520;
  mouseClick3=mouseX<width-210 && mouseX>width-310 && mouseY<40 && mouseY> 10;
  if (mouseClick1) {                                                             //   “帮助”按键
    testPress1 = !testPress1;
    if (testPress1) {
      noLoop();
      fill(20, 20);
      stroke(255);
      strokeWeight(1);
      rect(490, 50, 250, 300);
      textFont(myFont);
      textSize(30);
      fill(#F01628);
      text("当你看到白色光球\n出现时，按下对应\n位置按键来消除它\n们，并获得分数。\n错误地按键将扣除\n5分", 500, 80);
    } else {
      loop();
    }
  }

  if (testPress2) {              //        “再来一次”按键
    if (mouseClick2) {
      testPress2 = false;
      score = 0;
      loop();
    }
  }

  if (mouseClick3) {             //       “静音”按键
    testPress3 = !testPress3;
    if (testPress3) {
      player.pause();
    } else {
      player.play();
    }
  }
}

void endGame() {   //    达成目标时结束
  if (score>=100) {
    noLoop();
    testPress2 = true;
    fill(#ACB207);
    rect(100, 100, width-200, height-200);
    rect(280, 520, 240, 70);
    textFont(myFont);
    textSize(60);
    fill(#F01628);
    textAlign(CENTER);
    text("Congratulations!", width/2, height/2);
    text("再来一次", 400, 575);
  }
}

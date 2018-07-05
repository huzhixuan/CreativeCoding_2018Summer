class light {
  int x;
  int y;
  int t = 0;
  int test;               // 决定是否生成light
  light(int x_, int y_) {
    x = x_;
    y = y_;
  }

  void emerge() {          // 生成light
    if (t==0) {
      test=(int)random(1000);
    }
    if (test<1) {
      if (t<150) {
        fill(255);
        noStroke();
        ellipse(x, y, t, t);
        t++;
        if (t==150) {
          score-=3;
          t=0;
        }
      }
    }
  }

  void boom() {            //  消除light
    noStroke();
    for (int i = 0; i<11; i++) {
      int i1=-((i-10)*(i-10))/5+20;
      fill(255, 60);
      rect(x-100+5*i, y-100+5*i, 200-10*i, 200-10*i);
      fill(255, 30);
      rect(x-45+2*i1, 0, 90-i1*4, height);
      fill(255, 30);
      rect(0, y-45+2*i1, width, 90-i1*4);
    }
    if (t==0) {
      score-=5;
    } else if (t<50) {
      score+=5;
    } else if (t<100) {
      score+=2;
    } else if (t<150) {
      score+=1;
    }
    t=0;
  }
}

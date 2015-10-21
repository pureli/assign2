PImage background1Img;
PImage background2Img;
PImage fighterImg;
PImage treasureImg;
PImage bloodImg;
PImage enemyImg;
PImage start1Img;
PImage start2Img;
PImage end1Img;
PImage end2Img;
int x1;
int x2;
int x3;//treasure
int y3;//treasure
int x4;//blood
int x5;//enemy
float y5;//enemy
int x6;//fighter
int y6;//fighter
int fighterSpeed = 5;
float enemySpeed = floor(random(-8,8));
int gameState;
int GAME_START = 0;
int GAME_RUN  = 1;
int GAME_LOSE = 3;
int fighterStatus = 0;
boolean fighterUpPressed = false;
boolean fighterDownPressed = false;
boolean fighterLeftPressed = false;
boolean fighterRightPressed = false;


void setup(){  
  size(640,480);
  start1Img = loadImage("img/start1.png");
  start2Img = loadImage("img/start2.png"); 
  background1Img = loadImage("img/bg1.png");
  background2Img = loadImage("img/bg2.png");
  fighterImg = loadImage("img/fighter.png");
  treasureImg = loadImage("img/treasure.png");
  bloodImg = loadImage("img/hp.png");
  enemyImg = loadImage("img/enemy.png");
  end1Img = loadImage("img/end1.png");
  end2Img = loadImage("img/end2.png");
  gameState = 0;

  x1 = 640;
  x2 = 0;
  x3 = floor(random(500));  
  y3 = floor(random(400));
  x4 = 36;
  x5 = 0;
  y5 = floor(random(400));
  x6 = 580;
  y6 = 240;

}

void draw(){
  //game start
  if(gameState == 0){
    image(start2Img,0,0);
  
    if(mouseX>1.0/3.0*width && mouseX<2.0/3.0*width && mouseY>3.0/4.0*height && mouseY<height){
      image(start1Img,0,0);
      
    if(mousePressed){
        gameState = 1;
      }
    }
  }    
  if (gameState == 1)  {
    //scroll background 
    image(background1Img,x1-640,0);
    image(background2Img,x2-640,0);
      
    x1 = x1+1;
    x2 = x2+1;
    
    x1 = x1%1280;
    x2 = x2%1280;
      
    //fighter
    image(fighterImg,x6,y6);
      
    //treasure
    image(treasureImg,x3,y3);
    
    //blood
    noStroke();
    fill(255,0,0);
    rect(33,15,x4*2.0,15);//blood bar
    image(bloodImg,20,10);
    
    //enemy
    image(enemyImg,x5-61,y5);
    x5 = x5+5;
    
    //scrollBack
    //x5 = x5%762;  
    if(x5>701){
      x5 = 0;
      y5 = floor(random(480));
     }
      
     //enemy curve move
     y5 = y5+enemySpeed;
     if(y5 > height*0.5){
       enemySpeed = enemySpeed-0.05;
      }else{
        enemySpeed = enemySpeed+0.05;
     }
        
      //fighter position
      if(fighterUpPressed){
        if(y6>10){
          y6 = y6-fighterSpeed;
        }
      }
      if(fighterDownPressed){
        if(y6<height-60){
          y6 = y6+fighterSpeed;
        }
      }
      if(fighterLeftPressed){
        if(x6>10){
          x6 = x6-fighterSpeed;    
        }
      }
      if(fighterRightPressed){
        if(x6<width-60){
          x6 = x6+fighterSpeed;
        }
      }
    
    //fighter meet enemy
    int fighterCenterPointX = (int)(x6 + fighterImg.width * 0.5);
    int fighterCenterPointY = (int)(y6 + fighterImg.height * 0.5);
    //ellipse( fighterCenterPointX, fighterCenterPointY, 20, 20 );
    //rect( x5-61, y5, enemyImg.width, enemyImg.height );
    
      if( fighterCenterPointX > x5-61 &&  fighterCenterPointX < x5 + enemyImg.width -61 ){
        if( fighterCenterPointY > y5 && fighterCenterPointY < y5+enemyImg.height){
           x4= x4-20;
           x5 = 0;
           y5 = floor(random(400));
        }
      }
        
  //fighter meet treasure
      if( fighterCenterPointX > x3 &&  fighterCenterPointX < x3 + enemyImg.width  ){
        if( fighterCenterPointY > y3 && fighterCenterPointY < y3+enemyImg.height){
          x3 = floor(random(500));  
          y3 = floor(random(400));
                  
          if(x4<100){
            x4= x4+10;
          }
        }
       }
        
  }//state=1 condition end   
  
  
  //loseState
  if(x4 <= 13){
     gameState = 3;
  }

  //gameState = lose
  if(gameState == 3){
    image(end2Img,0,0);
    x5 = 0;
    y5 = floor(random(400));
    x4 = 20;
    if(mouseX>1.0/3.0*width && mouseX<2.0/3.0*width && mouseY>2.0/3.0*height && mouseY<3.0/4.0*height){
      image(end1Img,0,0);
      if(mousePressed){
        gameState = GAME_RUN;
      }
    }
  }      
      

} //draw end

void keyPressed(){
  if(keyCode == UP){
    fighterUpPressed = true;
  } 
  if(keyCode == DOWN){
    fighterDownPressed = true;
  }
  if(keyCode == LEFT){
    fighterLeftPressed = true;
  }
  if(keyCode == RIGHT){
    fighterRightPressed = true;
  }
}

void keyReleased(){
  if(keyCode == UP){
    fighterUpPressed = false;
  } 
  if(keyCode == DOWN){
    fighterDownPressed = false;
  }
  if(keyCode == LEFT){
    fighterLeftPressed = false;
  }
  if(keyCode == RIGHT){
    fighterRightPressed = false;
  }
}

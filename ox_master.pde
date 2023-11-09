import processing.sound.*;

int aA=0;
int aB=0;
int aC=0;
int bA=0;
int bB=0;
int bC=0;
int cA=0;
int cB=0;
int cC=0;
int state;
//int index=0;
int move=0;
int rnd;
int runde=0;
int errcnt=0;
int awon=0;
int bwon=0;
int nwon=0;
int index=0;
int[] prop=new int[9];
boolean won=false;
boolean adone=true;
boolean bdone=false;
boolean pressed=false;
boolean wina=false;
boolean winb=false;
boolean setup=true;
boolean fileex=false;
int[][] box=new int[19682][9];
int[] one={1,1,1,1,1,1,1,1,1};
String verlauf;
String[] line=new String[2];
SinOsc sig = new SinOsc(this);
File f;

void setup(){
  fullScreen(); //for Android
  //size(600,900); //for Windows+Linux
  frameRate(1000);
  textSize(75);
  textAlign(CENTER);
  f = new File(sketchPath("preset.txt"));
  println(f);
  if (f.exists()){
    fileex=true;
    BufferedReader reader = createReader(f);
    sig.play(1500,1);
    println("exists");
    while(line!=null){
      try{
        line=split(reader.readLine(),'|');
        if(line!=null){
          //println(line[0]+"|"+line[1]);
          box[int(line[1])]=int(split(line[0],';'));
          println(line[1]);
        }
      }catch (IOException e){}
    }
    delay(500);
    sig.stop();
  }
}

void draw(){
  if(setup){
    //println(box[index]);
    if(box[index][0]==0&&box[index][1]==0&&box[index][2]==0&&box[index][3]==0&&box[index][4]==0&&box[index][5]==0&&box[index][6]==0&&box[index][7]==0&&box[index][8]==0){
      if(!fileex){
        if(check(index)!=2){
          for(int i=0; i<9; i++){
            box[index][i]=check(index);
          }
        }else{
          for(int i=0; i<9; i++){
            box[index][i]=1;
          }
        }
      }else{
        for(int i=0; i<9; i++){
          box[index][i]=1;
        }
      }
      sig.play(400,1);
    }else{
      sig.play(600,1);
    }
    background(255);
    fill(0,0,255);
    rect(0,map(index,0,19682,0,height),width,map(index,19682,0,0,height));
    fill(0);
    text("INITIALIZING: "+round(map(index,0,19682,0,100))+"%",width/2,height/2);
    text(int(frameRate)+" index/sec",width/2,height/2+100);
    index++;
    if(index==19682){
      textAlign(LEFT);
      sig.stop();
      stroke(0);
      fill(255);
      strokeWeight(5);
      background(255);
      line(0,width/3,width,width/3);
      line(0,width/3*2,width,width/3*2);
      line(width/3,0,width/3,width);
      line(width/3*2,0,width/3*2,width);
      line(0,width,width,width);
      fill(255,0,0);
      rect(width/3*2,width,width/3,50);
      textSize(20);
      fill(0);
      text(awon,width-50,width+100);
      text(bwon,width-50,width+120);
      text(nwon,width-50,width+140);
      textSize(50);
      textAlign(CENTER);
      text("RESET",width/6*5,width+45);
      textAlign(LEFT);
      fill(255);
      circle(width-60,width+92,10);
      square(width-65,width+107,10);
      line(width-65,width+127,width-55,width+137);
      setup=false;
      frameRate(30);
    }
  }else{
    if (mousePressed == true && mouseY>width && mouseY<width+50 && mouseX>width/3*2){
      reset();
    }
    if(mousePressed && bdone==true && adone==false && pressed==false){
      if (mouseX<width/3 && mouseY<width/3 && aA==0){
        aA=1;
        adone=true;
        bdone=false;
      }else if (mouseX>width/3 && mouseX<width/3*2 && mouseY<width/3 && aB==0){
        aB=1;
        adone=true;
        bdone=false;
      }else if (mouseX>width/3*2 && mouseX<width && mouseY<width/3 && aC==0){
        aC=1;
        adone=true;
        bdone=false;
      }else if (mouseX<width/3 && mouseY>width/3 && mouseY<width/3*2 && bA==0){
        bA=1;
        adone=true;
        bdone=false;
      }else if (mouseX>width/3 && mouseX<width/3*2 && mouseY>width/3 && mouseY<width/3*2 && bB==0){
        bB=1;
        adone=true;
        bdone=false;
      }else if (mouseX>width/3*2 && mouseX<width && mouseY>width/3 && mouseY<width/3*2 && bC==0){
        bC=1;
        adone=true;
        bdone=false;
      }else if (mouseX<width/3 && mouseY>width/3*2 && mouseY<width && cA==0){
        cA=1;
        adone=true;
        bdone=false;
      }else if (mouseX>width/3 && mouseX<width/3*2 && mouseY>width/3*2 && mouseY<width && cB==0){
        cB=1;
        adone=true;
        bdone=false;
      }else if (mouseX>width/3*2 && mouseX<width && mouseY>width/3*2 && mouseY<width && cC==0){
        cC=1;
        adone=true;
        bdone=false;
      }
      pressed=true;
      sig.play(1000,1);
      delay(100);
      sig.stop();
    }else if(mousePressed == false && pressed == true){pressed=false;}
    
    state=((aA+1)*round(pow(3,0)))+((aB+1)*round(pow(3,1)))+((aC+1)*round(pow(3,2)))+((bA+1)*round(pow(3,3)))+((bB+1)*round(pow(3,4)))+((bC+1)*round(pow(3,5)))+((cA+1)*round(pow(3,6)))+((cB+1)*round(pow(3,7)))+((cC+1)*round(pow(3,8)));
    //println ("|"+ state);
    
    if(adone==true && bdone==false && pressed==false){
      prop=box[state];
      //println (rnd);
      move=0;
      if(prop[0]+prop[1]+prop[2]+prop[3]+prop[4]+prop[5]+prop[6]+prop[7]+prop[8]<=0){
        for(int i=0; i<9; i++){
          box[state][i]=check(state);
        }
        sig.play(700,1);
        delay(250);
        sig.play(1000,1);
        delay(250);
        sig.stop();
        println("!!!!!!!!!!");
        println(box[state][0]+";"+box[state][1]+";"+box[state][2]+";"+box[state][3]+";"+box[state][4]+";"+box[state][5]+";"+box[state][6]+";"+box[state][7]+";"+box[state][8]+"|"+state);
        prop=box[state];
      }
      rnd=round(random(prop[0]+prop[1]+prop[2]+prop[3]+prop[4]+prop[5]+prop[6]+prop[7]+prop[8]));
      while(rnd>0){
        rnd=rnd-prop[move];
        move=move+1;
      }
      move=move-1;
      //print(move);
      if(move<0){
      }else if(move==0 && aA==0){
        aA=-1;
        bdone=true;
        adone=false;
      }else if(move==1 && aB==0){
        aB=-1;
        bdone=true;
        adone=false;
      }else if(move==2 && aC==0){
        aC=-1;
        bdone=true;
        adone=false;
      }else if(move==3 && bA==0){
        bA=-1;
        bdone=true;
        adone=false;
      }else if(move==4 && bB==0){
        bB=-1;
        bdone=true;
        adone=false;
      }else if(move==5 && bC==0){
        bC=-1;
        bdone=true;
        adone=false;
      }else if(move==6 && cA==0){
        cA=-1;
        bdone=true;
        adone=false;
      }else if(move==7 && cB==0){
        cB=-1;
        bdone=true;
        adone=false;
      }else if(move==8 && cC==0){
        cC=-1;
        bdone=true;
        adone=false;
      }else{
        prop[move]=0;
        box[state]=prop;
        errcnt=errcnt+1;
        if(errcnt>500){
          gleich();
        }
      }
      println(box[state][0]+";"+box[state][1]+";"+box[state][2]+";"+box[state][3]+";"+box[state][4]+";"+box[state][5]+";"+box[state][6]+";"+box[state][7]+";"+box[state][8]+"|"+state);
      sig.play(700,1);
      delay(100);
      sig.stop();
      if (bdone==true){
        if (verlauf == null){
          verlauf=state + "," + move;
        }else{
          verlauf=verlauf + ";" + state + "," + move;
        }
      //println (verlauf);
      runde=runde+1;
      }
    }
     
    if (won==true){
      if(wina==true){
        sig.play(500,1);
        delay(500);
        sig.play(1000,1);
        delay(500);
        sig.stop();
      }else if(winb==true){
        sig.play(1000,1);
        delay(500);
        sig.play(500,1);
        delay(500);
        sig.stop();
      }else{
        sig.play(1000,1);
        delay(333);
        sig.play(500,1);
        delay(333);
        sig.play(1000,1);
        delay(333);
        sig.stop();
      }
      reset();
    }
    
    if(aA==1){circle(width/6,width/6,width/6);}
    if(aB==1){circle(width/6*3,width/6,width/6);}
    if(aC==1){circle(width/6*5,width/6,width/6);}
    if(bA==1){circle(width/6,width/6*3,width/6);}
    if(bB==1){circle(width/6*3,width/6*3,width/6);}
    if(bC==1){circle(width/6*5,width/6*3,width/6);}
    if(cA==1){circle(width/6,width/6*5,width/6);}
    if(cB==1){circle(width/6*3,width/6*5,width/6);}
    if(cC==1){circle(width/6*5,width/6*5,width/6);}
    
    if(aA==-1){square(width/12,width/12,width/6);}
    if(aB==-1){square(width/12*5,width/12,width/6);}
    if(aC==-1){square(width/12*9,width/12,width/6);}
    if(bA==-1){square(width/12,width/12*5,width/6);}
    if(bB==-1){square(width/12*5,width/12*5,width/6);}
    if(bC==-1){square(width/12*9,width/12*5,width/6);}
    if(cA==-1){square(width/12,width/12*9,width/6);}
    if(cB==-1){square(width/12*5,width/12*9,width/6);}
    if(cC==-1){square(width/12*9,width/12*9,width/6);}
    
    if(aA+aB+aC==3 || bA+bB+bC==3 || cA+cB+cC==3 || aA+bA+cA==3 || aB+bB+cB==3 || aC+bC+cC==3 || aA+bB+cC==3 || aC+bB+cA==3){kreis();}
    else if(aA+aB+aC==-3 || bA+bB+bC==-3 || cA+cB+cC==-3 || aA+bA+cA==-3 || aB+bB+cB==-3 || aC+bC+cC==-3 || aA+bB+cC==-3 || aC+bB+cA==-3){quadr();}
    else if(aA!=0 && aB!=0 && aC!=0 && bA!=0 && bB!=0 && bC!=0 && cA!=0 && cB!=0 && cC!=0){gleich();}
  }
}

void kreis(){
  wina=true;
  awon=awon+1;
  runde=runde-1;
  circle(width/6,width+width/6,width/6);
  fill(0);
  text("WINNS",width/3,width+125);
  fill(255);
  won=true;
  String[] verl = new String[runde];
  int[] data = new int[2];
  verl = split(verlauf,';');
  for(;runde>=0;runde--){
    data=int(split(verl[runde],','));
    prop=box[data[0]];
    if(prop[data[1]]>0){
      prop[data[1]]=prop[data[1]]-1;
    }
    box[data[0]]=prop;
    //print(runde);
    //println("|"+box[data[0]]);
  }
}
void quadr(){
  winb=true;
  bwon=bwon+1;
  runde=runde-1;
  square(width/12,width+width/12,width/6);
  fill(0);
  text("WINNS",width/3,width+125);
  fill(255);
  won=true;
  String[] verl = new String[runde];
  int[] data = new int[2];
  verl = split(verlauf,';');
  for(;runde>=0;runde--){
    data=int(split(verl[runde],','));
    prop=box[data[0]];
    prop[data[1]]=prop[data[1]]+2;
    box[data[0]]=prop;
    //print(runde);
    //println("|"+box[data[0]]);
  }
}
void gleich(){
  nwon=nwon+1;
  fill(0);
  text("NOONE WINNS",width/3,width+125);
  fill(255);
  won=true;
}
void reset(){
  background(255);
  line(0,width/3,width,width/3);
  line(0,width/3*2,width,width/3*2);
  line(width/3,0,width/3,width);
  line(width/3*2,0,width/3*2,width);
  line(0,width,width,width);
  fill(255,0,0);
  rect(width/3*2,width,width/3,50);
  textSize(20);
  fill(0);
  text(awon,width-50,width+100);
  text(bwon,width-50,width+120);
  text(nwon,width-50,width+140);
  textSize(50);
  textAlign(CENTER);
  text("RESET",width/6*5,width+45);
  textAlign(LEFT);
  fill(255);
  circle(width-60,width+92,10);
  square(width-65,width+107,10);
  line(width-65,width+127,width-55,width+137);
  aA=0;
  aB=0;
  aC=0;
  bA=0;
  bB=0;
  bC=0;
  cA=0;
  cB=0;
  cC=0;
  runde=0;
  errcnt=0;
  won=false;
  verlauf=null;
  if(winb){
    adone=false;
    bdone=true;
  }else{
    adone=true;
    bdone=false;
  }
  wina=false;
  winb=false;
  PrintWriter output = createWriter(f); 
  for(int index=0;index<19682;index++){
    if(box[index][0]!=1||box[index][1]!=1||box[index][2]!=1||box[index][3]!=1||box[index][4]!=1||box[index][5]!=1||box[index][6]!=1||box[index][7]!=1||box[index][8]!=1){
      sig.play(1250,1);
      output.println(box[index][0]+";"+box[index][1]+";"+box[index][2]+";"+box[index][3]+";"+box[index][4]+";"+box[index][5]+";"+box[index][6]+";"+box[index][7]+";"+box[index][8]+"|"+index);
      //println(box[index][0]+";"+box[index][1]+";"+box[index][2]+";"+box[index][3]+";"+box[index][4]+";"+box[index][5]+";"+box[index][6]+";"+box[index][7]+";"+box[index][8]+"|"+index);
    }
  }
  output.flush();
  output.close();
  delay(500);
  sig.stop();
  //println("------------------------------------");
}

int check(int tocheck){
  int res=2;
  int num=0;
  for(int i=0;i<9;i++){
    num=num+round(pow(3,i));
  }
  if(tocheck==num){
    res=5;
  }else{
    for(int a1=0;a1<9;a1++){
      num=0;
      for(int i=0;i<9;i++){
        if(a1==i){
          num=num+2*round(pow(3,i));
        }else{
          num=num+round(pow(3,i));
        }
      }
    }
    if(tocheck==num){
      res=5;
    }else{
      for(int a1=0;a1<9;a1++){
        for(int b=0;b<9;b++){
          if(b!=a1){
            for(int a2=0;a2<9;a2++){
              num=0;
              if(a2!=a1&&a2!=b){
                for(int i=0;i<9;i++){
                  if(a1==i||a2==i){
                    num=num+2*round(pow(3,i));
                  }else if(b==i){
                  }else{
                    num=num+round(pow(3,i));
                  }
                }
                if(tocheck==num){
                  res=4;
                }
              }
            }
          }
        }
      }
    }
  }
  return(res);
}

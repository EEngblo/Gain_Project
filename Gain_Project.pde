PImage getimage,cropimage,resizeimage,boyoung;
PrintWriter output;
int Max_Arr=9;
int x=0,y=0,w=0,h=0,offset=80;
String image_name_final;
String image_name;
int[] compare_answer = new int[10];
int ANSWER, SCORE=0;

/////////////////////////////////////////////////////////
/////////////////////// Settings //////////////////////////

int sero =40, garo = 20;
int angstrong = 1;

int line_threshold = 1;

boolean debug0 = true; // answer
boolean debug1 = false; // first data
boolean debug2 = false; // final
boolean debug3 = false; // fiilzero
boolean debugline = false; // line functions
boolean debugnumber = true; // shape functions
boolean lets_ang = true; // don't touch

///////////////////////////////////////////////////
////////////////// Sample Number /////////////////////

// 0,7,9 need classification

int[][] heightarray = // sero
{{0,0,0,1,2,1,0,0,0}, //0
 {0,0,0,0,1,0,0,0,0}, //1
 {0,0,0,2,3,2,1,0,0}, //2
 {0,0,1,3,4,3,1,0,0}, //3
 {0,0,0,0,1,0,0,0,0}, //4
 {0,0,0,1,3,1,0,0,0}, //5
 {0,0,0,1,3,1,0,0,0}, //6
 {0,0,0,1,2,1,0,0,0}, //7
 {0,0,0,2,4,3,1,0,0}, //8
 {0,0,0,1,2,1,0,0,0}  //9
};

int[][] widtharray = // garo
{{0,0,0,1,2,1,0,0,0}, //0
 {0,0,0,0,1,0,0,0,0}, //1
 {0,0,0,1,2,1,0,0,0}, //2
 {0,0,0,1,2,1,0,0,0}, //3
 {0,0,0,0,2,1,0,0,0}, //4
 {0,0,0,1,3,1,0,0,0}, //5
 {0,0,0,1,2,1,0,0,0}, //6
 {0,0,0,1,2,1,0,0,0}, //7
 {0,0,1,2,1,2,1,0,0}, //8
 {0,0,0,1,2,1,0,0,0}  //9
};

int[] leftupbox = {0,0,0,0,0,0,0,0,0,0};
int[] rightupline = {-2,-2,-2,-2,-2,2,2,-2,-2,-2};
int[] leftupline = {-2,-2,-1,2,-2,-2,-2,2,-2,-2};
int[] leftdownline = {-2,-2,-2,2,0,2,-2,2,-2,2};

////////////////////////////////////////////////////////////////////
////////////////////// Functions for Convenience ///////////////////

int location(int Garo, int Sero){
  return (Garo + Sero * (garo)); 
}
/////////////////////////////////////////////////////////////////////
//////////////////// Classification by Shape ///////////////////////

void classify_zero(PImage img){
  int j,loc, answer = 0;
  int seed_sero = sero/3;
  int seed_garo = garo/3;
  boolean ang = true;
  
  for(int i = seed_garo; i<garo*2/3; i++){
    for(j = seed_sero; j<sero*3/4; j++){
       loc = location(i,j);
       if(red(img.pixels[loc]) == 0){
         ang = false;
         break;
       }
    }
    if(ang){
      for(; j<sero; j++){
        loc = location(i,j);
        if(red(img.pixels[loc]) == 0){
          ang = true;
          break;
        }
        ang = false;
      }
    }
    if(ang) answer++;
    ang = true;
  }
  
  if(answer >= garo/4) {
    for(int i = 0 ; i<10; i++){
      if (i!=0) compare_answer[i] -= 2; 
    }
    compare_answer[0] += 3;
    if(debugnumber) output.println("maybe 0!");
  } 
  else compare_answer[0] -= 10;
}

void classify_one(PImage img){
  int loc, area=0;
  for(int i = 0; i<sero; i++){
    for(int j = 0; j<garo; j++){
      loc = location(j,i);
      
      if(red(img.pixels[loc]) == 0){
        area++;   
      }
    }
  }
  double area_percent = area*100 / sero / garo;
  if(area_percent > 50) {
    for(int i = 0 ; i<10; i++){
      if (i!=1) compare_answer[i] -= 2; 
    }
    compare_answer[1] += 3;
    if(debugnumber) output.println("maybe 1!");
  }
  else compare_answer[1] -= 10;
}

void classify_seven(PImage img){
  int loc, answer = 0;
  int seed_sero = sero/5;
  int seed_garo = 0;
  boolean ang = true;
  
  for(int i = seed_garo; i<garo*2/3; i++){
    for(int j = seed_sero; j<sero; j++){
      loc = location(i,j);
      if(red(img.pixels[loc]) == 0){
        ang = false;
        break;
      }
    }
    if(ang) answer++;
    ang = true;
  }
  
  if(answer >= garo/4){
    for(int i = 0 ; i<10; i++){
      if (i!=7) compare_answer[i] -= 2; 
    }
    compare_answer[7] += 3;
    if(debugnumber) output.println("maybe 7!");
  }
  else compare_answer[7] -= 10;
}




//////////////////////////////////////////////////////////////////
/////////////////// Classification by Space ////////////////////// 

// to classificaation 5,6 // 0,1,2,3,4,7,8,9
void rightup_line(PImage img){
  int seed_sero = sero / 4;
  int seed_garo = garo / 2;
  int answer = 0, loc;
  boolean ang=true;
  
  for(int i = seed_sero; i>=sero/8; i--){
     for(int j = seed_garo; j<garo; j++){
       loc = location(j,i);
       if(red(img.pixels[loc]) == 0){
       ang = false;
         break;
       }
     }
     if(ang) answer++;
     ang = true;
  }
  
  
  
  for(int i = seed_sero; i<sero/3; i++){
     for(int j = seed_garo; j<garo; j++){
       loc = location(j,i);
       if(red(img.pixels[loc]) == 0){
         ang = false;
         break;
       }
     }
     if(ang) answer++;
     ang = true;
  }
  
  if(answer >= line_threshold){
    if(debugline) output.println("rightupline_true");
    for(int i = 0; i<10; i++){
      compare_answer[i] += rightupline[i];
    }
  } else{
    for(int i = 0; i<10; i++){
      compare_answer[i] -= rightupline[i];
    }
  }
  
}

void leftup_line(PImage img){
  int seed_sero = sero / 4;
  int seed_garo = garo / 2;
  int answer = 0, loc;
  boolean ang=true;
  
  for(int i = seed_sero; i>sero/8; i--){
     for(int j = seed_garo; j>=0; j--){
       loc = location(j,i);
       if(red(img.pixels[loc]) == 0){
        ang = false;
         break;
       }
     }
     if(ang) answer++;
     ang = true;
  }
  
  
  for(int i = seed_sero; i<sero/3; i++){
     for(int j = seed_garo; j>=0; j--){
       loc = location(j,i);
       if(red(img.pixels[loc]) == 0){
         ang = false;
         break;
       }
     }
     if(ang) answer++;
     ang = true;
  }
  
  if(answer >= line_threshold){
    if(debugline) output.println("leftupline_true");
    for(int i = 0; i<10; i++){
      compare_answer[i] += leftupline[i];
    }
  } else{
    for(int i = 0; i<10; i++){
      compare_answer[i] -= leftupline[i];
    }
  }
  
}

void leftdown_line(PImage img){
  int seed_sero = sero * 3 / 4;
  int seed_garo = garo / 2;
  int answer = 0, loc;
  boolean ang=true;
  
  for(int i = seed_sero; i>sero*2/3; i--){
     for(int j = seed_garo; j>=0; j--){
       loc = location(j,i);
       if(red(img.pixels[loc]) == 0){
        ang = false;
         break;
       }
     }
     if(ang) answer++;
     ang = true;
  }
  
  
  for(int i = seed_sero; i<sero*7/8; i++){
     for(int j = seed_garo; j>=0; j--){
       loc = location(j,i);
       if(red(img.pixels[loc]) == 0){
         ang = false;
         break;
       }
     }
     if(ang) answer++;
     ang = true;
  }
  
  if(answer >= line_threshold){
    if(debugline) output.println("leftdownline_true");
    for(int i = 0; i<10; i++){
      compare_answer[i] += leftdownline[i];
    }
  } else{
    for(int i = 0; i<10; i++){
      compare_answer[i] -= leftdownline[i];
    }
  }
  
}

void fill_leftupbox(PImage img){
  int i, loc;
  int answer = 0;
  int seed_sero = sero / 4;
  int seed_garo = garo / 4;
  boolean ang = true;
  
  for(i = seed_sero; ang && i<sero ; i++){
    for(int j = 0; j<garo ; j++){
      loc = location(j,i);
     
      if(j < seed_garo && green(img.pixels[loc]) > 100){
        //ang = false;
        break;
      }
      
      if(green(img.pixels[loc]) > 100){
        img.pixels[loc] = color(0,255,0); 
      }
    }
  }
}


////////////////////////////////////////////////////////////////////
/////////////////// Classification by Lines //////////////////////

void garotracing(PImage img){
  int[] widthimage = new int[sero];
  int ang, prev_ang;
  for(int i = 0; i<sero; i++){
    ang = 0; prev_ang=0;
    for(int j = 0; j<garo; j++){
      int loc = location(j,i);
      prev_ang = ang;
      if(red(img.pixels[loc]) == 0) ang = 1;
      else ang = 0;
      if(ang==1 && prev_ang!=ang) widthimage[i]++;
    }
    if(debug2) output.print(widthimage[i]);
    if(debug2)output.print(" ");
  }
  array_churry_garo(widthimage);
}

void serotracing(PImage img){
  int[] heightimage = new int[garo];
  int ang, prev_ang;
  for(int i = 0; i<garo; i++){
    ang = 0; prev_ang=0;
    for(int j = 0; j<sero; j++){
      int loc = location(i,j);
      prev_ang = ang;
      if(red(img.pixels[loc]) == 0) ang = 1;
      else ang = 0;
      if(ang==1 && prev_ang!=ang) heightimage[i]++;
    }
    if(debug2)output.print(heightimage[i]);
    if(debug2)output.print(" ");
  }
  array_churry_sero(heightimage);
}

boolean IF_ANG(int arrayi, int[] ANG){
   for(int j= 1; j<=angstrong && ANG[j] != 0; j++){
     if(lets_ang && arrayi != ANG[j]) return false;
   }
   return true;
}

void array_churry_garo(int[] array){
  int ang=0, i,j=0, k=0;
  int[] ANG = new int[angstrong+1];
  int[] answer1 = new int[sero];
  int[] answer2 = new int[sero];
  if(debug2) output.println();
  if(debug1) output.print(image_name+"_garo_final ");
  
  //answer1[0] = 1;
  //answer1[j] = 1;
 
  
  // for(int i = 0; i<angstrong; i++){
  //   ANG[i] = array[i]; 
  // }
  
  // for(int i = angstrong; i<sero-1; i++){
  //   if(array[i] != ANG[0] && IF_ANG(array[i], ANG)) {
  //    answer1[j] = array[i];
  //    j++;
  //   }
  //   for(int x = angstrong, y=0; x>=0; x--, y++){
  //     ANG[x] = array[i-y];
  //   }
  // }
  
  // for(int i = 0; i<=j; i++){
  //    if(ang!=answer1[i]) {
  //      answer2[k] = answer1[i];
  //      k++;
  //      ang = answer1[i];
  //    }
  //  }
   
 /////////////////
 if(array[0] == array[1]) {
   answer2[k] = array[1];
   k++;
 }
 
 for(i = 2; i<sero; i++){
   if(array[i] == array[i-1] && array[i] != array[i-2] && array[i] != answer2[0]){
     answer2[k] = array[i]; 
     k++;
     break;
   }
 }
 
 for(; i<sero; i++){
   if(array[i] == array[i-1] && array[i] != array[i-2] && array[i] != answer2[k-1]){
     answer2[k] = array[i]; 
     k++;
   }
 }
    
  for(k=0;answer2[k]!=0;k++) {
     if(debug1) output.print(answer2[k]);
     if(debug1) output.print(" "); 
   }
   if(debug1) output.println();
   
   fillzero(answer2, false);
}



void array_churry_sero(int[] array){
  int ang=0, i,j=0, k=0;
  int[] ANG = new int[angstrong+1];
  int[] answer1 = new int[garo];
  int[] answer2 = new int[garo];
  if(debug2) output.println();
  if(debug1) output.print(image_name+"_sero_final ");
  
  
  
  // for(int i = 0; i<angstrong; i++){
  //   ANG[i] = array[i]; 
  // }
  
  
  // for(int i = angstrong; i<garo-1; i++){
  //   if(array[i] !=ANG[0] && IF_ANG(array[i], ANG)) {
  //    answer1[j] = array[i];
  //    j++;
  //   }
  //   for(int x = angstrong, y=0; x>=0; x--, y++){
  //     ANG[x] = array[i-y];
  //   }
  // }
  

  
  // for(int i = 0; i<=j; i++){
  //    if(ang!=answer1[i]) {
  //      answer2[k] = answer1[i];
  //      k++;
  //      ang = answer1[i];
  //    }
  //  }
   if(array[0] == array[1]) {
   answer2[k] = array[1];
   k++;
 }
   
   for(i = 2; i<garo; i++){
   if(array[i] == array[i-1] && array[i] != array[i-2] && array[i] != answer2[0]){
     answer2[k] = array[i]; 
     k++;
     break;
   }
 }
 
 for(; i<garo; i++){
   if(array[i] == array[i-1] && array[i] != array[i-2] && array[i] != answer2[k-1]){
     answer2[k] = array[i]; 
     k++;
   }
 }
 
  for(k=0;answer2[k]!=0;k++) {
    if(debug1) output.print(answer2[k]);
    if(debug1) output.print(" "); 
   }
   if(debug1) output.println();
   
   fillzero(answer2, true);
}

void fillzero(int[] array, boolean sero){
  int k, maxaddress=0, max = 0;
  int[] answer = new int[9];
  for(k = 0; array[k] != 0; k++){
    if(array[k] > max){
       max = array[k];
       maxaddress = k;
    }
  }
  
  if(k%2 == 1){
    for(int i = 4 - (k / 2), j=0; i < 4 - (k / 2) + k; i++, j++){
       answer[i] = array[j];
    }
  } 
  else{
    for(int i = 4 - maxaddress, j = 0; i < 4 - maxaddress + k; i++, j++){
      answer[i] = array[j];
    }
  }
  
  
  if(sero){
    if(debug3) output.print(image_name+"_sero_fillzero ");
    for(int i=0;i<9;i++){ if(debug3) output.print(answer[i]+" ");}
    if(debug3) output.println();
  }
  else{
    if(debug3) output.print(image_name+"_garo_fillzero ");
    for(int i=0;i<9;i++){if(debug3)  output.print(answer[i]+" ");}
    if(debug3) output.println();
  }
  
  compare2(answer, sero);
}



void compare2(int[] array, boolean sero){
    for(int i=0;i<10;i++){
      compare_answer[i] += 10;
      for(int j=0;j<9;j++){
        if(sero){
          compare_answer[i] -= abs(heightarray[i][j] - array[j]);
        }
        else{
          compare_answer[i] -= abs(widtharray[i][j] - array[j]);
        }
    }
  }
}



void nnsort(int[] array){
  output.print(image_name+"_answer ");
  int max = 0;
  boolean ang = false;
  
  for(int i=0;i<10;i++){
    if(array[i]>max){
      max=array[i];
    }
  }
  
  for(int i =0; i<10; i++){
    if(array[i] == max && i == ANSWER) {
      SCORE++;
      println(" Correct!");
      break;
    }
    if(i==9) println(" Wrong!");
  }
  
  if(debug0){
    for(;max>0;max--){
      for(int i=0;i<10;i++){
        if(array[i]==max) output.print(i+" " );
      }
      output.print("/");
    }
  }else for(int i = 0; i<10; i++){
    if(array[i] == max){
      if(ang) output.print(" or ");
      output.print(i);
      ang = true;
    }
  }
  output.println();
  
  
}

void setup(){
  int j=1;
  boyoung = loadImage("boyoung.jpg");
  String day = Integer.toString(day());
  String hour = Integer.toString(hour());
  String m = Integer.toString(minute());
  String sec = Integer.toString(second());
  output = createWriter("log\\"+day+"_"+hour+"_"+m+"_"+sec+".txt");
  for(ANSWER=0;ANSWER<10;ANSWER++){
    for(j=1;j<=6;j++){
      //if((ANSWER==1||ANSWER==2)&&(j==7||j==8)) continue;
      //if(ANSWER==7&&(j==5||j==6)) continue;
      String i_s=Integer.toString(ANSWER);
      String j_s=Integer.toString(j);
      image_name=i_s+"_"+j_s+".jpg";
      image_name_final=i_s+"_"+j_s+".png";
      getimage = loadImage(image_name);
      getxywh(getimage);
      cropimage = getimage.get(x,y,w,h);
      recolor(cropimage,120);
      cropimage.resize(garo,sero);
      resizeimage=cropimage;
      recolor(resizeimage,40);
      if(debug2) output.print(image_name+"_garo ");
      garotracing(resizeimage);
      if(debug3) output.println();
      if(debug2) output.print(image_name+"_sero ");
      serotracing(resizeimage);
      if(debug3) output.println();
      //
      classify_one(resizeimage);
      classify_zero(resizeimage);
      classify_seven(resizeimage);
      rightup_line(resizeimage);
      leftup_line(resizeimage);
      leftdown_line(resizeimage);
      //
    
      resizeimage.save("final\\"+image_name_final);
      print(image_name_final+" done!");
      
      nnsort(compare_answer);
      if(debug1||debug2||debug3) output.println();
      
      for(int k = 0; k<10; k++){
        compare_answer[k]=0; 
      }
    }
  }
  println(" ");
  println("All Done!!!");
  /*getimage =  loadImage("fuckimage.jpg");
  getxywh(getimage);
  cropimage = getimage.get(x,y,w,h);   
  cropimage.resize(garo,sero);
  resizeimage=cropimage;
  recolor(resizeimage);
  garotracing(resizeimage);
  serotracing(resizeimage);*/
  output.flush();
  output.close();
  boyoung.resize(displayWidth-100,displayHeight-100);
  size(displayWidth-100,displayHeight-100);

  double percent = SCORE*100 / (ANSWER*(j-1));
  println(percent+"%");
  background(boyoung);
}

void loop(){
 
}


boolean bnw(PImage img, int loc){
  float r = red(img.pixels[loc]);
  float g = green(img.pixels[loc]);
  float b = blue(img.pixels[loc]);
  r = constrain(r,0,255);
  g = constrain(g,0,255);
  b = constrain(b,0,255);
  if((r<offset)&&(g<offset)&&(b<offset)) return true;
  else return false;
}

boolean rebnw(PImage img, int loc, int reoffset){
  float r = red(img.pixels[loc]);
  float g = green(img.pixels[loc]);
  float b = blue(img.pixels[loc]);
  r = constrain(r,0,255);
  g = constrain(g,0,255);
  b = constrain(b,0,255);
  if((r<reoffset)&&(g<reoffset)&&(b<reoffset)) return true;
  else return false;
}

void recolor(PImage img,int offset){
  for(int i=0;i<img.width;i++){
    for(int j=0;j<img.height;j++){
      int loc = i+(j*img.width);
      if(rebnw(img,loc,offset)) img.pixels[loc]=color(0);
      else img.pixels[loc]=color(255);
    }
}
}

void getxywh(PImage img){
  img.loadPixels();
  int i,j;
  boolean ang=false;
  for(i=0;i<img.width;i++){
    for(j=0;j<img.height;j++){
      int loc = i+(j*img.width);
      if(bnw(img,loc)) {
      x=i; ang=true; break;
    }
    }
    if(ang) break;
  }
  
  ang=false;
  
  for(i=img.width-1;i>x;i--){
    for(j=0;j<img.height;j++){
      int loc = i+(j*img.width);
      if(bnw(img,loc)) {
      w=i-x; ang=true; break;
    }
    }
    if(ang) break;
  }
  
  ang=false;
  
  for(j=0;j<img.height;j++){
    for(i=0;i<img.width;i++){
      int loc = i+(j*img.width);
      if(bnw(img,loc)) {
      y=j; ang=true; break;
    }
    }
    if(ang) break;
  }
  
  ang=false;
  
  for(j=img.height-1;j>y;j--){
    for(i=0;i<img.width;i++){
      int loc = i+(j*img.width);
      if(bnw(img,loc)) {
      h=j-y; ang=true; break;
    }
    }
    if(ang) break;
  }
  
  ang=false;
}

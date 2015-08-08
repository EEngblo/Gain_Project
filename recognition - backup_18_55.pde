PImage getimage,cropimage,resizeimage,boyoung;
PrintWriter output;
int Max_Arr=9;
int x=0,y=0,w=0,h=0,offset=80;
int sero =60, garo = 30;
int angstrong = 5;
String image_name_final;
String image_name;
int[] compare_answer = new int[10];
boolean debug = false;


int[][] heightarray =
{{0,0,0,1,2,1,0,0,0}, //0
 {0,0,0,0,1,0,0,0,0},
 {0,0,0,1,3,1,0,0,0}, //2
 {0,0,1,3,4,3,1,0,0},
 {0,0,1,2,1,2,1,0,0}, //4
 {0,0,0,1,3,1,0,0,0},
 {0,0,0,1,3,2,1,0,0}, //6
 {0,0,0,1,2,1,0,0,0},
 {0,0,0,1,4,3,1,0,0}, //8
 {0,0,1,2,3,1,0,0,0}
};

int[][] widtharray =
{{0,0,0,1,2,1,0,0,0}, 
 {0,0,0,0,1,0,0,0,0}, //1
 {0,0,0,1,2,1,0,0,0}, 
 {0,0,1,2,1,2,1,0,0}, //3
 {0,0,0,1,2,1,0,0,0},
 {0,0,0,1,2,1,0,0,0}, //5
 {0,0,0,1,2,1,0,0,0},
 {0,0,0,1,2,1,0,0,0}, //7
 {0,0,1,2,1,2,1,0,0},
 {0,0,0,1,2,1,0,0,0}  //9
};

void garotracing(PImage img){
  int[] widthimage = new int[sero];
  int ang, prev_ang;
  for(int i = 0; i<sero; i++){
    ang = 0; prev_ang=0;
    for(int j = 0; j<garo; j++){
      int loc = j+(i*garo);
      prev_ang = ang;
      if(red(img.pixels[loc]) == 0) ang = 1;
      else ang = 0;
      if(ang==1 && prev_ang!=ang) widthimage[i]++;
    }
    if(debug) output.print(widthimage[i]);
    if(debug)output.print(" ");
  }
  array_churry_garo(widthimage);
}

void serotracing(PImage img){
  int[] heightimage = new int[garo];
  int ang, prev_ang;
  for(int i = 0; i<garo; i++){
    ang = 0; prev_ang=0;
    for(int j = 0; j<sero; j++){
      int loc = i+(j*garo);
      prev_ang = ang;
      if(red(img.pixels[loc]) == 0) ang = 1;
      else ang = 0;
      if(ang==1 && prev_ang!=ang) heightimage[i]++;
    }
    if(debug)output.print(heightimage[i]);
    if(debug)output.print(" ");
  }
  array_churry_sero(heightimage);
}

boolean IF_ANG(int arrayi, int[] ANG){
   for(int j= 1; j<=angstrong; j++){
     if(arrayi != ANG[j]) return false;
   }
   return true;
}

void array_churry_garo(int[] array){
  int ang=0, j=1, k=0;
  int[] ANG = new int[angstrong+1];
  int[] answer1 = new int[sero];
  int[] answer2 = new int[sero];
  if(debug) output.println();
  if(debug) output.print(image_name+"_garo_final ");
  
  for(int i = 0; i<angstrong; i++){
    ANG[i] = array[i]; 
  }
  
  answer1[0]=1;
  
  for(int i = angstrong+1; i<sero-1; i++){
    if(array[i] != ANG[0] && IF_ANG(array[i], ANG)) {
     answer1[j] = array[i];
     j++;
    }
    for(int x = angstrong, y=0; x>=0; x--, y++){
      ANG[x] = array[i-y];
    }
  }
  
  answer1[j] = 1;
  
  for(int i = 0; i<=j; i++){
     if(ang!=answer1[i]) {
       answer2[k] = answer1[i];
       k++;
       ang = answer1[i];
     }
   }
   
  for(k=0;answer2[k]!=0;k++) {
     if(debug) output.print(answer2[k]);
     if(debug) output.print(" "); 
   }
   if(debug) output.println();
   
   fillzero(answer2, false);
}



void array_churry_sero(int[] array){
  int ang=0, j=1, k=0;
  int[] ANG = new int[angstrong+1];
  int[] answer1 = new int[garo];
  int[] answer2 = new int[garo];
  if(debug) output.println();
  if(debug) output.print(image_name+"_sero_final ");
  
  for(int i = 0; i<angstrong; i++){
    ANG[i] = array[i]; 
  }
  
  answer1[0] = 1;
  
  for(int i = angstrong+1; i<garo-1; i++){
    if(array[i] !=ANG[0] && IF_ANG(array[i], ANG)) {
     answer1[j] = array[i];
     j++;
    }
    for(int x = angstrong, y=0; x>=0; x--, y++){
      ANG[x] = array[i-y];
    }
  }
  
  answer1[j] = 1;
  
  for(int i = 0; i<=j; i++){
     if(ang!=answer1[i]) {
       answer2[k] = answer1[i];
       k++;
       ang = answer1[i];
     }
   }
   
  for(k=0;answer2[k]!=0;k++) {
    if(debug) output.print(answer2[k]);
    if(debug) output.print(" "); 
   }
   if(debug) output.println();
   
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
    if(debug) output.print(image_name+"_sero_fillzero ");
    for(int i=0;i<9;i++){ if(debug) output.print(answer[i]+" ");}
    if(debug) output.println();
  }
  else{
    if(debug) output.print(image_name+"_garo_fillzero ");
    for(int i=0;i<9;i++){if(debug)  output.print(answer[i]+" ");}
    if(debug) output.println();
  }
  
  //compare1(answer, sero);
  compare2(answer, sero);
}

void compare1(int[] array, boolean sero){
    for(int i=0;i<10;i++){
      for(int j=0;j<9;j++){
        if(sero){
          if(heightarray[i][j]==array[j]) compare_answer[i]++;
        }
        else{
          if(widtharray[i][j]==array[j]) compare_answer[i]++;
        }
    }
  }
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
  
  for(int i=0;i<10;i++){
    if(array[i]>max){
      max=array[i];
    }
  }
  
  for(;max>0;max--){
    for(int i=0;i<10;i++){
      if(array[i]==max) output.print(i+" " );
    }
    output.print("/");
  }
  output.println();
  
  
}

void setup(){
  boyoung = loadImage("boyoung.jpg");
  String hour = Integer.toString(hour());
  String m = Integer.toString(minute());
  String sec = Integer.toString(second());
  output = createWriter(hour+"_"+m+"_"+sec+".txt");
  for(int i=0;i<10;i++){
    for(int j=1;j<9;j++){
      String i_s=Integer.toString(i);
      String j_s=Integer.toString(j);
      image_name=i_s+"_"+j_s+".jpg";
      image_name_final=i_s+"_"+j_s+".png";
      getimage = loadImage(image_name);
      getxywh(getimage);
      cropimage = getimage.get(x,y,w,h);
      //recolor(cropimage,80);
      cropimage.resize(garo,sero);
      resizeimage=cropimage;
      recolor(resizeimage,100);
      if(debug) output.print(image_name+"_garo ");
      garotracing(resizeimage);
      if(debug) output.println();
      if(debug) output.print(image_name+"_sero ");
      serotracing(resizeimage);
      output.println();
      nnsort(compare_answer);
      output.println();
      resizeimage.save("final\\"+image_name_final);
      println(image_name_final+" done!");
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

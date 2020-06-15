var datetime=DateTime.now();


int current(){
  int hr=datetime.hour;
  int min=datetime.minute;
  int x=0;
  if(hr==9){
    x=0;
  }
  if(hr==10 && min<55){
    x=1;
  }
  if( (hr==10 && min>=55)|| (hr==11 && min<=05)){
    x=2;
  }
  if (hr==11 && min>5){
    x=3;
  }
  if(hr==12 && min<55){
    x=4;
  }
  if((hr==12 && min>55)||(hr==13 && min<=40)){
    x=5;
  }
  if((hr==13 && min>40) ||(hr==14 && min<35)){
    x=6;
  }
  if((hr==14 && min>=35)&&(hr==15 && min<=30)){
    x=7;
  }
  if((hr==15 && min>30)|| (hr==16 && min<=30)){
    x=8;
  }
  return x;
}
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'timerModel.dart';

class CountDownT {
  int workTime=30;
  

  double radius = 1;
  bool isActive = true;
  Timer timer;
  Duration time;
  Duration fullTime;
  // void setWork(Duration duration){
  //   radius=1;
  //   time=duration;
  //   fullTime=time;
  // }
  readData(String v) async{
    radius=1;
    SharedPreferences sp= await SharedPreferences.getInstance();
    if(v=='workTime'){
      int w=sp.getInt(v)==null?15:sp.getInt(v);
      this.time=Duration(minutes: w,seconds: 0);

    }
    else if(v=='shortBreak'){
             int w=sp.getInt(v)==null?15:sp.getInt(v);

      this.time=Duration(minutes: w,seconds: 0);
    }
    else{      int w=sp.getInt(v)==null?15:sp.getInt(v);


      this.time=Duration(minutes: w,seconds: 0);
    }
    fullTime=time;


  }
  String returnTime(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds =
        (numSeconds < 10) ? '0' + numSeconds.toString() : numSeconds.toString();
    String formattedTime = minutes + ":" + seconds;
    return formattedTime;
  }
Stream<TmModel> stream() async* {
 yield*  Stream.periodic(Duration(seconds: 1), (_) {
 String time;
 if (this.isActive) {
 this.time = this.time-Duration(seconds: 1);
 this.radius = this.time.inSeconds / this.fullTime.inSeconds;
 if (this.time.inSeconds <= 0) {
 this.isActive = false;
 }
 }
 time = returnTime(this.time);
 return TmModel(time:time, precent:this.radius);
 });
 }

}


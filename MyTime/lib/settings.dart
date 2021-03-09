import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MyWidgets.dart';
class SetttingTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set your Time"),
      ),
      body: Setting(),
    );
  }
}

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
  
}

class _SettingState extends State<Setting> {
  TextEditingController w =TextEditingController();
  TextEditingController shB=TextEditingController();
  TextEditingController loB=TextEditingController();
  static const String WORKTIME = "workTime";
static const String SHORTBREAK = "shortBreak";
static const String LONGBREAK = "longBreak";
int workTime;
int shortBreak;
int longBreak;
SharedPreferences dataPref;
 //readData();
 @override
 void initState() {
  readData();

    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
   //print(w.value);
    return Container(
        
      padding: EdgeInsets.all(20),
       child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3,
              children: [
                Text("",style: TextStyle(fontSize: 20)),
                Text(''),
                Text('فترة العمل',textDirection: TextDirection.rtl,),
                SettingButton(color:Colors.green,value: -1,string: "-", onPressd:
                  writeData
                  
                ,setting: WORKTIME,)
                ,
                TextField(
                  controller: w,
                  decoration: InputDecoration(),
                  keyboardType:TextInputType.number,

                ),                
                SettingButton(color:Colors.blue,value: 1,string: "+", onPressd: 
                   writeData,setting: WORKTIME,),
                Text("",style: TextStyle(fontSize: 20),),
                Text(''),
                Text('فترة الراحة القصيرة',textDirection: TextDirection.rtl,),
                SettingButton(color:Colors.green,value: -1,string: "-" , onPressd:writeData,setting:SHORTBREAK
                ,)
                ,
                TextField(
                  controller: shB,
                  //decoration: InputDecoration(),
                  keyboardType:TextInputType.number,

                ),                
                SettingButton(color:Colors.blue,value: 1,string: "+", onPressd: writeData,setting: SHORTBREAK, ),
                Text("",style: TextStyle(fontSize: 20),),
                Text(''),
                Text('فترة الراحةالطويلة',textDirection: TextDirection.rtl,),
                SettingButton(color:Colors.green,value: -1,string: "-", onPressd:writeData,setting: LONGBREAK, )
                ,
                TextField(
                  controller: loB,
                  //decoration: InputDecoration(),
                  keyboardType:TextInputType.number,

                ),                
                SettingButton(color:Colors.blue,value: 1,string: "+", onPressd:writeData,setting: LONGBREAK, )




               


              ],


       ),

    );
  }
  readData() async{
    //this will return future and we use await to suspend the code until datapref initialized;
    dataPref=await SharedPreferences.getInstance();
    workTime=dataPref.getInt(WORKTIME);
    if(workTime==null){
   await dataPref.setInt(WORKTIME,20);
   workTime=dataPref.getInt(WORKTIME);

    }
    shortBreak=dataPref.getInt(SHORTBREAK);
    if(shortBreak==null){
  await dataPref.setInt(SHORTBREAK,1);   
   shortBreak=dataPref.getInt(SHORTBREAK);


    }
    longBreak=dataPref.getInt(LONGBREAK);
    if(longBreak==null){
       await dataPref.setInt(LONGBREAK,3);    
       longBreak=dataPref.getInt(LONGBREAK);


    }
    setState(() {
      w.text=workTime.toString();
      shB.text=shortBreak.toString();
      loB.text=longBreak.toString();
    });

  }
  void writeData(String k, int value){
    switch(k){
      case WORKTIME :{
           workTime=dataPref.getInt(WORKTIME);
           workTime+=value;
           if(workTime>=1&&workTime<=180){
             dataPref.setInt( WORKTIME , workTime);
             setState(() {
               w.text=workTime.toString();
             });
           }
      }
          break;
          case LONGBREAK :{
           longBreak=dataPref.getInt(LONGBREAK);
           longBreak+=value;
           if(longBreak>=1&&workTime<=180){
             dataPref.setInt(LONGBREAK , longBreak);
             setState(() {
               loB.text=longBreak.toString();
             });
           }}
          break;
          case SHORTBREAK :{
           shortBreak=dataPref.getInt(SHORTBREAK);
           shortBreak+=value;
           if(shortBreak>=1&&workTime<=180){
             dataPref.setInt( SHORTBREAK , shortBreak);
             setState(() {
               shB.text=shortBreak.toString();
             });
           }
          } 
          break;



    }

  }
}

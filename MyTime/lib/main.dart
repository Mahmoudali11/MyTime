import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'timer.dart';
import 'timerModel.dart';
import 'settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromRGBO(29, 53, 87  ,1)),
      routes:{
        '/':(context){
          return MyHomePage();
          
        },
        '/settings':(context){
          return SetttingTime();
        }

      }
     
    );
  }
}

  
  
   
 
class MyHomePage extends StatelessWidget {
final t = CountDownT();




  @override
  Widget build(BuildContext context) {
    
     
    final  List<PopupMenuItem> popMItem=[];
   popMItem.add( PopupMenuItem(child: Text('Settings'),value: 'Settings',));
    
      t.readData('workTime');
      t.isActive=false;
    return Scaffold(
      backgroundColor: Color.fromRGBO(29, 53, 87, 1),
      appBar: AppBar(
        actions: [
          PopupMenuButton(itemBuilder: (context){
        return popMItem;


          },onSelected:(value){
            if(value=='Settings')
            Navigator.push(context,MaterialPageRoute(builder: (context){
              return SetttingTime();
            }) );

          })

        ],
        title: Text('!نظم وقتك بسهولة'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
          final double width = constrains.maxWidth;
          return Container(
              child: Column(
           // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(padding: EdgeInsets.all(5)),
                    //or you can use sized box to make the same job
                    //SizedBox(width:10),
                    Expanded(
                      child: RaisedButton(
                        child: Text("فترة عمل",),
                        color: Colors.red,
                        onPressed: () {
                     t.readData('workTime');
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Expanded(
                      child: RaisedButton(
                        child: Text("راحة قصيرة"),
                        color: Colors.green,
                        onPressed: () {
                             t.readData('shortBreak');
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Expanded(
                      child: RaisedButton(
                        child: Text("راحة طويلة"),
                        color: Colors.blue,
                        onPressed: () {
                             t.readData('longBreak');
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5))
                  ]),
              Expanded(
                  child: Center(
                    child: StreamBuilder(
                      //intial valut till data come from stream
                        initialData: '00:00',
                        stream: t.stream(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          TmModel timer = (snapshot.data == '00:00')
                              ? TmModel(time: '00:00', precent: 1)
                              : snapshot.data;
                            
                             
                              print((snapshot.data));
                          return CircularPercentIndicator(
                            radius: width / 2,
                            lineWidth: 15.0,
                            percent: timer.precent,
                            center: Text(
                          timer.time,
                          style:TextStyle(fontSize: 27,color: Colors.white) ,
                            ),
                            progressColor: Colors.teal,
                          );
                        }),
                  )),
                 
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(5)),
                  Expanded(
                    child: RaisedButton(
                      child: Text("إقاف"),
                      color: Color.fromRGBO(227, 27, 90, 1),
                      onPressed: () {
                        t.isActive=false;
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Expanded(
                    child: RaisedButton(
                      child: Text("بدء"),
                      color: Color.fromRGBO(14, 83, 154, 1),
                      onPressed: () {
                        if(t.time.inSeconds>0)

                        t.isActive=true;
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                ],
              )
            ],
          ));
        },
      ),
    );
  }
}

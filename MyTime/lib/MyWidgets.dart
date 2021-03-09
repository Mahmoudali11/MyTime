import 'package:flutter/material.dart';
typedef onPressd=void Function(String,int);
class SettingButton extends StatelessWidget {
  final Color color;
  final String string;
  final int value;
  final onPressd;
  final String setting;
  
  SettingButton({this.color,this.string,this.value,this.onPressd,this.setting});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: this.color,
      child: Text(this.string,style: TextStyle(fontSize: 22),),
      onPressed:(){this.onPressd(this.setting,this.value);},

      
    );
  }
}
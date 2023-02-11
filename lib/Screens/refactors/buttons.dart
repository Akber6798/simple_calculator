import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({this.color, this.buttonText, this.textColor,this.buttonTapped});

  Color? color;
  Color? textColor;
  String? buttonText;
  final buttonTapped;
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText!,
                style: TextStyle(color: textColor,fontSize:25 ,fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
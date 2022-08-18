
import 'package:flutter/material.dart';


class MyButtonWidget extends StatelessWidget {
  const MyButtonWidget({
    Key? key,
    required this.btnTxt,
    required this.btnWidth,
    required this.btnHeight,
    required this.onPressed, required this.color, required this.borderColor, required this.textColor, this.textSize, this.weight,
  }) : super(key: key);

  final String btnTxt;
  final double btnWidth;
  final double btnHeight;
  final VoidCallback onPressed;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final double? textSize;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: btnWidth,
        height: btnHeight,
        decoration: BoxDecoration(
            color: color,
            border: Border.all(color: borderColor,width: 1.2),
            borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text(btnTxt,style: TextStyle(color: textColor,fontWeight: weight,fontSize: textSize),),),
      ),
    );
  }
}

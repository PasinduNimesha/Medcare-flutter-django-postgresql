import 'package:flutter/material.dart';

Container line(Color linecolour,double widthLine,double heightLine){
  return Container(
    width: widthLine , //200.0
      height:heightLine , //10.0
      decoration: BoxDecoration(
        color:linecolour,
        borderRadius: BorderRadius.circular(5.0),
      ),
  );

}
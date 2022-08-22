
// ignore: file_names
import 'package:flutter/material.dart';

class TextStyler extends Text{
  TextStyler(String data,{Key? key, fonSize:10.0,fontWeight:FontWeight.normal,factory:1.5,color:Colors.black,align:TextAlign.start}):
  super(key: key, 
    data, 
    style: TextStyle(
      fontSize: fonSize, 
      fontWeight: fontWeight, 
      color: color, 
      
    ), 
    textAlign: align
    
  );
}
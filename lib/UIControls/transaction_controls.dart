import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wingsgraphqltransaction/CommonComponets/components.dart';

Widget getControl(var dataType,String caption,var textController,BuildContext context){
  
  if (dataType=='Button') {
    RaisedButton raisedButton=RaisedButton(
      child: Text(caption),
      onPressed: (){}
    );
    return raisedButton;
  }
  else{
  TextFormField textFormField= wTextFormFieldSingleRow(caption,textController,context);
  return textFormField;
  }
}


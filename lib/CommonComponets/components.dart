import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wingsgraphqltransaction/UIControls/singlerowpage.dart';
import '../UIControls/additems_combo.dart';
import '../UIControls/singlerow_combo.dart';



Widget wTextFormFieldSingleRow(String caption,TextEditingController textController,BuildContext context){
  

  TextFormField txtform= TextFormField(
    controller:textController,
    readOnly: true,
    decoration: InputDecoration(
      labelText: caption,  
      
    ),
    onTap:()async{
    final result =await Navigator.of(context).pushNamed(SingleRowCombo.routeName,arguments: caption);
    textController.text=result.toString();
    if (SingleRowPage.autoValidate) {
      SingleRowPage.formKey.currentState.validate();
    }
    print(SingleRowCombo.routeName);
    },
    validator: (val){
        if (val=='null'||val.isEmpty) {
          return 'Please Enter $caption value';
        }
        return null;
    },
    onChanged: (val){
      val=textController.text;
    },
    
    // onSaved:(val){
    //   textController.text=val;
    // } ,
  );
  
  return txtform;
}

Widget wTextFormFieldMultirow(String caption,TextEditingController textController,BuildContext context){
  TextFormField txtform= TextFormField(
    controller:textController,
    readOnly: true,
    decoration: InputDecoration(
      labelText: caption,  
      
    ),
    onTap:()async{
    final result =await Navigator.of(context).pushNamed(AddItemsCombo.routeName,arguments: caption);
    textController.text=result.toString();
    },
   
  );
  
  return txtform;
}
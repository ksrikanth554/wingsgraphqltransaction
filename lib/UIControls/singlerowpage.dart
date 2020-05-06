import 'package:flutter/material.dart';
import 'package:wingsgraphqltransaction/CommonComponets/components.dart';
import 'package:wingsgraphqltransaction/UIControls/transaction_controls.dart';
import 'package:wingsgraphqltransaction/data/singlerowcontrollerdata.dart';



class SingleRowPage extends StatefulWidget {
  static bool autoValidate=false;
  List<Map> listColumns=[];
  String tabName;
  static final formKey=GlobalKey<FormState>();
  SingleRowPage(this.listColumns,this.tabName);
  @override
  _SingleRowPageState createState() => _SingleRowPageState();
}

class _SingleRowPageState extends State<SingleRowPage> {
  
  var dataType;
  var caption;
    Map<String,String> fieldMap={};
    Map<String,Map<String,TextEditingController>> textEditControllersMap={};
    Map<String,TextEditingController> textEditControllers={};
    List<Widget> singleRowControls=[];
    Map<String,List<Widget>> singlerowMap={};
    
  @override
  Widget build(BuildContext context) {
    
    
    if (singlerowMap[widget.tabName]==null) {
      for (var col in widget.listColumns) {
        dataType=col['DataType'];
        caption=col['Caption'];
        var tData;
        if (singleRowControllerData!=null) {
          if (singleRowControllerData[widget.tabName]!=null) {
            if (singleRowControllerData[widget.tabName][caption]!=null) {
              
               tData=singleRowControllerData[widget.tabName][caption];
               
            }
            
          }
        }
         var textController=TextEditingController(text:tData!=null?tData:'');
          textEditControllers[caption]=textController;
          singleRowControls.add(getControl(dataType,caption, textController,context));
         
      }
        textEditControllersMap[widget.tabName]=textEditControllers;
        singlerowMap[widget.tabName]=singleRowControls;
       
            
    }
    
    return Form(
      autovalidate: SingleRowPage.autoValidate,
      
      key:SingleRowPage.formKey ,
       child: Scaffold(
        body: Container(
          child: ListView.builder(
            itemCount: singlerowMap[widget.tabName].length,
            itemBuilder: (ctx,index){
              TextFormField txtControl=singlerowMap[widget.tabName][index];
              String key=textEditControllers.keys.elementAt(index);
              var textdData=txtControl.controller.text; 
              if (textdData.isNotEmpty) {
                
                fieldMap[key]=textdData;
                singleRowControllerData[widget.tabName]=fieldMap;
                
              }
              return Container(
                child: singlerowMap[widget.tabName][index],
                
              );
            }
          ),
        ),
      ),
    );
  }
}
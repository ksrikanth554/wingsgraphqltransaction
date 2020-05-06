import 'package:flutter/material.dart';
import 'package:wingsgraphqltransaction/CommonComponets/components.dart';
import 'package:wingsgraphqltransaction/UIControls/multirowpage.dart';

class MultiRowAddItems extends StatefulWidget {
 final List cNames;
 final String tabName;
  MultiRowAddItems(this.cNames,this.tabName);

  @override
  _MultiRowAddItemsState createState() => _MultiRowAddItemsState();
}

class _MultiRowAddItemsState extends State<MultiRowAddItems> {
  Map<String,String> itemsMap={};
  Map<String,Map<String,String>> itemMapWithTab={};
  
   Map<String,TextEditingController> textEditControllers={};
   var textfield=<TextFormField>[]; 
  @override
  Widget build(BuildContext context) {
    if (textfield.isEmpty) {
        widget.cNames.forEach((str){
          var textController=TextEditingController();
          textEditControllers.putIfAbsent(str, ()=>textController);
          return textfield.add(wTextFormFieldMultirow(str, textController,context));
        });    
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height*0.06,
          bottom: MediaQuery.of(context).size.height*0.04,
          left: MediaQuery.of(context).size.width*0.05,
          right: MediaQuery.of(context).size.width*0.05,

        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0)
        ),
       // color: Colors.white,
        
          child: Column(
            children: <Widget>[
              Container(child: Text('Add items',textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color:Colors.black,decoration:TextDecoration.none),)),
              Expanded(
                child:ListView.builder(
                  itemCount: textfield.length,
                  itemBuilder: (ctx,index){
                   //TextFormField textFormField=wTextFormField(widget.cNames[index]);

                   return Container(
                     margin: EdgeInsets.only(left:10,right: 10),
                     child: textfield[index]
                    );
                  }
                )
              ),
              Padding(
                padding:  EdgeInsets.only(right:MediaQuery.of(context).size.width*0.01),
                child: Row(
                  
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      color: Colors.blue,
                      child: Text('Cancel'),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 1,),
                    FlatButton(
                       shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      color: Colors.blue,
                        child: Text('Ok'),
                        onPressed: (){
                          widget.cNames.forEach((str){
                           itemsMap[str]=textEditControllers[str].text;
                           
                          });
                          setState(() {
                          Navigator.of(context).pop();
                          itemMapWithTab[widget.tabName]=itemsMap;
                          MultiRowPage.itemList.add(itemMapWithTab);     
                            
                          });
                        },
                      ),
                     SizedBox(width: 1,),
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
}
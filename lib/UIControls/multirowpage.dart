import 'package:flutter/material.dart';
import 'package:wingsgraphqltransaction/UIControls/additems_alert.dart';


class MultiRowPage extends StatefulWidget {
 final List<String> cNames;
 final String tabName;
 static List<Map<String,Map<String,String>>> itemList=[];
  MultiRowPage(this.cNames,this.tabName);
  
  @override
  _MultiRowPageState createState() => _MultiRowPageState();
}

class _MultiRowPageState extends State<MultiRowPage> {
  Map <int,bool> isSelMap={};
  Map<int,ListItem<Map<String,String>>> filteredList={};
  int getItemsLength(Map isSelecetMap){
     
     for (var i = 0; i < MultiRowPage.itemList.length; i++) {
       for (var key in MultiRowPage.itemList[i].keys) {
         if (key==widget.tabName) {
           
           //filteredList.add(ListItem<Map<String,String>>(MultiRowPage.itemList[i][key]));
           //filteredList[i].isSelected=true;
           filteredList[i]=ListItem<Map<String,String>>(MultiRowPage.itemList[i][key]);
         }
       }
     }
     if (isSelMap.length>0) {
       for (var key in isSelMap.keys) {
         filteredList[key].isSelected=isSelMap[key];
       }
       
    }
     return filteredList.length;
  }

  @override
  Widget build(BuildContext context) {
    
    filteredList.clear();
    getItemsLength(isSelMap);
    return Scaffold(
          body:widget.cNames.isNotEmpty? Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                  child: Container(
                    padding:EdgeInsets.all(MediaQuery.of(context).size.height*0.01),
                    color: Colors.blue,
                    child: GridView.builder(
                      
                    itemCount: widget.cNames.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,childAspectRatio: 2,), 
                    itemBuilder: (context,index) {
                      return Container(
                        child: Text(widget.cNames[index],style:TextStyle(color: Colors.black),));
                    },

                  ),
                 ),
              ),
              Divider(height: 2,thickness: 2,color: Colors.black,),
              Expanded(
                flex: 5,
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (ctx,index){
                  int keyVal=filteredList.keys.elementAt(index);
                  Map data=filteredList[keyVal].data;
                   return  GestureDetector(
                 child: filteredList[keyVal].isSelected==false?listItemView(data) :deleteItemView(data,keyVal),
              
              onLongPress: (){
                  isSelMap[keyVal]=true;
                  setState(() {
                  });
                 
              },
              onTap: (){
                isSelMap[keyVal]=false;
                setState(() {
                  
                });
              },
           );
            }
          ),
        ),
      ],
    ):null,
    floatingActionButton: InkWell(
              child: CircleAvatar(
          child: Icon(Icons.add),
          ),
          onTap: (){
            showDialog(context: context,
            builder: (ctx)=>MultiRowAddItems(widget.cNames,widget.tabName),  
            ).then((ret){
              setState(() {
                
              });
            });
          },
    ),
         
  );
  }

  Widget deleteItemView(Map data,int keyVal){
    return Column(
      children: <Widget>[
        Container(
                    color: Colors.orange,
                   
                    child: Row(
                      children:<Widget>[
                          Expanded(
                             child: Column(
                               children: <Widget>[
                                 Container(
                                  height: MediaQuery.of(context).size.height*0.15,
                                  color: Colors.orange,
                                  child: GridView.builder(
                                    
                                    physics: ScrollPhysics(),
                                  itemCount: widget.cNames.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,childAspectRatio: 2), 
                                  itemBuilder: (context,index) {
                                    
                                    return Container(
                                      child: Text(data[widget.cNames[index]],style:TextStyle(color: Colors.black),));
                                  },

                        ),
                       ),
                       Divider(height: 1,)
                     ],
                    ),
                 ),
                 IconButton(icon: Icon(Icons.delete), 
                 onPressed: (){
                    // MultiRowPage.itemList.add(itemMapWithTab); 
                    MultiRowPage.itemList.removeAt(keyVal);
                    isSelMap.remove(keyVal);
                    setState(() {
                      
                    });
                 })
                ]

               ),
          ),
          Divider(height: 2,)
      ],
    );

  }
  Widget listItemView(Map data){

    return  Column(
                    children: <Widget>[
                      Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                         color: Colors.pink[200],
                      ),
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                      margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                      height: MediaQuery.of(context).size.height*0.15,
                     
                      child: GridView.builder(
                        
                        physics: ScrollPhysics(),
                      itemCount: widget.cNames.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,childAspectRatio: 2), 
                      itemBuilder: (context,index) {
                        
                        return Container(
                          child: Text(data[widget.cNames[index]],style:TextStyle(color: Colors.black),));
                      },

                   ),
                ),
                Divider(height: 1,)
            ],
    );

  }
}

class ListItem<T> {
bool isSelected = false; //Selection property to highlight or not
T data; //Data of the user
ListItem(this.data); //Constructor to assign the data
}
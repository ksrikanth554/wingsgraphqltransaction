import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:toast/toast.dart';
import '../graphql_config.dart';
import '../model/item_model.dart';
import '../queries/add_items_queries.dart';
import '../user_interface/alert_add_items.dart';

class AddItems extends StatefulWidget {
  static List<List> addItems=[];
  @override
  _AddItemsState createState() => _AddItemsState();
}





class _AddItemsState extends State<AddItems> {
  GraphQlConfiguration graphQlConfiguration=GraphQlConfiguration();
  List<String> cNames=[];
  var tPrice;
  //List<AddItemModel> addItems=List<AddItemModel>();
 
  //Map<dynamic,dynamic> mapData={};
  //var cval=[];
  //int listLength;
  fillList()async{
    AddItems.addItems.clear();
    AddItemsQuery addItemsQuery=AddItemsQuery();
    GraphQLClient _client=graphQlConfiguration.clientQuery();
    QueryResult result=await _client.query(
      QueryOptions(
        document: addItemsQuery.addItems()
      )
    );
    if(!result.hasException){
     // listLength=result.data["items"].length;
      for (var i=0;i<result.data["items"].length;i++) {
        var value = result.data["items"][i];
      //  mapData=value;
          for (var key in value.keys) {
            if(cNames.length!=6){

            cNames.add(key);
            }
           // cval.add(value[key]);
          
        }
       AddItems.addItems.add(
          [
           value["OrderNumber"],
           value["ItemName"],
           value["ItemCode"],
           value["Quantity"],
           value["Price"],
           value["TotalPrice"],
          ]
        );

        
      }
      setState(() {
        
      });
    }
  
  }

   List<Widget> columnList(List<String> cNames,List cVal){
     List<Widget> lWidget=[];

     for (var i=0;i<cNames.length;i++) {
       if (cNames[i]!="TotalPrice") {
       Widget wid =Row(
           children: <Widget>[
              Expanded(child: Text('${cNames[i]}')),
              Expanded(child: Text('${cVal[i]}')),
              ],
           );
       Widget swid= SizedBox(height: 3,);
       lWidget.add(wid);
       lWidget.add(swid);   
       }
      if (cNames[i]=="TotalPrice") {
          tPrice=cVal[i];
        
      }

      
     }
      //this.cNames.clear();
      return lWidget;

   }


@override
  void initState() {
    // TODO: implement initState
    fillList();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    //itemListNames();
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1
          )
        ),
        child: Column(
          children: <Widget>[
            
            Expanded(
                        child: ListView.builder(
                itemCount: AddItems.addItems.length,
                itemBuilder:(ctx,index){
                 
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('${index+1}'),
                        ),
                        title: Column(
                          children:columnList(cNames,AddItems.addItems[index])
                        ),
                        trailing: Column(
                          children: <Widget>[
                            Text('Total Price:'),
                            Text('$tPrice'),
                            Expanded(
                                child: IconButton(
                                icon: Icon(Icons.delete), 
                              onPressed: ()async{
                                showDialog(context: context,
                                builder: (ctx){
                                  return AlertDialog(
                                    title: Text('Message'),
                                    content: Text('Dou you want to delete'),
                                    actions: <Widget>[
                                      FlatButton(onPressed: ()=>Navigator.pop(context), child: Text('Cancel')),
                                      FlatButton(
                                        child: Text('Ok'),
                                        onPressed: ()async{
                                          //itemDelete(addItems[index][0]),
                                          AddItemsQuery addItemsQuery=AddItemsQuery();
                                              GraphQLClient _client=graphQlConfiguration.clientQuery();
                                              QueryResult result=await _client.mutate(
                                                MutationOptions(
                                                  document: addItemsQuery.deleteItems(AddItems.addItems[index][0]),
                                                )
                                              );
                                              if(!result.hasException){
                                                Navigator.pop(context);
                                              }
                                        }
                                      )
                                    ],
                                  );
                                }
                                ).whenComplete((){
                                 AddItems.addItems.clear();
                                  fillList();
                                });
                                setState(() {
                                  
                                });
                              },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 3,)
                    ],
                  );
                }
                ),
            ),
           
          ],
        ),
      ),
      floatingActionButton: CircleAvatar(
        child: IconButton(icon: Icon(Icons.add),
         onPressed: (){
           setState(() {
              showDialog(context: context,
           builder: (ctx){
            return AddItemsAlertDialog();
           }
           ).whenComplete((){
              //cNames.clear();
             AddItems.addItems.clear();
              fillList();
           });
           });
          
         }
         ),
      ),
    );
  }
}
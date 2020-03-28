import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql_config.dart';
import '../model/item_model.dart';
import '../queries/add_items_queries.dart';
import '../user_interface/alert_add_items.dart';

class AddItems extends StatefulWidget {
  @override
  _AddItemsState createState() => _AddItemsState();
}





class _AddItemsState extends State<AddItems> {
  GraphQlConfiguration graphQlConfiguration=GraphQlConfiguration();
  List<String> cNames=[];
  //List<AddItemModel> addItems=List<AddItemModel>();
  List<List> addItems=[];
  //var cval=[];
  //int listLength;
  fillList()async{
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
          for (var key in value.keys) {
            if(cNames.length!=5){

            cNames.add(key);
            }
           // cval.add(value[key]);
          
        }
        addItems.add(
          [
           value["OrderNumber"],
           value["ItemName"],
           value["ItemCode"],
           value["Quantity"],
           value["Price"]
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
      body: ListView.builder(
        itemCount: addItems.length,
        itemBuilder:(ctx,index){
         
          return Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  child: Text('${index+1}'),
                ),
                title: Column(
                  children:columnList(cNames,addItems[index])
                ),
                trailing: Column(
                  children: <Widget>[
                    Text('Total Price:'),
                    Text('price')
                  ],
                ),
              ),
              Divider(thickness: 3,)
            ],
          );
        }
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
              addItems.clear();
              fillList();
           });
           });
          
         }
         ),
      ),
    );
  }
}
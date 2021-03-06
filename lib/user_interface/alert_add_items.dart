import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:wingsgraphqltransaction/queries/add_items_queries.dart';
import '../graphql_config.dart';

class AddItemsAlertDialog extends StatefulWidget {

  @override
  _AddItemsAlertDialogState createState() => _AddItemsAlertDialogState();
}

class _AddItemsAlertDialogState extends State<AddItemsAlertDialog> {
  GraphQlConfiguration graphQlConfiguration=GraphQlConfiguration();
  TextEditingController txtItemName=TextEditingController();
  TextEditingController txtItemCode=TextEditingController();
  TextEditingController txtQuantity=TextEditingController();
  TextEditingController txtprice=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
              title: Text('Add Items'),
                content: Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: SingleChildScrollView(
                     child: Column(
                     children: <Widget>[
                       Container(
                         margin: EdgeInsets.all(
                           MediaQuery.of(context).size.width*0.02
                      
                         ),
                         child: TextField(
                           controller: txtItemName,
                           maxLength: 30,
                           decoration: InputDecoration(
                             labelText: 'Item Name'
                           ),
                         ),
                       ),
                        Container(
                         margin: EdgeInsets.all(
                           MediaQuery.of(context).size.width*0.02
                          
                         ),
                         child: TextField(
                           controller: txtItemCode,
                           maxLength: 30,
                           decoration: InputDecoration(
                             labelText: 'Item Code'
                           ),
                         ),
                       ),
                        Container(
                         margin: EdgeInsets.all(
                           MediaQuery.of(context).size.width*0.02
                          
                         ),
                         child: TextField(
                           controller: txtQuantity,
                           maxLength: 30,
                           keyboardType:TextInputType.number,
                           decoration: InputDecoration(
                             labelText: 'Quantity'
                           ),
                         ),
                       ),
                        Container(
                         margin: EdgeInsets.all(
                           MediaQuery.of(context).size.width*0.02
                          
                         ),
                         child: TextField(
                           controller: txtprice,
                           maxLength: 30,
                           keyboardType: TextInputType.number,
                           decoration: InputDecoration(
                             labelText: 'Price'
                           ),
                         ),
                       ),
                     ],
                     
                     
                    ),
                  ),
                ),
              actions: <Widget>[
                FlatButton(child: Text('cancle'),
                onPressed: (){
                  Navigator.pop(context);
                },
                ),
                 FlatButton(child: Text('ok'),
                onPressed: ()async{
                  var quantity=int.parse(txtQuantity.text);
                  var price=double.parse(txtprice.text);
                  var totalPrice=quantity*price;
                  ProgressDialog progressDialog=ProgressDialog(context);
                  progressDialog.update(message: 'adding item..');
                  progressDialog.show();
                  AddItemsQuery addItemsQuery=AddItemsQuery();
                  GraphQLClient _client=graphQlConfiguration.clientQuery();
                  QueryResult result= await _client.mutate(
                    MutationOptions(
                      document: addItemsQuery.addItemsInsertion(txtItemName.text, txtItemCode.text,
                                                                int.parse(txtQuantity.text), double.parse(txtprice.text),totalPrice
                                                                )
                    ),
                    
                  );
                  if(result.loading){
                    return Text('loading');
                  }
                  if(!result.hasException){
                    txtItemCode.clear();
                    txtItemName.clear();
                    txtQuantity.clear();
                    txtprice.clear();
                    progressDialog.hide();
                    Navigator.pop(context);
                  }
                  
                  else{
                    Toast.show('Invalid', context,duration: Toast.LENGTH_LONG);
                    showDialog(context: context,
                    builder:(ctx)=>AlertDialog(
                      title: Text('Error'),
                      content: Text('Invalid Data'),
                      actions: <Widget>[
                        FlatButton(onPressed: ()=>Navigator.pop(context), child:Text('ok'))
                      ],
                    )
                    );
                    progressDialog.hide();
                  }
                },
                ),
              ],
             );
  }
}
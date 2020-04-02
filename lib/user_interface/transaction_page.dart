import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import '../queries/add_items_queries.dart';
import '../queries/geninfo_data_query.dart';
import '../graphql_config.dart';
import '../user_interface/additems.dart';
import '../user_interface/generalinfo.dart';


class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  var trnsNumber;
  GraphQlConfiguration graphQlConfiguration=GraphQlConfiguration();
var _tabs=<Tab>[
  Tab(
    text: 'GenreralInformation',
    //child: Text('General Information'),
  ),
  Tab(
    text: 'AddItems',
    //child: Text('Add Items'),
  ),
];

// List<Widget> tabView(int tabCount){
//   List<Widget> listTab=List<Widget>();

//   for(var tab in _tabs){
//   Widget wid =Container(
//       child: tab.text(),

//    );
//   }

// }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabs.length,
          child: Scaffold(
            
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Transaction Page'),
          bottom: TabBar(
           // isScrollable: true,
            tabs:_tabs ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.save),
             onPressed: ()async{
               ProgressDialog progressDialog=ProgressDialog(context);
                progressDialog.update(message: 'Saving...');
                if(GeneralInformation.txtvoucherController.text.isNotEmpty &&GeneralInformation.txtLocationController.text.isNotEmpty
                   &&GeneralInformation.txtBranchController.text.isNotEmpty &&GeneralInformation.txtDateController.text.isNotEmpty&&
                   AddItems.addItems.isNotEmpty){
                   progressDialog.show();
                     GeneralInfoData generalInfoData=GeneralInfoData();
                     GraphQLClient _client=graphQlConfiguration.clientQuery();
                   

                     QueryResult result=await _client.mutate(
                    MutationOptions(
                    document: generalInfoData.addData(GeneralInformation.txtvoucherController.text,GeneralInformation.txtDateController.text,
                                                      GeneralInformation.txtBranchController.text,GeneralInformation.txtLocationController.text),
                  )
                );
         if (!result.hasException) {
              GeneralInfoData genInfoData=GeneralInfoData();
               GraphQLClient clientGetData=graphQlConfiguration.clientQuery();
                 QueryResult resultTransaction=await clientGetData.query(
                      QueryOptions(
                        document: genInfoData.getData()
                      )
                    );
                      if (!resultTransaction.hasException) {
                       var lsLength= resultTransaction.data["generalinformation"].length; 
                       trnsNumber=resultTransaction.data["generalinformation"][lsLength-1]["transactionnumber"];
                      }

                  QueryResult itemResult;
                 for (var i = 0; i < AddItems.addItems.length; i++) {
                AddItemsQuery addItemsQuery=AddItemsQuery();
                GraphQLClient _client2=graphQlConfiguration.clientQuery();
                 itemResult =await _client2.mutate(
                  MutationOptions(
                    document: addItemsQuery.finalSaving(trnsNumber,GeneralInformation.txtBranchController.text,AddItems.addItems[i][0],
                    AddItems.addItems[i][1],AddItems.addItems[i][2],AddItems.addItems[i][3],AddItems.addItems[i][4],AddItems.addItems[i][5])
                  )
                );

             }
                
                if(!itemResult.hasException){
                  AddItemsQuery addItemsQuery=AddItemsQuery();
                  GraphQLClient _client1=graphQlConfiguration.clientQuery();
                  QueryResult result1;
                  for (var i = 0; i < AddItems.addItems.length; i++) {
                    result1 =await _client1.mutate(
                    MutationOptions(
                      document: addItemsQuery.deleteItems(AddItems.addItems[i][0])
                    )
                  );
                  } 
                 
                  if(!result1.hasException){
                  progressDialog.hide();
                  GeneralInformation.txtLocationController.clear();
                  GeneralInformation.txtDateController.clear();
                  GeneralInformation.txtBranchController.clear();
                  GeneralInformation.txtvoucherController.clear();
                  AddItems.addItems.clear();
                   setState(() {
                    showDialog(context: context,
                    builder: (ctx)=>AlertDialog(
                      title: Text('Message'),
                      content: Text('Transaction Saved Successfully'),
                      actions: <Widget>[
                        FlatButton(onPressed:()=>Navigator.pop(context), child: Text('ok'))
                      ],
                    )
                    );
                  });    

                  }
                }

                }
              
                if(result.hasException){ 
                  progressDialog.hide();
                  Toast.show('invalid data', context,duration:Toast.LENGTH_LONG);

                }
            }
            else{
             // Future.delayed(Duration(seconds: 3)).then((onValue)=>progressDialog.hide());
              Toast.show('Please Enter All Fileds', context,duration: Toast.LENGTH_LONG);
             // progressDialog.hide();
            }


             }
             ),
          ],
        ),
        body: TabBarView(
          
          children: <Widget>[
            Container(
              child: GeneralInformation(),
            ),
            Container(
              child: AddItems(),
            )
          ],
        ),
        
      ),
    );
  }
}
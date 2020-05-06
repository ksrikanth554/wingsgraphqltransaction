

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:wingsgraphqltransaction/CommonComponets/components.dart';
import 'package:wingsgraphqltransaction/UIControls/multirowpage.dart';
import 'package:wingsgraphqltransaction/UIControls/singlerowpage.dart';
import 'package:wingsgraphqltransaction/UIControls/transaction_controls.dart';
import 'package:wingsgraphqltransaction/data/multirowData.dart';
import 'package:wingsgraphqltransaction/data/singlerowcontrollerdata.dart';
import '../queries/add_items_queries.dart';
import '../queries/geninfo_data_query.dart';
import '../graphql_config.dart';
import '../user_interface/additems.dart';
import '../user_interface/generalinfo.dart';


class TransactionPage extends StatefulWidget {
  Map transaction;
  static int i=1;
  TransactionPage(this.transaction);
  @override
  _TransactionPageState createState() => _TransactionPageState(transaction);
}

class _TransactionPageState extends State<TransactionPage> {
  
  
  Map transactionMap;
  _TransactionPageState(this.transactionMap);
  int tabLength;
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
  List<Tab> getTabs(Map mamData){
    List<Tab> _tabs=[];
    for (var value in transactionMap['Tables']) {
          var tabname=value['TableName'];
         // print(tabname);
        _tabs.add(Tab(text:tabname,));
      }
    tabLength=_tabs.length;
   
    return _tabs;
  }

  // Future transactionScreenLoad() async{
  //   transactionMap=await loadTransaction();
  //  // print('${transactionMap['Tables'][0]['TableName']}');
  //   setState(() {
      
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //transactionScreenLoad();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: getTabs(transactionMap).length,
          child: Scaffold(
            
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Transaction Page'),
          bottom: TabBar(
            isScrollable: true,
            tabs:getTabs(transactionMap) ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.save),
              onPressed: ()async{
        //        ProgressDialog progressDialog=ProgressDialog(context);
        //         progressDialog.update(message: 'Saving...');
        //         if(GeneralInformation.txtvoucherController.text.isNotEmpty &&GeneralInformation.txtLocationController.text.isNotEmpty
        //            &&GeneralInformation.txtBranchController.text.isNotEmpty &&GeneralInformation.txtDateController.text.isNotEmpty&&
        //            AddItems.addItems.isNotEmpty){
        //            progressDialog.show();
        //              GeneralInfoData generalInfoData=GeneralInfoData();
        //              GraphQLClient _client=graphQlConfiguration.clientQuery();
                   

        //              QueryResult result=await _client.mutate(
        //             MutationOptions(
        //             document: generalInfoData.addData(GeneralInformation.txtvoucherController.text,GeneralInformation.txtDateController.text,
        //                                               GeneralInformation.txtBranchController.text,GeneralInformation.txtLocationController.text),
        //           )
        //         );
        //  if (!result.hasException) {
        //       GeneralInfoData genInfoData=GeneralInfoData();
        //        GraphQLClient clientGetData=graphQlConfiguration.clientQuery();
        //          QueryResult resultTransaction=await clientGetData.query(
        //               QueryOptions(
        //                 document: genInfoData.getData()
        //               )
        //             );
        //               if (!resultTransaction.hasException) {
        //                var lsLength= resultTransaction.data["generalinformation"].length; 
        //                trnsNumber=resultTransaction.data["generalinformation"][lsLength-1]["transactionnumber"];
        //               }

        //           QueryResult itemResult;
        //          for (var i = 0; i < AddItems.addItems.length; i++) {
        //         AddItemsQuery addItemsQuery=AddItemsQuery();
        //         GraphQLClient _client2=graphQlConfiguration.clientQuery();
        //          itemResult =await _client2.mutate(
        //           MutationOptions(
        //             document: addItemsQuery.finalSaving(trnsNumber,GeneralInformation.txtBranchController.text,AddItems.addItems[i][0],
        //             AddItems.addItems[i][1],AddItems.addItems[i][2],AddItems.addItems[i][3],AddItems.addItems[i][4],AddItems.addItems[i][5])
        //           )
        //         );

        //      }
                
        //         if(!itemResult.hasException){
        //           AddItemsQuery addItemsQuery=AddItemsQuery();
        //           GraphQLClient _client1=graphQlConfiguration.clientQuery();
        //           QueryResult result1;
        //           for (var i = 0; i < AddItems.addItems.length; i++) {
        //             result1 =await _client1.mutate(
        //             MutationOptions(
        //               document: addItemsQuery.deleteItems(AddItems.addItems[i][0])
        //             )
        //           );
        //           } 
                 
        //           if(!result1.hasException){
        //           progressDialog.hide();
        //           GeneralInformation.txtLocationController.clear();
        //           GeneralInformation.txtDateController.clear();
        //           GeneralInformation.txtBranchController.clear();
        //           GeneralInformation.txtvoucherController.clear();
        //           AddItems.addItems.clear();
        //            setState(() {
        //             showDialog(context: context,
        //             builder: (ctx)=>AlertDialog(
        //               title: Text('Message'),
        //               content: Text('Transaction Saved Successfully'),
        //               actions: <Widget>[
        //                 FlatButton(onPressed:()=>Navigator.pop(context), child: Text('ok'))
        //               ],
        //             )
        //             );
        //           });    

        //           }
        //         }

        //         }
              
        //         if(result.hasException){ 
        //           progressDialog.hide();
        //           Toast.show('invalid data', context,duration:Toast.LENGTH_LONG);

        //         }
        //     }
        //     else{
        //      // Future.delayed(Duration(seconds: 3)).then((onValue)=>progressDialog.hide());
        //       Toast.show('Please Enter All Fileds', context,duration: Toast.LENGTH_LONG);
        //      // progressDialog.hide();
        //     }
                //  if(SingleRowPage.formKey.currentState.validate()){

                //  }
                //  else{
                //    SingleRowPage.autoValidate=true;
                //  }
                
                ProgressDialog progressDialog=ProgressDialog(context);
                progressDialog.show().then((ret){
                singleRowSaved[TransactionPage.i]=singleRowControllerData;
                multiRowSaved[TransactionPage.i]=MultiRowPage.itemList;
                progressDialog.update(message: 'Saving...');
                Future.delayed(Duration(seconds: 3)).then((res){
                    progressDialog.hide();
                    
                    setState(() {
                    
                    Toast.show('Saved successFully', context,duration: Toast.LENGTH_LONG);
                    print(singleRowSaved[1]);
                    singleRowControllerData.clear();
                    for (var tableName in SingleRowPage.textEditControllersMap.keys) {
                      Map<String,TextEditingController> tableControllers=SingleRowPage.textEditControllersMap[tableName];
                      for (var key in tableControllers.keys) {
                        tableControllers[key].clear();
                      }
                    }
                    MultiRowPage.itemList.clear();
                    });

                });
                
                
                });
                
                
              }
             ),
          ],
        ),
        body: TabBarView(
          children:getTabBody(context),
          
        ),
        
      ),
    );
  }
  List<Widget> getTabBody(BuildContext context){
    List<Widget> _tabBody=[];
    
    Map<String,List<Map>> singlerowPages={};
    Map<String,List<String>> multirowPages={};
    for (var item in getTabs(transactionMap)) {

          Map<String,bool> isSingleRowMap={};
        
          for (var table in transactionMap['Tables']) {
                var tableName=table['TableName'];
                
               bool singleRow=table['SingleRowOnly'];
               isSingleRowMap[tableName]=singleRow;
                if (singleRow==true) {
                    List<Map> cNames=[];
                    for (var col in table['Columns']) {
                     
                      cNames.add(col);
                    }
                    singlerowPages[tableName]=cNames;             
                }
                else{
                  List<String> cNames=[];

                  for (var col in table['Columns']) {
                    bool isRequired=col['IsRequired'];
                    var caption=col['Caption'];
                    if (isRequired==true) {           
                      cNames.add(caption);
                    }
                  }
                  multirowPages[tableName]=cNames;
                }
          }
          if (isSingleRowMap[item.text]==true) {
            _tabBody.add(
              SingleRowPage( singlerowPages[item.text],item.text)
            
          ); 
         }
         else{
           _tabBody.add(MultiRowPage(multirowPages[item.text],item.text));
         }
             
          
        
    }
    return _tabBody;
  }
}
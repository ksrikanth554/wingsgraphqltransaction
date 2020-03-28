import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import '../queries/geninfo_data_query.dart';
import '../graphql_config.dart';
import '../user_interface/additems.dart';
import '../user_interface/generalinfo.dart';


class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
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
                   &&GeneralInformation.txtBranchController.text.isNotEmpty &&GeneralInformation.txtDateController.text.isNotEmpty){
                   progressDialog.show();
                     GeneralInfoData generalInfoData=GeneralInfoData();
                     GraphQLClient _client=graphQlConfiguration.clientQuery();
                     QueryResult result=await _client.mutate(
                    MutationOptions(
                    document: generalInfoData.addData(GeneralInformation.txtvoucherController.text,GeneralInformation.txtDateController.text,
                                                      GeneralInformation.txtBranchController.text,GeneralInformation.txtLocationController.text),
                  )
                );

                   
                
                if(!result.hasException){
                  progressDialog.hide();
                  GeneralInformation.txtLocationController.clear();
                  GeneralInformation.txtDateController.clear();
                  GeneralInformation.txtBranchController.clear();
                  GeneralInformation.txtvoucherController.clear();
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
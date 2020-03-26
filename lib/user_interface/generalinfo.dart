import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:wingsgraphqltransaction/graphql_config.dart';
import 'package:wingsgraphqltransaction/queries/geninfo_data_query.dart';
import 'package:wingsgraphqltransaction/queries/geninfo_ui_query.dart';

class GeneralInformation extends StatefulWidget {
  @override
  _GeneralInformationState createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation> {

  TextEditingController txtvoucherController=TextEditingController();
  TextEditingController txtDateController=TextEditingController();
  TextEditingController txtBranchController=TextEditingController();
  TextEditingController txtLocationController=TextEditingController();

  GraphQlConfiguration graphQlConfiguration=GraphQlConfiguration();
  List<String> listUI=List<String>();
  @override
  void initState() {
    // TODO: implement initState
    fillList();
    super.initState();
     
  }
  void fillList() async{
    GenInfoUIQuery uiQueryMutation=GenInfoUIQuery();
    GraphQLClient _client=graphQlConfiguration.clientQuery();
    QueryResult result=await _client.query(
      QueryOptions(document: uiQueryMutation.getUI())
    );
    if(!result.hasException){
      for(var value in result.data["geninfoui"]){
        for(var key in value.keys){
          listUI.add(value[key]);
        }
      }
    } 
    setState(() {
      
    });

  }

  Widget listBuilder(String lstring,int index){
    
    Widget wid=Container(
                  child: TextField(
                    controller: textEditController(lstring),
                    decoration: InputDecoration(
                      labelText:lstring,
                    ), 
                   
                  ),
                );
    return wid;
  }
  TextEditingController textEditController(String str){
      if(str=='VoucherType'){
        return txtvoucherController;
      }
      if(str=='Date'){
        return txtDateController;
        
      }
      if(str=='Branch'){
        return txtBranchController;
      }
      if(str=='Location'){
        return txtLocationController;
      }

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: <Widget>[
          Expanded(

               child: ListView.builder(
              itemCount: listUI.length,
              itemBuilder: (ctx,index){
                String lstring=listUI[index];
                return listBuilder(lstring,index);
              },

            ),
          ),
          FlatButton(
             child: Text('Save'),
             onPressed: ()async{
                ProgressDialog progressDialog=ProgressDialog(context);
                progressDialog.update(message: 'Saving...');
                if(txtvoucherController.text.isNotEmpty && txtLocationController.text.isNotEmpty
                   && txtBranchController.text.isNotEmpty && txtDateController.text.isNotEmpty){
                   progressDialog.show();
                     GeneralInfoData generalInfoData=GeneralInfoData();
                     GraphQLClient _client=graphQlConfiguration.clientQuery();
                     QueryResult result=await _client.mutate(
                    MutationOptions(
                    document: generalInfoData.addData(txtvoucherController.text, txtDateController.text,
                                                       txtBranchController.text, txtLocationController.text),
                  )
                );

                   
                
                if(!result.hasException){
                  progressDialog.hide();
                  txtLocationController.clear();
                  txtDateController.clear();
                  txtBranchController.clear();
                  txtvoucherController.clear();
                  setState(() {
                    
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


             },
             )
        ],
      ),
      
    );
  }
}
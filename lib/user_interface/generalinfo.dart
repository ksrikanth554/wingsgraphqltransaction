import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import '../graphql_config.dart';
import '../queries/geninfo_data_query.dart';
import '../queries/geninfo_ui_query.dart';
import '../user_interface/combo_box.dart';

class GeneralInformation extends StatefulWidget {
 static TextEditingController txtvoucherController=TextEditingController();
 static TextEditingController txtDateController=TextEditingController();
 static TextEditingController txtBranchController=TextEditingController();
 static TextEditingController txtLocationController=TextEditingController();
  @override
  _GeneralInformationState createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation> {



  GraphQlConfiguration graphQlConfiguration=GraphQlConfiguration();
  List<String> listUI=List<String>();
  @override
  void initState() {
    // TODO: implement initState
    fillList();
    super.initState();
    GeneralInformation.txtDateController.text= DateFormat('dd-MM-yyyy').format(DateTime.now());
     
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
  onTapValue(String lstring,Object res){
    if(lstring=='Branch'){
      GeneralInformation.txtBranchController.text=res!=null?res.toString():'';
    }
    if(lstring=='VoucherType'){
     GeneralInformation.txtvoucherController.text=res!=null?res.toString():'';
    }
    if(lstring=='Location'){
      GeneralInformation.txtLocationController.text=res!=null?res.toString():'';
    }
    
    
  }

  Widget listBuilder(String lstring,int index){
    
    Widget wid= Container(
                  child: TextField(
                    readOnly: true,
                    controller: textEditController(lstring),
                    decoration: InputDecoration(
                      labelText:lstring,
                    ), 
                    onTap: ()async{
                      if(lstring=='Date'){
                        showDatePicker(
                          context: context, 
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020), 
                          lastDate: DateTime(2025)).then((retVal){
                           GeneralInformation.txtDateController.text=DateFormat('dd-MM-yyyy').format(retVal);
                          });
                      }
                      else{

                     final res =await Navigator.of(context).pushNamed(ComboBox.routeName,arguments: lstring);
                     onTapValue(lstring,res);
                      }
                    },
                   
                  ),
                  
                );
               
              
    return wid;
  }
  TextEditingController textEditController(String str){
      if(str=='VoucherType'){
        return GeneralInformation.txtvoucherController;
      }
      if(str=='Date'){
        return GeneralInformation.txtDateController;
        
      }
      if(str=='Branch'){
        return GeneralInformation.txtBranchController;
      }
      if(str=='Location'){
        return GeneralInformation.txtLocationController;
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
         
        ],
      ),
      
    );
  }
}
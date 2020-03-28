import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../queries/combo_box_queries.dart';
import '../graphql_config.dart';

class ComboBox extends StatefulWidget {
  static const routeName='./combobox';
  @override
  _ComboBoxState createState() => _ComboBoxState();
}

class _ComboBoxState extends State<ComboBox> {
  TextEditingController searchController=TextEditingController();
  bool fList=false;
  GraphQlConfiguration graphQlConfiguration=GraphQlConfiguration();
  var selectedIndex;
  var cName;
  List<String> comboList=[];
  List<String> filterList=[];
  onTapChangeColor(int index){
    setState(() {
      selectedIndex=index;
    });
  }
  fillList(BuildContext context) async{
    GraphQLClient _client=graphQlConfiguration.clientQuery();
    ComboBoxQueries comboBoxQueries=ComboBoxQueries();
    var sname =ModalRoute.of(context).settings.arguments as String;
    
    
    if(sname=='VoucherType'){
      cName=sname;
        QueryResult result=await _client.query(
          QueryOptions(
            document: comboBoxQueries.voucherType()
          )
        );
        if(!result.hasException){
          print('${result.data["vouchertype"][0]["vouchernames"][0]}');
          comboList.clear();
          for (var item in result.data["vouchertype"]) {
            for (var key in item.keys) {
              for (var i = 0; i < item[key].length; i++) {
                comboList.add(item[key][i]);
              }
            }
          
          }
         setState(() {
           filterList=comboList;
         });
     }

    }
    if(sname=='Date'){
      cName=sname;
      
    }
    if(sname=='Branch'){
      cName=sname;

       QueryResult result=await _client.query(
          QueryOptions(
            document: comboBoxQueries.branch()
          )
        );
        if(!result.hasException){
         // print('${result.data["vouchertype"][0]["vouchernames"][0]}');
          comboList.clear();
          for (var item in result.data["branch"]) {
            for (var key in item.keys) {
              for (var i = 0; i < item[key].length; i++) {
                comboList.add(item[key][i]);
              }
            }
          
          }
         setState(() {
           filterList=comboList;
         });
     }

    }
    if(sname=='Location'){
      cName=sname;
       QueryResult result=await _client.query(
          QueryOptions(
            document: comboBoxQueries.location()
          )
        );
        if(!result.hasException){
         // print('${result.data["vouchertype"][0]["vouchernames"][0]}');
          comboList.clear();
          for (var item in result.data["location"]) {
            for (var key in item.keys) {
              for (var i = 0; i < item[key].length; i++) {
                comboList.add(item[key][i]);
              }
            }
          
          }
         setState(() {
           filterList=comboList;
         });
     }

    }
    // switch(sname){
    //   case "Location":cName=sname;
    //                   break;
    // }
   
  }
  
  @override
  Widget build(BuildContext context) {
    if(fList==false){

    fillList(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('$cName'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: ListTile(
              leading: Icon(Icons.search),
              title: TextField(
                controller:searchController ,
                onChanged: (val){
                
                  if(val.isNotEmpty){

                  var dummyList=filterList.where((list)=>list.toLowerCase().contains(val)).toList();
                  setState(() {
                 comboList=dummyList;
                    fList=true;
                  });
                  }
                  if(val.isEmpty){
                    setState(() {
                      fList=false;
                    });
                  }
                },
              ),
              trailing: IconButton(icon: Icon(Icons.cancel),
               onPressed:(){
                searchController.clear();
                setState(() {
                  fList=false;
                });
              })
            ),
          ),
          Expanded(
              child: ListView.builder(
              itemCount: comboList.length,
              itemBuilder: (ctx,index){
                var lValue=comboList[index];
                return GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*0.02,
                        right: MediaQuery.of(context).size.width*0.02,

                      ),
                      color: selectedIndex==index?Colors.orange:Colors.white,
                    child:ListTile(
                      title: Text('$lValue'),
                    )
                  ),
                  onTap: (){
                    onTapChangeColor(index);
                    Navigator.pop(context,lValue);
                  },
                );
              },
            ),
          )
        ],
      ),
      
    );
  }
}
import 'package:flutter/material.dart';
import '../user_interface/additems.dart';
import '../user_interface/generalinfo.dart';


class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
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
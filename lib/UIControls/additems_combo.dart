import 'package:flutter/material.dart';

class AddItemsCombo extends StatelessWidget {
  static const routeName='./addItemsCombo';
  @override
  Widget build(BuildContext context) {
    var cName=ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: ListView(
        children: <Widget>[
          InkWell(child: ListTile(title: Text('Data1')),onTap: (){
            Navigator.pop(context,'Data1');
          },),
          InkWell(child: ListTile(title: Text('Data2')),onTap: (){
            Navigator.pop(context,'Data2');
          },),
          InkWell(child: ListTile(title: Text('Data3')),onTap: (){
            Navigator.pop(context,'Data3');
          },),
          InkWell(child: ListTile(title: Text('Data4')),onTap: (){
            Navigator.pop(context,'Data4');
          },),
          InkWell(child: ListTile(title: Text('Data5')),onTap: (){
            Navigator.pop(context,'Data5');
          },),
          InkWell(child: ListTile(title: Text('Data6')),onTap: (){
            Navigator.pop(context,'Data6');
          },),
        ],
      ),
    );

  }
}
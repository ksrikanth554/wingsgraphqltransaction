import 'package:flutter/material.dart';

class SingleRowCombo extends StatelessWidget {
  static const routeName='./singlerowcombo';
  @override
  Widget build(BuildContext context) {
    var cName=ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: ListView.builder(
            itemCount: 10,
            itemBuilder: (ctx,index){
              return InkWell(child: ListTile(title: Text('Transaction Data $index')),onTap: (){
                     Navigator.pop(context,'Transaction Data $index');
                  },);
            }
          )
    );

  }
}
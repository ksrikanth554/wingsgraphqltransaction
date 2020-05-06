import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wingsgraphqltransaction/user_interface/transaction_page.dart';

import 'data/transDataJson.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}


class _SplashState extends State<Splash> {
  Map transactionMap;
  Future transactionLoad()async{
    await loadTransaction().then((res){
      transactionMap=res;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(ctx)=>TransactionPage(res)));
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transactionLoad();
    // Timer(
    // Duration(seconds: 2),
    // ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(ctx)=>TransactionPage()))
    // );
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
         color: Colors.orange,
        ),
        Center(
          child: Text('Transaction Page',style: TextStyle(fontSize: 40,color:Colors.white,decoration:TextDecoration.none),),
        )
      ],
    );
  }
}
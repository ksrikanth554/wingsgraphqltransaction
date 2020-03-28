import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:wingsgraphqltransaction/graphql_config.dart';
import 'package:wingsgraphqltransaction/user_interface/combo_box.dart';
import './user_interface/transaction_page.dart';


GraphQlConfiguration graphQlConfiguration=GraphQlConfiguration();
void main(){

  runApp(
    GraphQLProvider(
      client: graphQlConfiguration.client,
      child: CacheProvider(child: HomePage()),
    )
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TransactionPage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        
      ),
      home:TransactionPage(),
      routes: {
        ComboBox.routeName:(ctx)=>ComboBox(),
      },
      
      
    );
  }
}
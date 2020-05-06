import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

Future<String> _loadTransactionAssets()async{
  return await rootBundle.loadString('assets/data/Transaction.json');
}
// void _parseStringToMap(String jsnonString){
//   Map decoded=jsonDecode(jsnonString);
//   print('${decoded['Tables']}');
// }
Future<Map> loadTransaction()async{
  String transJson=await _loadTransactionAssets();
  Map decoded=jsonDecode(transJson);
 // print(decoded['Tables'][0]['Columns']);
  return decoded;
}
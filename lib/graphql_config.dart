import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlConfiguration{
  static final HttpLink httpLink=HttpLink(uri: "https://mygraphql-hasura.herokuapp.com/v1/graphql",);
  ValueNotifier<GraphQLClient> client=ValueNotifier(
    GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
  )
  );
  GraphQLClient clientQuery(){
    return GraphQLClient(link: httpLink, cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject));
  }

}
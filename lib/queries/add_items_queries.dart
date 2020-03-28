
class AddItemsQuery{
  String addItems(){
  return"""
    query{
      items{
        OrderNumber
        ItemName
        ItemCode
        Quantity
        Price
      }
    }
  """;
}

String addItemsInsertion(String itemNanme,String itemCode,int quantity,double price){
  return"""
  mutation{
  insert_items(objects:[{ItemName:"$itemNanme",ItemCode:"$itemCode",Quantity:$quantity,Price:$price}]){
    returning{
      OrderNumber
      ItemName
      ItemCode
      Quantity
      Price
    }
  }
}
  """;
}

}




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
        TotalPrice
      }
    }
  """;
}

String addItemsInsertion(String itemNanme,String itemCode,int quantity,double price,var totalPrice){
  return"""
  mutation{
  insert_items(objects:[{ItemName:"$itemNanme",ItemCode:"$itemCode",Quantity:$quantity,Price:$price,TotalPrice:$totalPrice}]){
    returning{
      OrderNumber
      ItemName
      ItemCode
      Quantity
      Price
      TotalPrice
    }
  }
}
  """;
}

String deleteItems(int orderNumber){

  return"""
    mutation{
  delete_items(where:{OrderNumber:{_eq:$orderNumber}}){
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

String finalSaving(var trNumber,String branch,int orderNumber,String itemName,String itemCode,int quantity,var price,var totalPrice){
  return"""
  mutation{
  insert_saveitemtable(objects:[{transactionnumber:$trNumber,branch:"$branch",OrderNumber:$orderNumber,
                                ItemName:"$itemName",ItemCode:"$itemCode",Quantity:$quantity,Price:$price,TotalPrice:$totalPrice}]){
    returning{
      transactionnumber
      branch
      OrderNumber
      ItemName
      ItemCode
      Quantity
      Price
      TotalPrice
      
    }
  }
}
  """;
}

}



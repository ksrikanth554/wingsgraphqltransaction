class AddItemModel{
  final int orderName;
  final String itemName;
  final String itemCode;
  final int quantity;
  final double price;
  AddItemModel({this.itemCode,this.itemName,this.orderName,this.price,this.quantity});
  getOrderName()=>this.orderName;
  getItemName()=>this.itemName;
  getItemCode()=>this.itemCode;
  getQuantity()=>this.quantity;
  getprice()=>this.price;
}
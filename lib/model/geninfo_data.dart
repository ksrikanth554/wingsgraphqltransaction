class GeneralInfo{
  final String voucherType;
  final String date;
  final String branch;
  final String location;
  GeneralInfo({this.branch,this.date,this.location,this.voucherType});
  getBranch()=>this.branch;
  getDate()=>this.date;
  getLocation()=>this.location;
  getVoucherType()=>this.voucherType;
}
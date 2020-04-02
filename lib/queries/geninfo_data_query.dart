class GeneralInfoData{
  String addData(String voucher,String date,String branch,String location){
    return """
      mutation{
          insert_generalinformation(objects:[{vouchertype:"$voucher",date:"$date",branch:"$branch",location:"$location"}]){
          returning{
            vouchertype
            date
            branch
            location
          } 
       }
    }
    """;

  }
  String getData(){
    return"""
  query{
      generalinformation{
        transactionnumber
        vouchertype
        date
        branch
        location
      }
    }
    """;
  }
}
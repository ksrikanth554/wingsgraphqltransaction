class ComboBoxQueries{
  String voucherType(){
    return"""
    query{
      vouchertype{
        vouchernames
      }
      }
    
    """;
  }
  String branch(){
    return"""
    query{
      branch{
        branchnames
      }
      }
    
    """;
  }
  String location(){
    return"""
    query{
      location{
        locationnames
      }
      }
    
    """;
  }
}

//list mutation
// mutation{
//   insert_vouchertype(objects:{vouchernames:"{VoucherType1,VoucherType2}"}){
//     returning{
//       vouchernames
//     }   
//   }
// }
class GenInfoUIQuery{

  String getUI(){
    return"""
    query{
      geninfoui{
        vouchertype
        date
        branch
        location
      }
    }

    """;
  }

}
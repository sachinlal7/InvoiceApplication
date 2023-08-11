  // Future<void> deletById() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var getCust = prefs.getInt(CUST_ID);
  //   print(" id of user $getCust");

  //   final url = "http://192.168.1.31:8000/api/customer-delete/$getCust";

  //   final uri = Uri.parse(url);

  //   final response = await http.delete(uri);
  //   if (response.statusCode == 200) {
  //     // final filtered =
  //     //     data.where((element) => element['user_id'] != getUser).toList();

  //     setState(() {
  //       // data = filtered;
  //       // print("filtered data $data");
  //     });
  //   } else {}
  // }







  //   void custDetails() async {
  //   final url = "http://192.168.1.31:8000/api/customer-list/";
  //   final uri = Uri.parse(url);
  //   var response = await http.post(uri);

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     var json = jsonDecode(response.body) as Map;
  //     var results = json['data']['id'] as List;
  //     print(results);
  //     setState(() {
  //       data = results;
  //       print("results $results");
  //     });
  //   } else {
  //     print("error");
  //   }
  // }













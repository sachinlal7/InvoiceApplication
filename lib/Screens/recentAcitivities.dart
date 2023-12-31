import 'dart:convert';

import 'package:flutter/material.dart';

import '../constants_colors.dart';
import 'package:http/http.dart' as http;

class RecentActivities extends StatefulWidget {
  const RecentActivities({super.key});

  @override
  State<RecentActivities> createState() => _RecentActivitiesState();
}

class _RecentActivitiesState extends State<RecentActivities> {
  List data = [];

  bool isLoading = true;

  Future<void> getRecentActivities() async {
    final url = "http://192.168.1.35:8000/api/recent-activities/";

    final uri = Uri.parse(url);
    print("FIFTEEN");

    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // var getTheKey = prefs.getString(ACCESS_KEY);
    print(authorizationValues);
    final response = await http
        .get(uri, headers: {'Authorization': 'Bearer $authorizationValues'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = jsonDecode(response.body) as Map;
      var results = json['data'] as List;
      print(results);
      // var invoiceNUM = json['data']['invoice_number'];

      // print("customer id result $custres");
      // var setTheCustId = prefs.setInt(CUST_ID, custResults);
      setState(() {
        data = results;
      });
    } else {
      print("error");
    }
    setState(() {
      isLoading = false;
      // void getdata(int index) {
      //   var custNum = custResults[index][index];
      //   print("numbr of cust $custNum");
      // }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecentActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recent Activities"),
        centerTitle: true,
        backgroundColor: Color_orange,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.maxFinite,
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final dataItem = data[index] as Map;
                  InvoiceNumber = dataItem['invoice_number'].toString();
                  var totalPrice = dataItem['total_price'];
                  var prodcutName = dataItem['product_name'] ?? "";
                  var invoiceID = dataItem['id'].toString();
                  var clientName = dataItem['client_name'];
                  var invoiceDate = dataItem['invoice_date'];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                        height: 120,
                        color: Color_green,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(clientName),
                                  Text(InvoiceNumber)
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [Text("Product"), Text(prodcutName)],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total Amount"),
                                  Text(totalPrice)
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Invoice Date"),
                                  Text(invoiceDate)
                                ],
                              ),
                            )
                          ],
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

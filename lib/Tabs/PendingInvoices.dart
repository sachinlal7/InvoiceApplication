import 'dart:convert';

import 'package:flutter/material.dart';

import '../constants_colors.dart';
import 'package:http/http.dart' as http;

class PendingInvoices extends StatefulWidget {
  const PendingInvoices({super.key});

  @override
  State<PendingInvoices> createState() => _PendingInvoicesState();
}

class _PendingInvoicesState extends State<PendingInvoices> {
  List data = [];
  bool isLoading = true;

  Future<void> getPendingInvoices() async {
    final url = "http://192.168.1.31:8000/api/pending-invoice/";

    final uri = Uri.parse(url);
    print("FIFTEEN");

    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // var getTheKey = prefs.getString(ACCESS_KEY);
    print(authorizationValue);
    final response = await http
        .get(uri, headers: {'Authorization': 'Bearer $authorizationValue'});

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
    getPendingInvoices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Invoices"),
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
                  print(InvoiceNumber);
                  print(prodcutName);
                  print(totalPrice);
                  print(invoiceDate);

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

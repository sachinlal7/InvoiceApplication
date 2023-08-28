import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/invoice_add.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OutStandingInvoices extends StatefulWidget {
  const OutStandingInvoices({super.key});

  @override
  State<OutStandingInvoices> createState() => _OutStandingInvoicesState();
}

class _OutStandingInvoicesState extends State<OutStandingInvoices> {
  List data = [];
  bool isLoading = true;

  Future<void> fetchOutstanding() async {
    final url = "http://192.168.1.31:8000/api/unpaid-invoice-list/";

    final uri = Uri.parse(url);
    print("seven");

    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // var getTheKey = prefs.getString(ACCESS_KEY);
    print(authorizationValue);
    final response = await http
        .post(uri, headers: {'Authorization': 'Bearer $authorizationValue'});
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = jsonDecode(response.body) as Map;
      var results = json['data'] as List;
      print(results);

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
    setState(() {});
  }

  Future<void> deleteInvoice(String InvoiceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var InvId = prefs.get(getInvoiceID);
    print(" get user id $InvId");
    print("SEVENTEEN");

    final url = "http://192.168.1.31:8000/api/delete-invoice/$InvId";

    final uri = Uri.parse(url);

    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      final filtered =
          data.where((element) => element['id'] != CustKey).toList();

      setState(() {
        data = filtered;
        // print("filtered data $data");
      });
    } else {}
    fetchOutstanding();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOutstanding();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Visibility(
      visible: isLoading,
      child: Center(
        child: CircularProgressIndicator(),
      ),
      replacement: RefreshIndicator(
        onRefresh: fetchOutstanding,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: double.maxFinite,
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final dataItem = data[index] as Map;
                        var InvoiceNumber =
                            dataItem['invoice_number'].toString();
                        var totalPrice = dataItem['total_price'];
                        var paidAmount = dataItem['paid_amount'] ?? "";
                        var invoiceID = dataItem['id'].toString();
                        var clientName = dataItem['client_name'];
                        var paymentStatus = dataItem['payment_status'];
                        var dueAmount = dataItem['due_amount'];

                        print(InvoiceNumber);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            height: 100,
                            color: Color_green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      InvoiceNumber,
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                    Text(
                                      clientName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text("₹ $totalPrice")
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("₹ $dueAmount"),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        paymentStatus,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: paymentStatus.toLowerCase() ==
                                                  'paid'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: GestureDetector(
                                              onTap: () async {
                                                // SharedPreferences prefs =
                                                //     await SharedPreferences
                                                //         .getInstance();
                                                // var keyuser = prefs.setString(
                                                //     getUser, personId);
                                                // print(getUser);
                                                // print("twelve $keyuser");

                                                // fetchEditDetails();
                                                print("edit pressed");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            InvoiceAdd(
                                                              isEdit: true,
                                                              InvoiceId:
                                                                  invoiceID,

                                                              // name: dataItem[
                                                              //     'name'],
                                                            )));
                                              },
                                              child: Icon(Icons.share)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: GestureDetector(
                                              onTap: () async {
                                                // SharedPreferences prefs =
                                                //     await SharedPreferences
                                                //         .getInstance();
                                                // var keyuser = prefs.setString(
                                                //     getUser, personId);
                                                // print(getUser);
                                                // print("twelve $keyuser");

                                                // fetchEditDetails();
                                                print("edit pressed");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            InvoiceAdd(
                                                              isEdit: true,
                                                              InvoiceId:
                                                                  invoiceID,

                                                              // name: dataItem[
                                                              //     'name'],
                                                            )));
                                              },
                                              child: Icon(Icons.edit)),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              print(custIDnew);
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              var keyuser = prefs.setString(
                                                  getInvoiceID, invoiceID);
                                              print("eighteen");
                                              print(keyuser);
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return customDialog(
                                                        "Deleted Successfully",
                                                        "Are you sure want to delete ?");
                                                  });
                                            },
                                            icon: Icon(Icons.delete)),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            // child: ListTile(

                            //   title: Text("Client Name"),
                            //   subtitle: Text(InvoiceNumber),
                            //   trailing: Text("\$0.00"),

                            // ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget customDialog(String text, warning) {
    return Dialog(
      child: SizedBox(
        height: 150,
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                color: Color_orange,
                child: Center(
                    child: Text(
                  warning,
                  style: TextStyle(color: Color_white, fontSize: 18),
                )),
              ),
            ),
            Expanded(
              child: Container(
                height: 40,
                width: 260,
                child: Row(
                  children: [
                    SizedBox(
                      width: 110,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color_orange),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("NO")),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 110,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color_orange),
                          onPressed: () {
                            deleteInvoice(personId.toString())
                                .then((value) => Navigator.pop(context));
                            isLogin = false;
                            // clearUserData();
                            setState(() {
                              fetchOutstanding();
                            });

                            Fluttertoast.showToast(
                                msg: text,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                          child: Text("YES")),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/dashboardInvoice.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:http/http.dart' as http;

import '../model/custName_mdoels.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? idValue;

class PreviewInvoice extends StatefulWidget {
  String? selectedValue;
  final isEdit;

  PreviewInvoice({super.key, this.selectedValue, this.isEdit});

  @override
  State<PreviewInvoice> createState() => _PreviewInvoiceState();
}

class _PreviewInvoiceState extends State<PreviewInvoice> {
  bool isEdit = false;
  TextEditingController idController = TextEditingController();
  TextEditingController clientController = TextEditingController();
  TextEditingController ProductNameController = TextEditingController();
  TextEditingController QuantityController = TextEditingController();
  TextEditingController UnitPriceController = TextEditingController();
  TextEditingController TotalPriceController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  TextEditingController FaxNumberController = TextEditingController();
  TextEditingController PaymentDateContoller = TextEditingController();
  TextEditingController DueAmountController = TextEditingController();
  TextEditingController PaidAmountController = TextEditingController();
  TextEditingController PaymentStatusController = TextEditingController();

  void getDataApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    InvoiceIdValue = prefs.getString(getInvoiceID) ?? "";
    print(" get user id $InvoiceIdValue");

    final url = "http://192.168.1.31:8000/api/customer-list/";
    final uri = Uri.parse(url);

    try {
      final response = await http
          .get(uri, headers: {'Authorization': 'Bearer $authorizationValues'});

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(response.body);

        if (responseData['status'] == 'True') {
          final List<dynamic> customerList = responseData['data'];

          for (var customer in customerList) {
            idValue = customer['id'];
            final name = customer['name'];
            final email = customer['email'];

            print('ID: $idValue');
            print('Name: $name');
            print('Email: $email');
            print('-----------------------');

            if (changedValue == name) {
              setState(() {
                clientID = idValue.toString();
                print("client id $clientID");
                idController.text = clientID; // Update the controller's text
              });
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString(clientUserId, clientID);

              break; // Exit the loop after finding the match
            }
          }
        } else {
          print('API returned an error message: ${responseData['message']}');
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void submitInvoiceData() async {
    // final intQuantity = int.tryParse(QuantityController.text);
    // final quantity = intQuantity != null
    //     ? intQuantity
    //     : 0; // Set a default value if conversion fails

    // Create the body for the HTTP request
    final Map<String, dynamic> body = {
      "client": clientID,
      "phone_number": "9654192354",
      "quantity": quantity,
      "product_name": productName,
      "unit_price": unitPrice,
      "invoice_date": selectedDate,
      "address": billAddress,
      "due_date": selectedDate1,
      "fax_number": faxNumber,
      "payment_date": selectedDate2,
      "paid_amount": paidAmount
    };
    print(body);
    print(clientID);
    final url = "http://192.168.1.31:8000/api/invoice/";
    final uri = Uri.parse(url);
    print(uri);

    try {
      print(authorizationValues);
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $authorizationValues',
          'Content-Type': 'application/json',
        },
        body: json.encode(body),

        // Convert body to JSON
      );
      print(response.body);

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        print("Response: $responseData");
        Fluttertoast.showToast(
            msg: "Invoice Created",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        print('Request failed with status: ${response.statusCode}');
        Fluttertoast.showToast(
            msg: "Invoice Creation failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> updateInvoiceData(String customerIdValue) async {
    final body = {
      "client": invoiceID,
      "invoice_number": "12365407",
      "invoice_date": "2001-12-31",
      "due_date": "2001-1-3",
      "address": "ranchi",
      "quantity": "5",
      "unit_price": "8000",
      "product_name": "tablate"
    };

    final url = "http://192.168.1.31:8000/api/edit-invoice/$InvoiceIdValue";
    final uri = Uri.parse(url);
    print(authorizationValues);
    print(InvoiceIdValue);
    final response = await http.put(uri,
        body: body, headers: {'Authorization': 'Bearer $authorizationValues'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('successfully updated');
    } else {
      print('update failed');
    }
    // if (mounted) {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => AddClients()));
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCustId();
    getDataApi();
    print(widget.isEdit);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                width: double.maxFinite,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(widget.isEdit ? getInvoiceID : ""),
                    Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Image(
                          image: AssetImage("assets/images/order_history.png"),
                          height: 80,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Date"),
                                SizedBox(
                                  width: 80,
                                ),
                                Text("Due Date"),
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(selectedDate),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(selectedDate1),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.664,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Client",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Product Name",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Quantity",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Unit Price",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Total Price",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Address",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Fax_Number",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Payment Date",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          // Text("Due Amount",
                          //     style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Paid Amount",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          // Text("Payment Status",
                          //     style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.664,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          changedValue,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          productName,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          quantity,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          unitPrice,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          totalPrice,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          billAddress,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          faxNumber,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          selectedDate2,
                          style: TextStyle(fontSize: 15),
                        ),
                        // Text(
                        //   dueAmount,
                        //   style: TextStyle(fontSize: 15),
                        // ),
                        Text(
                          paidAmount,
                          style: TextStyle(fontSize: 15),
                        ),
                        // Text(
                        //   paymentStatus,
                        //   style: TextStyle(fontSize: 15),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                child: GestureDetector(
                  onTap: () {
                    widget.isEdit
                        ? updateInvoiceData(customerIdValue).then((value) =>
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => dashboardInvoices())))
                        : submitInvoiceData();
                  },
                  child: Container(
                    height: 35,
                    width: double.maxFinite,
                    color: Colors.deepOrange,
                    child: Center(
                        child: Text(
                      widget.isEdit ? "update" : "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

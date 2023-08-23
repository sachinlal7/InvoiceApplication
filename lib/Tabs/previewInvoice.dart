import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:http/http.dart' as http;

import '../model/custName_mdoels.dart';

class PreviewInvoice extends StatefulWidget {
  const PreviewInvoice({super.key});

  @override
  State<PreviewInvoice> createState() => _PreviewInvoiceState();
}

class _PreviewInvoiceState extends State<PreviewInvoice> {
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

  Future<CustNameModels> getPost() async {
    final url = "http://192.168.1.31:8000/api/customer-list/";

    final response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer $authorizationValue'});
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return CustNameModels.fromJson(data);
    } else {
      return CustNameModels.fromJson(data);
    }
  }

  void createInvoice() async {
    final body = {
      "client": "171",
      "phone_number": "521554412",
      "quantity": QuantityController.text,
      "product_name": ProductNameController.text,
      "unit_price": UnitPriceController.text,
      "invoice_date": "2023-07-25",
      "address": "noida",
      "due_date": "2023-07-29",
      "fax_number": "#12sawjbgwjd",
      "payment_date": "2023-05-24"
    };

    final url = "http://192.168.1.31:8000/api/invoice/";
    final uri = Uri.parse(url);
    print(authorizationValue);
    final response = await http
        .post(uri, headers: {'Authorization': 'Bearer $authorizationValue'});

    // final data = jsonDecode(response.body);
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return print('created successfully ');
    } else {
      print('creation failed');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCustId();
    getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CustNameModels>(
          future: getPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var id = snapshot.data!.data;

              print("id $id");

              return Text("datum");
            } else {
              return CircularProgressIndicator();
            }
            // return SingleChildScrollView(
            //   scrollDirection: Axis.vertical,
            //   child: Column(
            //     children: [
            //       Container(
            //         height: MediaQuery.of(context).size.height * 0.18,
            //         width: double.maxFinite,
            //         child: Column(
            //           children: [
            //             SizedBox(
            //               height: 20,
            //             ),
            //             Text("INV00001"),
            //             Row(
            //               children: [
            //                 SizedBox(
            //                   width: 25,
            //                 ),
            //                 Image(
            //                   image: AssetImage("assets/images/order_history.png"),
            //                   height: 80,
            //                 ),
            //                 SizedBox(
            //                   width: 25,
            //                 ),
            //                 Row(
            //                   children: [
            //                     Column(
            //                       mainAxisAlignment: MainAxisAlignment.start,
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text("Date"),
            //                         SizedBox(
            //                           width: 80,
            //                         ),
            //                         Text("Due Date"),
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       width: 15,
            //                     ),
            //                     Column(
            //                       children: [
            //                         Row(
            //                           children: [
            //                             Text(selectedDate),
            //                           ],
            //                         ),
            //                         Row(
            //                           children: [
            //                             Text(selectedDate1),
            //                           ],
            //                         ),
            //                       ],
            //                     )
            //                   ],
            //                 )
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //       Row(
            //         children: [
            //           Container(
            //             height: MediaQuery.of(context).size.height * 0.664,
            //             width: MediaQuery.of(context).size.width * 0.5,
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 35),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                 children: [
            //                   Text(
            //                     "Client",
            //                     style: TextStyle(
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   Text("Product Name",
            //                       style: TextStyle(fontWeight: FontWeight.bold)),
            //                   Text("Quantity",
            //                       style: TextStyle(fontWeight: FontWeight.bold)),
            //                   Text("Unit Price",
            //                       style: TextStyle(fontWeight: FontWeight.bold)),
            //                   Text("Total Price",
            //                       style: TextStyle(fontWeight: FontWeight.bold)),
            //                   Text("Address",
            //                       style: TextStyle(fontWeight: FontWeight.bold)),
            //                   Text("Fax_Number",
            //                       style: TextStyle(fontWeight: FontWeight.bold)),
            //                   Text("Payment Date",
            //                       style: TextStyle(fontWeight: FontWeight.bold)),
            //                   Text("Due Amount",
            //                       style: TextStyle(fontWeight: FontWeight.bold)),
            //                   Text("Paid Amount",
            //                       style: TextStyle(fontWeight: FontWeight.bold)),
            //                   Text("Payment Status",
            //                       style: TextStyle(fontWeight: FontWeight.bold)),
            //                 ],
            //               ),
            //             ),
            //           ),
            //           Container(
            //             height: MediaQuery.of(context).size.height * 0.664,
            //             width: MediaQuery.of(context).size.width * 0.5,
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //               children: [
            //                 Text(
            //                   "171",
            //                   style: TextStyle(fontSize: 15),
            //                 ),
            //                 Text(
            //                   productName,
            //                   style: TextStyle(fontSize: 15),
            //                 ),
            //                 Text(
            //                   quantity,
            //                   style: TextStyle(fontSize: 15),
            //                 ),
            //                 Text(
            //                   unitPrice,
            //                   style: TextStyle(fontSize: 15),
            //                 ),
            //                 Text(
            //                   totalPrice,
            //                   style: TextStyle(fontSize: 15),
            //                 ),
            //                 Text(
            //                   billAddress,
            //                   style: TextStyle(fontSize: 15),
            //                 ),
            //                 Text(
            //                   faxNumber,
            //                   style: TextStyle(fontSize: 15),
            //                 ),
            //                 Text(
            //                   selectedDate2,
            //                   style: TextStyle(fontSize: 15),
            //                 ),
            //                 Text(
            //                   dueAmount,
            //                   style: TextStyle(fontSize: 15),
            //                 ),
            //                 Text(
            //                   paidAmount,
            //                   style: TextStyle(fontSize: 15),
            //                 ),
            //                 Text(
            //                   paymentStatus,
            //                   style: TextStyle(fontSize: 15),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            //         child: GestureDetector(
            //           onTap: () {
            //             setState(() {
            //               print("object");
            //               createInvoice();
            //             });
            //           },
            //           child: Container(
            //             height: 35,
            //             width: double.maxFinite,
            //             color: Colors.deepOrange,
            //             child: Center(
            //                 child: Text(
            //               "Submit",
            //               style: TextStyle(color: Colors.white, fontSize: 18),
            //             )),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // );
          }),
    );
  }
}

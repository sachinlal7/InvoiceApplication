import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:http/http.dart' as http;
import 'package:invoice_app/model/custModels.dart';
import 'package:invoice_app/model/cust_list_model.dart';
import 'package:image_picker/image_picker.dart';

class ClientDetails extends StatefulWidget {
  final String clientId;
  ClientDetails({super.key, required this.clientId});

  @override
  State<ClientDetails> createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {
  bool isLoading = true;
  String clientId = "";
  XFile? _images;

  List data = [];

  Future<void> fetchDataAndInvoices() async {
    try {
      // Fetch clientIdVal and wait for it to complete
      await getClientIdv();

      // Now that you have clientIdVal, you can call clientsPendingInvoice
      await clientsPendingInvoice();

      // Continue with other operations if needed
    } catch (e) {
      // Handle errors here
      print('Error: $e');
    }
  }

  Future<void> EditClientDetails() async {
    print("three");
    final clientId = widget.clientId;

    final url = Base_URL + custlistendpoint;
    final uri = Uri.parse(url);

    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer $authorizationValues',
    });

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      for (final clientData in jsonData['data']) {
        final id = clientData['id'].toString();

        if (id == clientId) {
          final clientName = clientData['name'] as String;
          final clientNumber = clientData['phone_number'] as String;
          final clienEmail = clientData['email'] as String;
          print("name of client $clientName");

          // Now you have the clientName for the given clientId
          setState(() {
            userrname = clientName;
            userrNumber = clientNumber;
            userrEmail = clienEmail;
            print("value fetched");
          });
          break; // No need to continue searching
        }
      }
    } else {
      // Handle error case
    }
    setState(() {});
  }

  Future<void> getClientIdv() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientIdVal = prefs.getString(NEW_CLIENT_ID) ?? "";
    print("clientIdVal $clientIdVal");
    print("one");
  }

  Future<void> fetchClientDetails() async {
    print("two");
    getClientIdv();
    final clientId = widget.clientId;
    print(clientId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(NEW_CLIENT_ID, clientId);

    print("five");

    final url = Base_URL + custlistendpoint;
    final uri = Uri.parse(url);

    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer $authorizationValues',
    });

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      for (final clientData in jsonData['data']) {
        final id = clientData['id'].toString();

        if (id == clientId) {
          final clientName = clientData['name'] as String;
          final clientNumber = clientData['phone_number'] as String;
          final clienEmail = clientData['email'] as String;
          print("name of client $clientName");

          // Now you have the clientName for the given clientId
          if (mounted) {
            setState(() {
              userrname = clientName;
              userrNumber = clientNumber;
              userrEmail = clienEmail;
            });
          }
          break; // No need to continue searching
        }
      }
    } else {
      // Handle error case
    }
  }

  Future<void> clientsPendingInvoice() async {
    print("three");

    print(clientIdVal);
    final url = "http://192.168.1.35:8000/api/customer-list-all/$clientIdVal";

    final uri = Uri.parse(url);
    print(authorizationValues);
    final response = await http
        .get(uri, headers: {'Authorization': 'Bearer $authorizationValues'});
    print("status code ${response.statusCode}");
    print(response.body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as Map;
      var results = json['data'] as List;
      print(results);

      setState(() {
        data = results;
      });
    } else {
      print("error");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getClientIdv();
    fetchClientDetails();
    fetchDataAndInvoices();
    print('four');

    // fetchClientDetails();
    // clientsPendingInvoice();
  }

  @override
  Widget build(BuildContext context) {
    print("client build");
    return Scaffold(
      backgroundColor: Color_green,
      appBar: AppBar(
        title: Text("Information"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _images != null
                  ? CircleAvatar(
                      radius: 70,
                      backgroundImage: FileImage(File(_images!.path)),
                    )
                  : CircleAvatar(
                      radius: 70,
                      backgroundImage: custimg.isEmpty
                          ? NetworkImage("http://192.168.1.35:8000$CustIMG")
                          : NetworkImage(
                              "http://192.168.1.35:8000/media/sergio-de-paula-c_GmwfHBDzk-unsplash_fMxB4zq.jpg")),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name"),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Email"),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Phone"),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userrname),
                  SizedBox(
                    height: 5,
                  ),
                  Text(userrNumber),
                  SizedBox(
                    height: 5,
                  ),
                  Text(userrEmail),
                  SizedBox(
                    height: 5,
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              color: Color_white,
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Invoice \nNo"),
                  Text("Date"),
                  Text("Status"),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: 400,
              width: double.maxFinite,
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final dataItem = data[index] as Map;
                    InvoiceNumber = dataItem['invoice_number'].toString();
                    var InvoiceDate = dataItem['invoice_date'];

                    var paymentStatus = dataItem['payment_status'];
                    print("inv num $InvoiceNumber");
                    print(InvoiceDate);
                    print(paymentStatus);

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Container(
                        color: Color_white,
                        height: 60,
                        // width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(InvoiceNumber),
                            Text(InvoiceDate),
                            Text(paymentStatus),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}

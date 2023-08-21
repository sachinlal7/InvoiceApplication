import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:invoice_app/subscreens/add_clients.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../constants_colors.dart';

//  final bool isEdit;
final String name = "";
final formkey = GlobalKey<FormState>();

class NewClients extends StatefulWidget {
  const NewClients({super.key, this.isEdit, this.name});
  final String? name;
  final isEdit;
  @override
  State<NewClients> createState() => _NewClientsState();
}

class _NewClientsState extends State<NewClients> {
  TextEditingController customerController = TextEditingController();

  TextEditingController custEmailController = TextEditingController();

  TextEditingController custNumController = TextEditingController();

  bool isEdit = false;
  bool isvalid = true;
  List data = [];
  String name = "";

  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchEditDetails();
    // if (names.isNotEmpty) {
    //   customerController?.text = names[0];
    // }
    print("the transfrd name $name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.isEdit ? "Edit Details" : "Client Details"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.maxFinite,
            ),
            Form(
              key: formkey,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.maxFinite,
                color: Color_grey,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Client Name"),
                            SizedBox(
                              width: 2,
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 35,
                                  width: 200,
                                  color: Colors.white,
                                  child: TextFormField(
                                    maxLength: 30,
                                    controller: customerController,
                                    decoration: InputDecoration(
                                        counterText: "",
                                        hintText: " Customer Name",
                                        contentPadding:
                                            EdgeInsets.only(bottom: 9, left: 8),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none)),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          RegExp(r'^[\w-]+&').hasMatch(value)) {
                                        return "Enter correct Namess";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Email"),
                            SizedBox(
                              width: 50,
                            ),
                            Container(
                              height: 35,
                              width: 200,
                              color: Colors.white,
                              child: TextFormField(
                                controller: custEmailController,
                                decoration: InputDecoration(
                                    hintText: " Email Address",
                                    contentPadding: EdgeInsets.only(left: 8),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                                validator: EmailValidator(
                                    errorText: "Enter correct Email"),

                                // validator: (value) {
                                //   if (value!.isEmpty ||
                                //       RegExp(r'^[\w-\.]+@ ([\w-]+ \.)+[\w-]{2,5}')
                                //           .hasMatch(value)) {
                                //     return "correct email uid";
                                //   } else {
                                //     return "Enter correct email id";
                                //   }
                                // },
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Phone"),
                            SizedBox(
                              width: 50,
                            ),
                            Container(
                              height: 35,
                              width: 200,
                              color: Colors.white,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                controller: custNumController,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintText: " Phone Number",
                                  contentPadding: EdgeInsets.only(left: 8),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      RegExp(r'^[0-9]+$').hasMatch(value)) {
                                    return null;
                                  } else {
                                    return "enter correct phone number";
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width * 0.42,
                                color: Color_blue,
                                child: Center(
                                    child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                              onTap: () {
                                if (formkey.currentState!.validate()) {}

                                widget.isEdit
                                    ? updateData(customerIdValue)
                                    : submitData();
                              },
                              child: Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width * 0.42,
                                color: Colors.deepOrange,
                                child: Center(
                                    child: Text(
                                  widget.isEdit ? "Update" : "Save",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submitData() async {
    final body = {
      "name": customerController.text.toString(),
      "email": custEmailController.text.toString(),
      "phone_number": custNumController.text.toString()
    };

    final url = "http://192.168.1.31:8000/api/customer/";

    final uri = Uri.parse(url);
    print(authorizationValue);
    final response = await http.post(uri,
        body: body, headers: {'Authorization': 'Bearer $authorizationValue'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      customerController!.text = value;
      custEmailController.text = custEmailController.text;
      custNumController.text = custNumController.text;
      print('created successfully ');
    } else {
      print('creation failed');
    }

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AddClients()));
  }

  Future<void> updateData(String customerIdValue) async {
    final body = {
      "name": customerController.text,
      "email": custEmailController.text,
      "phone_number": custNumController.text
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var customerIdValue = prefs.get(getUser);
    print(" get user id $CustKey");

    final url = "http://192.168.1.31:8000/api/customer-edit/$customerIdValue";
    final uri = Uri.parse(url);
    print(authorizationValue);
    print(customerIdValue);
    final response = await http.put(uri,
        body: body, headers: {'Authorization': 'Bearer $authorizationValue'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('successfully updated');
    } else {
      print('update failed');
    }
    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AddClients()));
    }
  }

  Future<void> fetchEditDetails() async {
    final url = Base_URL + custlistendpoint;

    final uri = Uri.parse(url);
    print("seven");

    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // var getTheKey = prefs.getString(ACCESS_KEY);
    print(authorizationValue);
    final response = await http
        .get(uri, headers: {'Authorization': 'Bearer $authorizationValue'});

    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = jsonDecode(response.body) as Map;
      var results = json['data'] as List;
      List<Map<String, dynamic>> jsonData = List.from(results);

      List<String> names =
          jsonData.map((item) => item['name'].toString()).toList();
      // print(names[0]);
      // print(names[1]);

// Now you have the list of names. You can use this list to show them in your TextField.

      // print("customer id result $custres");
      // var setTheCustId = prefs.setInt(CUST_ID, custResults);
      setState(() {
        data = results;
        print("final data $data");
      });
    } else {
      print("error");
    }
  }

  // Future<void> clearUserData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   // prefs.remove(getKey);
  //   prefs.clear();
  //   prefs.remove(CUST_ID);
  //   prefs.reload();
  // }

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
                width: 150,
                child: Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color_orange),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("NO")),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color_orange),
                        onPressed: () {
                          updateData(customerIdValue);

                          customerController.clear();
                          custEmailController.clear();
                          custNumController.clear();
                          isLogin = false;
                          // clearUserData();

                          Fluttertoast.showToast(
                              msg: "created successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        child: Text("YES")),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isInputValid(String Name, String email, String phone) {
    return Name.isNotEmpty && email.isNotEmpty && phone.isNotEmpty;
  }
}

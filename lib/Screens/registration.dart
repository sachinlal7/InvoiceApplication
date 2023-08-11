import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/login.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'dashboard.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController businessController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController eMailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void signup(
      String email, password, number, business, username, address) async {
    var url = Uri.parse("http://192.168.1.33:8000/api/user-registration/");

    var response = await http.post(url, body: {
      "business_name": business,
      "email": email,
      "username": business,
      "password": password,
      "phone_number": number,
      "address": address
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Registered Successfully");
      print(data);
    } else {
      print("signup failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color_orange,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                // TextFormField(
                //   decoration: InputDecoration(
                //       filled: true,
                //       hintText: "Business Name",
                //       fillColor: Colors.white),
                // ),
                // SizedBox(
                //   height: 20,
                // ),

                Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 55,
                  width: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: businessController,
                    decoration: InputDecoration(
                        hintText: "Business Name",
                        contentPadding: EdgeInsets.only(left: 10),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Business Name";
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 40),
                Container(
                  height: 55,
                  width: 370,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5))),
                  child: TextFormField(
                    controller: userNameController,
                    decoration: InputDecoration(
                        hintText: "Username",
                        contentPadding: EdgeInsets.only(left: 10),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Username";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 0.5),
                Container(
                  height: 55,
                  width: 370,
                  color: Colors.white,
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: "Password",
                        contentPadding: EdgeInsets.only(left: 10),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 0.5),
                Container(
                  height: 55,
                  width: 370,
                  color: Colors.white,
                  child: TextFormField(
                    controller: eMailController,
                    decoration: InputDecoration(
                        hintText: "Email",
                        contentPadding: EdgeInsets.only(left: 10),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 0.5),
                Container(
                  height: 55,
                  width: 370,
                  color: Colors.white,
                  child: TextFormField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                        hintText: "Phone No",
                        contentPadding: EdgeInsets.only(left: 10),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Phone No";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 1),
                Container(
                  height: 55,
                  width: 370,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                  ),
                  child: TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                        hintText: "Address",
                        contentPadding: EdgeInsets.only(left: 10),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Address";
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DashBoard()));

                      Fluttertoast.showToast(
                          msg: "registered Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    signup(
                        eMailController.text.toString(),
                        passwordController.text.toString(),
                        phoneNumberController.text.toString(),
                        businessController.text.toString(),
                        userNameController.text.toString(),
                        addressController.text.toString());
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.059,
                    width: MediaQuery.of(context).size.height * 0.70,
                    child: Center(
                        child: Text(
                      "SIGN UP",
                      style: TextStyle(
                          color: Color_orange,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    )),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          decorationThickness: 1.8,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

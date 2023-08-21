import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/OtpScreen.dart';
import 'package:invoice_app/Screens/login.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'otpverify.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isEmailSent = false;
  String errorMessage = '';
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  Future<void> otpSent() async {
    try {
      final body = {"email": emailcontroller.text};
      print(emailcontroller.text);
      final url = Base_URL + forgotPassword;
      final uri = Uri.parse(url);

      final response = await http.post(uri, body: body);
      var data = jsonDecode(response.body);
      // Fluttertoast.showToast(
      //     msg: data['detail'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      print(data);
      final userId = data['user_id'];
      print(userId);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString(USER_ID, userId);

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        emailcontroller.text = " ";

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => OtpVerify()),
        // );

        print('otp sent to your email');
      } else {
        print('otp sending failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color_orange,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
              ),
              Text(
                "E-mail",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                height: 55,
                width: 370,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                child: TextFormField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Enter your email",
                      contentPadding: EdgeInsets.only(left: 10),
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                  validator: (value) {
                    if (value!.isEmpty ||
                        RegExp(r'^[\w-\.]+@ ([\w-]+ \.)+[\w-]{2,5}')
                            .hasMatch(value)) {
                      return "correct email uid";
                    } else {
                      return "Enter correct email id";
                    }
                  },
                ),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () async {
                  if (_validateEmail(emailcontroller.text)) {
                    await otpSent();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OtpVerify()));
                  } else {
                    Fluttertoast.showToast(
                      msg: "Enter correct email id",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.059,
                  width: MediaQuery.of(context).size.height * 0.474,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  child: Center(
                      child: Text(
                    "SEND",
                    style: TextStyle(
                        color: Color_orange,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                  )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: ((context) => Login())));
                    },
                    child: Text(
                      "Back to Sign in",
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
    );
  }

  bool _validateEmail(String email) {
    final emailValidator = EmailValidator(errorText: "Invalid Email Address");
    if (emailValidator.isValid(email)) {
      setState(() {
        errorMessage = ""; // Clear any existing error message
      });
      return true;
    } else {
      setState(() {
        errorMessage = "Invalid Email Address";
      });
      return false;
    }
  }
}

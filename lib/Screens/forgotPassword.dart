import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/OtpScreen.dart';
import 'package:invoice_app/Screens/login.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'otpverify.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isEmailSent = false;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  Future<void> otpSent() async {
    final body = {"email": emailcontroller.text};
    print(emailcontroller.text);
    final url = "http://192.168.1.33:8000/api/password/reset/email/";
    final uri = Uri.parse(url);

    final response = await http.post(uri, body: body);
    var data = jsonDecode(response.body);
    print(data);
    final userId = data['user_id'];
    print(userId);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(USER_ID, userId);

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
                  decoration: InputDecoration(
                      hintText: "Enter your Email",
                      contentPadding: EdgeInsets.only(left: 10),
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () async {
                  otpSent().then((value) => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OtpVerify())));
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
}

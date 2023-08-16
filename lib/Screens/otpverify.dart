import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/homescreen.dart';

import '../constants_colors.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class OtpVerify extends StatefulWidget {
  const OtpVerify({super.key});

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  bool isEmailSent = false;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  Future verifyOtp() async {
    final body = {
      "otp": otpcontroller.text,
      "new_password": newPasswordController.text
    };
    print(getUserIdValue);
    print("object first");

    final url =
        "http://192.168.1.31:8000/api/password/reset/verify/$getUserIdValue";
    final uri = Uri.parse(url);

    final response = await http.post(uri, body: body);

    if (response.statusCode == 200) {
      emailcontroller.text = emailcontroller.text;

      print('otp verified');
      Fluttertoast.showToast(
          msg: "Password reset successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      print('otp verification failed');
      Fluttertoast.showToast(
          msg: "otp verification failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
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
                "OTP",
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
                  controller: otpcontroller,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: "Enter the OTP",
                      contentPadding: EdgeInsets.only(left: 10),
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "New password",
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
                  controller: newPasswordController,
                  decoration: InputDecoration(
                      hintText: "Enter New Password",
                      contentPadding: EdgeInsets.only(left: 10),
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  verifyOtp().then((value) => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen())));
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
                    "Submit OTP",
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

  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getUserIdValue = prefs.getInt(USER_ID) ?? 00;
    print("sachin");
    print("get user id $getUserIdValue");
  }
}

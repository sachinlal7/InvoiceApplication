import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/dashboard.dart';
import 'package:invoice_app/Screens/forgotPassword.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invoice_app/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLogin = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isUserLoggedIn = false;
  bool _obscureText = true;

  void login(String username, password) async {
    try {
      var url = Uri.parse("http://192.168.1.33:8000/api/user-login/");
      var response = await http
          .post(url, body: {'username': username, 'password': password});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        final token = data['access'];
        final userId = data['user_id'];

        var prefs = await SharedPreferences.getInstance();
        var setToken = prefs.setString(ACCESS_KEY, token);
        var setUserId = prefs.setInt(USER_ID, userId);

        print("access ID : $setToken");

        if (mounted) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: ((context) => DashBoard())));
          isLogin = true;
        }

        isLogin = true;

        Fluttertoast.showToast(
            msg: "Login Sucessfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        print("Login Successfully");
      } else {
        if (mounted) {
          print("Login Failed");
          Fluttertoast.showToast(
              msg: "Login failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
    userNameController = TextEditingController(text: "sachinlal77");
    passwordController = TextEditingController(text: "sachin0403");

    //  getData();
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
                  height: 250,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 30,
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
                    controller: userNameController,
                    decoration: InputDecoration(
                      hintText: "Username",
                      contentPadding: EdgeInsets.only(left: 10, top: 12),
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'[a-z A-Z 0-9]+$').hasMatch(value!)) {
                        return "Enter Correct UserName";
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
                    obscureText: _obscureText,
                    obscuringCharacter: "*",
                    controller: passwordController,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(Icons.remove_red_eye)),
                        hintText: "Password",
                        contentPadding: EdgeInsets.only(left: 10, top: 15),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'[a-z A-Z 0-9]+$').hasMatch(value!)) {
                        return "Enter correct Password";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 0.5),
                SizedBox(
                  height: 0.5,
                ),
                SizedBox(height: 0.5),
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      login(userNameController.text.toString(),
                          passwordController.text.toString());
                    }
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => DashBoard()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.059,
                    width: MediaQuery.of(context).size.height * 0.432,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                    child: Center(
                        child: Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Color_orange,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                      },
                      child: Text(
                        "Forgot Password?",
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

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    authorizationValue = prefs.getString(ACCESS_KEY) ?? "";
    var getUserId = prefs.getString(USER_ID) ?? "";
    print(getUserId);

    print("fourth");
    print(ACCESS_KEY);
    // var prefs = await SharedPreferences.getInstance();
    // var getKey = prefs.getString(ACCESS_KEY);
    // var getUserId = prefs.getInt(USER_ID);

    // var KeyToken = getKey != null ? getKey : "No access key found";
    // var keyUser = getUserId != null ? getUserId : "No user id  found";

    // print("key token $KeyToken");
    // print("get key $getKey");

    // print("key user $keyUser");
    // print("user key $getUserId");
  }
}

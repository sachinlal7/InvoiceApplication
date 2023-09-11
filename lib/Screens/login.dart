import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/dashboard.dart';
import 'package:invoice_app/Screens/forgotPassword.dart';
import 'package:invoice_app/Screens/manageProfiles.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invoice_app/provider/google_signin_provider.dart';
import 'package:invoice_app/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

enum LoginMethod {
  API,
  Google,
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginMethod loginMethod = LoginMethod.API;
  bool isLogin = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isUserLoggedIn = false;
  bool _obscureText = true;

  // void login(String username, password) async {
  //   if (userNameController.text.isNotEmpty &&
  //       passwordController.text.isNotEmpty) {
  //     var url = Uri.parse("http://192.168.1.31:8000/api/user-login/");
  //     var response = await http
  //         .post(url, body: {'username': username, 'password': password});
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text("Login Successfully")));

  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       prefs.setString(ACCESS_KEY, data['access']);

  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => DashBoard()));
  //     } else {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("value not found")));
  //   }
  // }

  // void checkLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? val = prefs.getString("ACCESS_KEY");

  //   if (val != null) {
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: ((context) => DashBoard())),
  //         (route) => false);
  //   }
  // }

  void login(String username, password) async {
    if (loginMethod == LoginMethod.API) {
      try {
        var url = Uri.parse(Base_URL + userLogin);
        var response = await http
            .post(url, body: {'username': username, 'password': password});

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print(data);
          final token = data['access'];
          final userId = data['user_id'].toString();

          var prefs = await SharedPreferences.getInstance();
          var setToken = prefs.setString(ACCESS_KEY, token);
          prefs.setString(USER_ID, userId);

          print("access ID : $setToken");

          if (mounted) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => DashBoard())));
            isLogin = true;
            // profileGet();
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
    } else if (loginMethod == LoginMethod.Google) {
      final provider =
          Provider.of<GoogleSignInProvider>(context, listen: false);
      provider.googleLogin();
    }
  }

  void fetchProfile() async {
    final url = Base_URL + updateProfileApi;
    final uri = Uri.parse(url);
    final response = await http
        .get(uri, headers: {'Authorization': 'Bearer $authorizationValues'});
    print(response.statusCode);
    print(response.body);
    var data = jsonDecode(response.body);
    print(data);
    // businessName = data['data']['business_name'];
    // businessEmail = data['data']['email'];
    // UserName = data['data']['username'];
    // phoneNumber = data['data']['phone_number'];
    // address = data['data']['address'];
    // print("fetchedValue is $businessName");
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
    userNameController = TextEditingController(text: "alibaba121");
    passwordController = TextEditingController(text: "alibaba111");
    print("login page");
    //  getData();
    // fetchProfile();
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
                  height: 130,
                ),
                Container(
                  height: 180,
                  width: 180,
                  child: Image.asset("assets/images/see_products.png"),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.059,
                  width: MediaQuery.of(context).size.height * 0.432,
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
                  height: MediaQuery.of(context).size.height * 0.059,
                  width: MediaQuery.of(context).size.height * 0.432,
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
                    ManageProfiles(
                      loginMethod: LoginMethod.API,
                    );
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
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          decorationThickness: 1.8,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Row(
                    children: [
                      Text(
                        "------------------------------",
                        style: TextStyle(color: Color_white),
                      ),
                      Text(
                        " or ",
                        style: TextStyle(color: Color_white),
                      ),
                      Text(
                        "------------------------------",
                        style: TextStyle(color: Color_white),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      loginMethod =
                          LoginMethod.Google; // Update the login method
                    });
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googleLogin();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.059,
                    width: MediaQuery.of(context).size.height * 0.432,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                        child: Text(
                      "Login with Google",
                      style: TextStyle(
                          color: Color_orange,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    )),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.059,
                  width: MediaQuery.of(context).size.height * 0.432,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Text(
                    "Login with Facebook",
                    style: TextStyle(
                        color: Color_orange,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  )),
                ),
                ElevatedButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogout();
                    },
                    child: Text("Logout"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    authorizationValues = prefs.getString(ACCESS_KEY) ?? "";
    var getUserId = prefs.getString(USER_ID) ?? "";
    print(getUserId);

    print("fourth");
    print(ACCESS_KEY);
  }

  // Future<void> profileGet() async {
  //   final url = "http://192.168.1.31:8000/api/user-updated-profile/";
  //   final uri = Uri.parse(url);
  //   final response = await http
  //       .get(uri, headers: {'Authorization': 'Bearer $authorizationValue'});

  //   print("response get ${response.statusCode}");
  //   print(response.body);

  //   var data = jsonDecode(response.body);
  //   var daata = data['data'];
  //   // var BusinessName = daata['business_name'];
  //   // print('business name $BusinessName');
  // }
}

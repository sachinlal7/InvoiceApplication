// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:invoice_app/Screens/dashboard.dart';
// import 'package:invoice_app/constants_colors.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class CustList extends StatefulWidget {
//   const CustList({super.key, required id, required name, required phoneNumber, required email, required addedBy, required Id});

//   @override
//   State<CustList> createState() => _CustListState();
// }

// class _CustListState extends State<CustList> {
//   bool isLogin = false;
//   final _formkey = GlobalKey<FormState>();

//   bool isUserLoggedIn = false;

//   // void customerList() async {
//   //   var url = Uri.parse("http://192.168.1.31:8000/api/customer-list/");
//   //   var response = await http.post(url, headers: {});
//   //   try {
//   //     if (response.statusCode == 200) {
//   //       var data = jsonDecode(response.body);
//   //       print("daata cust $data");
//   //       final token = data['access'];
//   //       print("token print $token");
//   //       final userId = data['user_id'];
//   //       print("user id print $userId");

//   //       var prefs = await SharedPreferences.getInstance();
//   //       var setToken = prefs.setString(CUST_ID, token);
//   //       var setUserId = prefs.setInt(USER_ID, userId);

//   //       print("access ID : $setUserId");

//   //       if (mounted) {
//   //         Navigator.pushReplacement(
//   //             context, MaterialPageRoute(builder: ((context) => DashBoard())));
//   //       }

//   //       isLogin = true;

//   //       print("Login Successfully");
//   //     } else {
//   //       if (mounted) {
//   //         print("Login Failed");
//   //       }
//   //     }
//   //   } catch (e) {
//   //     print(e.toString());
//   //   }
//   // }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
//     // getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color_orange,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Form(
//             key: _formkey,
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 250,
//                 ),
//                 Text(
//                   "Login",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 30,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),

//                 // (Navigator.push(context,
//                 //     MaterialPageRoute(builder: (context) => DashBoard())));

//                 // isLogin == true
//                 //     ? (Navigator.push(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //             builder: (context) => DashBoard())))
//                 //     : print("error login");

//                 // login(eMailController.text.toString(),
//                 //     passwordController.text.toString());

//                 // login(eMailController.text.toString(),
//                 //     passwordController.text.toString());
//                 // Navigator.push(context,
//                 //     MaterialPageRoute(builder: (context) => DashBoard()));
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // void getData() async {
//   //   var prefs = await SharedPreferences.getInstance();
//   //   var getKey = prefs.getString(ACCESSKEY);
//   //   var getUserId = prefs.getInt(USER_ID);

//   //   var KeyToken = getKey != null ? getKey : "No access key found";
//   //   var keyUser = getUserId != null ? getUserId : "No user id  found";

//   //   print("key token $KeyToken");
//   //   print("get key $getKey");

//   //   print("key user $keyUser");
//   //   print("user key $getUserId");
//   // }
// }

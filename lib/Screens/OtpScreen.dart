// import 'package:flutter/material.dart';
// import 'package:invoice_app/Screens/login.dart';
// import 'package:invoice_app/constants_colors.dart';

// class OtpScreen extends StatefulWidget {
//   const OtpScreen({super.key});

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   TextEditingController _emailcontroller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color_orange,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 300,
//               ),
//               Text(
//                 "E-mail",
//                 style: TextStyle(color: Colors.white),
//               ),
//               SizedBox(
//                 height: 6,
//               ),
//               Container(
//                 height: 55,
//                 width: 370,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(5),
//                         topRight: Radius.circular(5))),
//                 child: TextFormField(
//                   controller: _emailcontroller,
//                   decoration: InputDecoration(
//                       hintText: "Enter your Email",
//                       contentPadding: EdgeInsets.only(left: 10),
//                       border:
//                           UnderlineInputBorder(borderSide: BorderSide.none)),
//                 ),
//               ),
//               SizedBox(height: 40),
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.059,
//                 width: MediaQuery.of(context).size.height * 0.474,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(5),
//                         bottomRight: Radius.circular(5))),
//                 child: Center(
//                     child: Text(
//                   "SEND",
//                   style: TextStyle(
//                       color: Color_orange,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 20),
//                 )),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushReplacement(context,
//                           MaterialPageRoute(builder: ((context) => Login())));
//                     },
//                     child: Text(
//                       "Back to Sign in",
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                         decoration: TextDecoration.underline,
//                         decorationColor: Colors.white,
//                         decorationThickness: 1.8,
//                       ),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

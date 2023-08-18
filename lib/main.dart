import 'package:flutter/material.dart';

import 'Screens/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const String KEYLOGIN = "KEY";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Invoice App',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: Color.fromARGB(255, 69, 150, 216),
      //   ),
      //   useMaterial3: true,
      // ),
      home: HomeScreen(),
    );
  }
}

void whereToGo() async {
  var prefs = await SharedPreferences.getInstance();
  prefs.getBool("KEY");

  // Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
  //   HomeScreen();
  // })));
}

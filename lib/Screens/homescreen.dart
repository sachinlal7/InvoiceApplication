import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/home_google.dart';
import 'package:invoice_app/Screens/registration.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:provider/provider.dart';

import '../provider/google_signin_provider.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color_orange,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/images/homescreen.png"),
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.12,
          ),
          Text(
            "Invoice Simple",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Create professional invoices in seconds!",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Registration()));
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.059,
              width: MediaQuery.of(context).size.height * 0.20,
              child: Center(
                  child: Text(
                "GET STARTED",
                style:
                    TextStyle(color: Color_orange, fontWeight: FontWeight.w400),
              )),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
          ),
          SizedBox(
            height: 15,
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
                      MaterialPageRoute(builder: (context) => HomeGoogle()));
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
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogout();
              },
              child: Text("Logout"))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/dashboard.dart';
import 'package:invoice_app/Screens/dashboardInvoice.dart';
import 'package:invoice_app/Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:invoice_app/Screens/manageProfiles.dart';

class HomeGoogle extends StatelessWidget {
  const HomeGoogle({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return DashBoard();
          } else if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          } else {
            return Login();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../model/custModels.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.custDet});
  final Datum custDet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${custDet.name}'s"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(height: 10),
                Text(
                  custDet.name,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                )
              ],
            ),
          ),
        ));
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:http/http.dart' as http;
import 'package:invoice_app/model/custModels.dart';
import 'package:invoice_app/model/cust_list_model.dart';

class ClientDetails extends StatelessWidget {
  final Datum custDetail;
  ClientDetails({
    super.key,
    required this.custDetail,
  });

  bool isLoading = true;

  List data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color_green,
      appBar: AppBar(
        title: Text("${custDetail.name}"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("assets/images/person.jpg"),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("Name"),
                  Text("Email"),
                  Text("Phone"),
                  Text("Invoice"),
                ],
              ),
              Column(
                children: [
                  Text(custDetail.name),
                  Text(custDetail.email),
                  Text("Phone"),
                  Text("Status")
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
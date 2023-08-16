import 'package:flutter/material.dart';

final Color_orange = const Color(0xFFFF7F27);
final Color_grey = Color.fromARGB(255, 226, 226, 226);
final Color_green = Color.fromARGB(255, 205, 223, 215);
final Color_white = Colors.white;
final Color_blue = Color.fromARGB(255, 11, 138, 211);

final Base_URL = "http://192.168.1.31:8000/api/";

final custlistendpoint = "customer-list/";

final ACCESS_KEY = "";
final token = "";
final userId = "";
final USER_ID = " ";
final CUST_ID = "";
final data = "";
final getData = "";
final CustKey = "";
final getUser = "";
final custIDnew = "";
final personId = "";
final value = "";
final errorMsg = "";
final names = "";
var businessName = "";
final BUSINESS_NAME = "";
final EMAIL_ID = "";

final dataItem = "";
late bool isLogin = true;
String _authValue = "";
set authorizationValue(String val) => _authValue = val;
String get authorizationValue => _authValue;
String authSetValue = "";

String _CustIDValue = "";
set customerIdValue(String val) => _CustIDValue = val;
String get customerIdValue => _CustIDValue;

int _IDValue = 11;
set getUserIdValue(int val) => _IDValue = val;
int get getUserIdValue => _IDValue;

// String _business = "";
// set businessName(String val) => _business = val;
// String get businessName => _business;

String _email = "";
set emailId(String val) => _email = val;
String get emailId => _email;

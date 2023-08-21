import 'package:flutter/material.dart';

final Color_orange = const Color(0xFFFF7F27);
final Color_grey = Color.fromARGB(255, 226, 226, 226);
final Color_green = Color.fromARGB(255, 205, 223, 215);
final Color_white = Colors.white;
final Color_blue = Color.fromARGB(255, 11, 138, 211);

final Base_URL = "http://192.168.1.31:8000/api/";
final BASE_URL = "http://69.49.235.253:8035/api/";

final userRegistration = "user-registration/";
final userLogin = "user-login/";
final changePassword = "change-password/";
final updateProfileApi = "user-updated-profile/";
final resetEmail = "password/reset/email/";
final otpVerify = "password/reset/verify/";
final logout = "logout";
final addCustomer = "customer/";
final custlistendpoint = "customer-list/";
final customerEdit = "customer-edit/8";
final customerDeleteApi = "customer-delete/";
final createInvoice = "invoice/";
final invoiceList = "invoice-list/";
final editInvoice = "edit-invoice/7";
final deleteInvoice = "delete-invoice/7";
final paymentReminders = "send_payment_reminders/";
final forgotPassword = "forgot-password/";

final Url_image = "http://192.168.1.31:8000";
final URL_image = "http://69.49.235.253:8035";
String uploadedImageUrl = URL_image + image;

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
var personId = "";
var personName = "";
final value = "";
final errorMsg = "";
final names = "";
String? businessName = "";
var companyName = "";
var image = "";
var businessEmail = "";
var UserName = "";
var phoneNumber = "";
var address = "";
final BUSINESS_NAME = "";
final EMAIL_ID = "";
var NAME = "";
// final personEmail = "";

final dataItem = "";
final imageUrl = "";

final name = "";
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

String _emailPerson = "";
set personEmail(String val) => _emailPerson = val;
String get personEmail => _emailPerson;

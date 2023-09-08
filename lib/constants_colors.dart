import 'package:flutter/material.dart';

final Color_orange = const Color(0xFFFF7F27);
final Color_grey = Color.fromARGB(255, 226, 226, 226);
final Color_green = Color.fromARGB(255, 205, 223, 215);
final Color_white = Colors.white;
final Color_blue = Color.fromARGB(255, 11, 138, 211);

final Base_URL = "http://192.168.1.35:8000/api/";
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

final Url_image = "http://192.168.1.35:8000";
final URL_image = "http://69.49.235.253:8035";
String uploadedImageUrl = URL_image + image;

final ACCESS_KEY = "";
final NEW_CLIENT_ID = "";
final clientUserId = "";
final token = "";
final userId = "";
final USER_ID = " ";
final CUST_ID = "";
final data = "";
final getData = "";
final CustKey = "";
final InvId = "";
final getUser = "";
final getInvoiceID = "";
final INVOICE_ID = "";
var invoiceID = "";
final custIDnew = "";
var INV_ID = "";
var personId = "";
var personName = "";
var InvoiceNumber = "";
var InvoiceClientName = "";
final value = "";
final errorMsg = "";
final names = "";
String? businessName = "";
var companyName = "";
var image = "";
var custimg = "";
var client_image = "";
var CustImage = "";
String ClientImageUrl = "";
String InvoicelogoURL = "";
var logO = "";

var businessEmail = "";
var UserName = "";
var phoneNumber = "";
var address = "";

var namess = "";

String ClientName = "";
var ClientEmail = "";
var ClientNumber = "";
var ClientImage = "";
final BUSINESS_NAME = "";
final EMAIL_ID = "";
var NAME = "";
// final personEmail = "";

final dataItem = "";
final imageUrl = "";

bool isSearching = false;

final name = "";
late bool isLogin = true;

String _authValue = "";
set authorizationValues(String val) => _authValue = val;
String get authorizationValues => _authValue;
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

// String _imageValue = "";
// set profileImage(String val) => _imageValue = val;
// String get profileImage => _imageValue;

String _imagValue = "";
set clientImage(String val) => _imagValue = val;
String get clientImage => _imagValue;

String _ClientID = "";
set clientIdValue(String val) => _ClientID = val;
String get clientIdValue => _ClientID;

String _ClienID = "";
set newCustId(String val) => _ClienID = val;
String get newCustId => _ClienID;

String _InvoiceID = "";
set InvoiceIdValue(String val) => _InvoiceID = val;
String get InvoiceIdValue => _InvoiceID;

String _InvID = "";
set InvIdValue(String val) => _InvID = val;
String get InvIdValue => _InvID;

String _ClientIDV = "";
set clientIdVal(String val) => _ClientIDV = val;
String get clientIdVal => _ClientIDV;

String _ClientIDvv = "";
set client_name(String val) => _ClientIDvv = val;
String get client_name => _ClientIDvv;

String _InvoID = "";
set InvoiceId(String val) => _InvoID = val;
String get InvoiceId => _InvoID;

String _ProdName = "";
set ProductName(String val) => _ProdName = val;
String get ProductName => _ProdName;

String _QTY = "";
set Quantity(String val) => _QTY = val;
String get Quantity => _QTY;

String _CLIid = "";
set ClientiD(String val) => _CLIid = val;
String get ClientiD => _CLIid;

String _untPrice = "";
set UniTprice(String val) => _untPrice = val;
String get UniTprice => _untPrice;

String _adrs = "";
set Addresss(String val) => _adrs = val;
String get Addresss => _adrs;

String _faxNUM = "";
set FAXnum(String val) => _faxNUM = val;
String get FAXnum => _faxNUM;

String _PAYDT = "";
set PayDATE(String val) => _PAYDT = val;
String get PayDATE => _PAYDT;

String _Totlprc = "";
set Totalprice(String val) => _Totlprc = val;
String get Totalprice => _Totlprc;

String _paidamt = "";
set Paid_amount(String val) => _paidamt = val;
String get Paid_amount => _paidamt;

String _INVDT = "";
set InvDATE(String val) => _INVDT = val;
String get InvDATE => _INVDT;

String _DUEDT = "";
set dUE_DATE(String val) => _DUEDT = val;
String get dUE_DATE => _DUEDT;

String _USRID = "";
set MainUserID(String val) => _USRID = val;
String get MainUserID => _USRID;

String _CLTid = "";
set ClienTiD(String val) => _CLTid = val;
String get ClienTiD => _CLTid;

String _paidvv = "";
set paidVALUE(String val) => _paidvv = val;
String get paidVALUE => _paidvv;

String _prdct = "";
set PRoductName(String val) => _prdct = val;
String get PRoductName => _prdct;

String _qtyyy = "";
set Qty(String val) => _qtyyy = val;
String get Qty => _qtyyy;

String _untprc = "";
set UNitPrice(String val) => _untprc = val;
String get UNitPrice => _untprc;

String _ttlsprc = "";
set TotalsPRICE(String val) => _ttlsprc = val;
String get TotalsPRICE => _ttlsprc;

String _adrss = "";
set addRess(String val) => _adrss = val;
String get addRess => _adrss;

String _fxnum = "";
set faxnuM(String val) => _fxnum = val;
String get faxnuM => _fxnum;

String? _imgValue;
set clientIMAGE_URL(String? val) => _imgValue = val;
String get clientIMAGE_URL => _imgValue ?? " ";

String? _loGo;
set lOGO(String? val) => _loGo = val;
String get lOGO => _loGo ?? " ";

String _cstimg = "";
set CustIMG(String val) => _cstimg = val;
String get CustIMG => _cstimg;

String _prsnid = "";
set PersONid(String val) => _prsnid = val;
String get PersONid => _prsnid;

String _cstidnew = "";
set CustIDNeww(String val) => _cstidnew = val;
String get CustIDNeww => _cstidnew;

final PROFILE_IMAGE = "";
final CLIENT_IMAGE = "";

var IMAGE_URL = "";

var userrname = "";
var INV_id = "";
var Invoice_ID = "";
var InvoiceUserName = "";
var InvoiceProductName = "";
var InvoiceQuantity = "";
var InvoiceUnitPrice = "";
var InvoiceTotalPrice = "";
var InvoiceAddress = "";
var InvoiceDueDate = "";
var InvoiceDate = "";
var InvoiceFax = "";
var InvoicePaidAmount = "";
var userrNumber = "";
var userrEmail = "";
var userrPhoto = "";
var productName = "";
var quantity = "";
var unitPrice = "";
var totalPrice = "";
var billAddress = "";
var faxNumber = "";
var paymentDate = "";
var dueAmount = "";
var paidAmount = "";
var paymentStatus = "";
var paymentDateSelected = "";
var selectedDate = "";
var dueDateSelected = "";
var invoicecustid = "";
var invoicecustname = "";
var clientid = "";

var clientName = "";
var CLIENT_NAME = "";

String profileImageUrlss = "";
String CustomerProfileURL = "";
List foundUsers = [];
// var idValue = "";\
var changedValue = "";
var changedID = "";
var clientID = "";
var CLIENTId = "";
List AllInvoices = [];

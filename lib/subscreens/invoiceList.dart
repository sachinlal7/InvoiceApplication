import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/invoice_add.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:http/http.dart' as http;
import 'package:invoice_app/model/custName_mdoels.dart';
import 'package:invoice_app/model/invoiceListModel.dart';
import 'package:invoice_app/subscreens/webView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InvoiceList extends StatefulWidget {
  // final TextEditingController searchController;
  final String searchQuery;
  final List<dynamic> filteredInvoices;
  const InvoiceList({
    super.key,
    required this.searchQuery,
    required this.filteredInvoices,
  });

  @override
  State<InvoiceList> createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  List data = [];
  List newData = [];
  bool isLoading = true;
  WebViewController controller = WebViewController();

  get searchQuery => null;

  Future<void> fetchInvoice() async {
    final url = "http://192.168.1.35:8000/api/invoice-list/";

    final uri = Uri.parse(url);
    print("sevennn");

    final response = await http
        .get(uri, headers: {'Authorization': 'Bearer $authorizationValues'});
    // print(response.body);
    // print("response body");

    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = jsonDecode(response.body) as Map;
      var results = json['data'] as List;
      // print(results);

      // print("customer id result $custres");
      // var setTheCustId = prefs.setInt(CUST_ID, custResults);
      if (mounted) {
        setState(() {
          AllInvoices = results;
          foundUsers = AllInvoices;
        });
      }
    } else {
      print("error");
    }
    if (mounted) {
      setState(() {
        isLoading = false;
        // void getdata(int index) {
        //   var custNum = custResults[index][index];
        //   print("numbr of cust $custNum");
        // }
      });
    }
  }

  List<invoice_models> get filteredItems {
    // Create a list to store filtered results
    List<invoice_models> filteredList = [];

    // Iterate through each invoice_models object
    for (var invoiceModel in data) {
      // Filter the data list within the current invoice_models object
      var filteredData = invoiceModel.data!
          .where((item) =>
              item.clientName != null &&
              item.clientName!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();

      // If the filtered data list is not empty, add it to the filteredList
      if (filteredData.isNotEmpty) {
        // Create a new invoice_models object with the filtered data
        invoice_models filteredInvoiceModel = invoice_models(
          status: invoiceModel.status,
          message: invoiceModel.message,
          data: filteredData,
        );

        // Add the filtered invoice_models object to the result list
        filteredList.add(filteredInvoiceModel);
      }
    }

    return filteredList;
  }

  Future<void> deleteInvoice(String InvoiceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var InvId = prefs.get(getInvoiceID);
    print(" get user id $InvId");
    print("SEVENTEEN");

    final url = "http://192.168.1.35:8000/api/delete-invoice/$InvId";

    final uri = Uri.parse(url);

    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      final filtered =
          data.where((element) => element['id'] != CustKey).toList();

      setState(() {
        data = filtered;
        // print("filtered data $data");
      });
    } else {}
    fetchInvoice();
  }

  Future<void> WebView() async {
    final url = "http://192.168.1.31:8000/api/preview/$invoiceID";

    final uri = Uri.parse(url);

    print(authorizationValues);
    final response = await http
        .get(uri, headers: {'Authorization': 'Bearer $authorizationValues'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = jsonDecode(response.body) as Map;
      var results = json['data'] as List;
      print(results);

      // print("customer id result $custres");
      // var setTheCustId = prefs.setInt(CUST_ID, custResults);
      setState(() {
        data = results;
      });
    } else {
      print("error");
    }
    setState(() {
      isLoading = false;
      // void getdata(int index) {
      //   var custNum = custResults[index][index];
      //   print("numbr of cust $custNum");
      // }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchInvoice();
  }

  @override
  Widget build(BuildContext context) {
    // final List<dynamic> items = filteredInvoices;
    return Scaffold(
        body: Visibility(
      visible: isLoading,
      child: Center(
        child: CircularProgressIndicator(),
      ),
      replacement: RefreshIndicator(
        onRefresh: fetchInvoice,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.maxFinite,
                child: foundUsers.isNotEmpty
                    ? ListView.builder(
                        itemCount: foundUsers.length,
                        itemBuilder: (context, index) {
                          final dataItem = foundUsers[index];
                          var invoiceID = dataItem['id'].toString();
                          var InvoiceNumber =
                              dataItem['invoice_number'].toString();
                          var totalPrice = dataItem['total_price'];
                          var paidAmount = dataItem['paid_amount'] ?? "";
                          var productName = dataItem['product_name'];
                          var quantity = dataItem['quantity'].toString();
                          var clientName = dataItem['client_name'];
                          var paymentStatus = dataItem['payment_status'];
                          var clieNtId = dataItem['client_id'].toString();
                          var unitprice = dataItem['unit_price'];
                          var address = dataItem['address'];
                          var faxnum = dataItem['fax_number'];
                          var paydate = dataItem['payment_date'];
                          var invoiceDATE = dataItem['invoice_date'];
                          var dueDATE = dataItem['due_date'];
                          var logO = dataItem['logo'];

                          InvoicelogoURL = "http://192.168.1.35:8000$logO";

                          print("logo $InvoicelogoURL");
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WebViewPage()));
                              },
                              child: Container(
                                height: 100,
                                color: Color_green,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          InvoiceNumber,
                                          style:
                                              TextStyle(color: Colors.blueGrey),
                                        ),
                                        Text(
                                          clientName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text("₹ $totalPrice")
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("₹ $paidAmount"),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            paymentStatus,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  paymentStatus.toLowerCase() ==
                                                          'paid'
                                                      ? Colors.green
                                                      : Colors.red,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: GestureDetector(
                                                  onTap: () async {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return customDialog1();
                                                        });
                                                  },
                                                  child: Icon(Icons.share)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: GestureDetector(
                                                  onTap: () async {
                                                    print(
                                                        "edit pressed $ProductName");
                                                    INV_ID = invoiceID;
                                                    client_name = clientName;
                                                    ProductName = productName;
                                                    Quantity = quantity;
                                                    ClientiD = clientid;
                                                    UniTprice = unitprice;
                                                    Addresss = address;
                                                    FAXnum = faxnum;
                                                    PayDATE = paydate;
                                                    Totalprice = totalPrice;
                                                    Paid_amount = paidAmount;
                                                    InvDATE = invoiceDATE;
                                                    dUE_DATE = dueDATE;
                                                    ClienTiD = clieNtId;
                                                    lOGO = logO;

                                                    // print(getUser);
                                                    // print("twelve $keyuser");

                                                    // fetchEditDetails();
                                                    print("edit pressed");
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    InvoiceAdd(
                                                                      isEdit:
                                                                          true,
                                                                      InvoiceId:
                                                                          invoiceID,

                                                                      // name: dataItem[
                                                                      //     'name'],
                                                                    )));
                                                  },
                                                  child: Icon(Icons.edit)),
                                            ),
                                            IconButton(
                                                onPressed: () async {
                                                  print(custIDnew);
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  var keyuser = prefs.setString(
                                                      getInvoiceID, invoiceID);
                                                  print("eighteen");
                                                  print(keyuser);
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return customDialog(
                                                            "Deleted Successfully",
                                                            "Are you sure want to delete ?");
                                                      });
                                                },
                                                icon: Icon(Icons.delete)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                // child: ListTile(

                                //   title: Text("Client Name"),
                                //   subtitle: Text(InvoiceNumber),
                                //   trailing: Text("\$0.00"),

                                // ),
                              ),
                            ),
                          );
                        })
                    : Text("No match found"),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget customDialog(String text, warning) {
    return Dialog(
      child: SizedBox(
        height: 150,
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                color: Color_orange,
                child: Center(
                    child: Text(
                  warning,
                  style: TextStyle(color: Color_white, fontSize: 18),
                )),
              ),
            ),
            Expanded(
              child: Container(
                height: 40,
                width: 260,
                child: Row(
                  children: [
                    SizedBox(
                      width: 110,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color_orange),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("NO")),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 110,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color_orange),
                          onPressed: () {
                            deleteInvoice(personId.toString())
                                .then((value) => Navigator.pop(context));
                            isLogin = false;
                            // clearUserData();
                            setState(() {
                              fetchInvoice();
                            });

                            Fluttertoast.showToast(
                                msg: text,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                          child: Text("YES")),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customDialog1() {
    return Dialog(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                color: Color_white,
                child: IconButton(
                    onPressed: () async {
                      String? encodeQueryParameters(
                          Map<String, String> params) {
                        return params.entries
                            .map((MapEntry<String, String> e) =>
                                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                            .join('&');
                      }

                      final Uri emailuri = Uri(
                          scheme: 'mailto',
                          path: 'mobappsolutions179@gmail.com',
                          query: encodeQueryParameters(<String, String>{
                            'subject': 'Bill Genearted',
                            'body': 'Thanks for Shopping'
                          }));
                      launchUrl(emailuri);
                    },
                    icon: Icon(
                      Icons.mail,
                      size: 50,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

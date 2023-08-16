import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoice_app/subscreens/client.dart';
import 'package:http/http.dart' as http;
import 'package:invoice_app/widgets/navBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Screens/homescreen.dart';
import '../constants_colors.dart';

class AddClients extends StatefulWidget {
  AddClients({super.key});

  @override
  State<AddClients> createState() => _AddClientsState();
}

class _AddClientsState extends State<AddClients> {
  TextEditingController customerController = TextEditingController();

  TextEditingController custEmailController = TextEditingController();

  TextEditingController custNumController = TextEditingController();
  List data = [];
  int selectedNameIndex = -1;

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("six");
    fetchCust();
    print("eight");
    // idOfUser();
    print("SIXTEEN");
    // getidOfUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Client Details"),
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(
          child: CircularProgressIndicator(),
        ),
        replacement: RefreshIndicator(
          onRefresh: fetchCust,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: double.maxFinite,
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          print("ten");
                          final dataItem = data[index] as Map;
                          var custIDnew = dataItem['id'].toString();
                          print(custIDnew);

                          final person = data[index];
                          final personId = person["id"];

                          print("id of prsnn $personId");
                          print("eleven");

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              height: 110,
                              width: double.maxFinite,
                              color: Color_green,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Customer"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Email"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Phone"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [Text(dataItem['name'])],
                                        ),
                                        Row(
                                          children: [Text(dataItem['email'])],
                                        ),
                                        Row(
                                          children: [
                                            Text(dataItem['phone_number']
                                                .toString())
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: GestureDetector(
                                            onTap: () async {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              var keyuser = prefs.setInt(
                                                  getUser, personId);
                                              print(getUser);
                                              print("twelve $keyuser");
                                              fetchEditDetails();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NewClients(
                                                            isEdit: true,
                                                          )));
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                  child: Text(
                                                "Edit",
                                                style: TextStyle(
                                                    color: Color_white),
                                              )),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              print(custIDnew);
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              var keyuser = prefs.setInt(
                                                  getUser, personId);
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
                                            icon: Icon(Icons.delete))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Container(
                    color: Color_blue,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewClients(
                                        isEdit: false,
                                      )));

                          setState(() {
                            fetchCust();
                            isLoading = true;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            height: 35,
                            width: double.maxFinite,
                            color: Color_orange,
                            child: Center(
                                child: Text(
                              "Add Client",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchCust() async {
    final url = Base_URL + custlistendpoint;

    final uri = Uri.parse(url);
    print("seven");

    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // var getTheKey = prefs.getString(ACCESS_KEY);
    print(authorizationValue);
    final response = await http
        .get(uri, headers: {'Authorization': 'Bearer $authorizationValue'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = jsonDecode(response.body) as Map;
      var results = json['data'] as List;

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

  Future<void> deletById(String personId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var CustKey = prefs.get(getUser);
    print(" get user id $CustKey");
    print("SEVENTEEN");
    print(CustKey);

    final url = "http://192.168.1.31:8000/api/customer-delete/$CustKey";

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
  }

  Future<void> fetchEditDetails() async {
    final url = Base_URL + custlistendpoint;

    final uri = Uri.parse(url);
    print("seven");

    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // var getTheKey = prefs.getString(ACCESS_KEY);
    print(authorizationValue);
    final response = await http
        .get(uri, headers: {'Authorization': 'Bearer $authorizationValue'});

    print(response.body);
    var dataRes = response.body;

    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = jsonDecode(response.body) as Map;
      var results = json['data'] as List;
      List<Map<String, dynamic>> jsonData = List.from(results);

      List<String> names =
          jsonData.map((item) => item['name'].toString()).toList();
      print(names[0]);
      print(names[1]);

      setState(() {
        data = results;
        print("final data $data");
      });
    } else {
      print("error");
    }
  }

  void idOfUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(CUST_ID, personId);
    print("nine");
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
                            deletById(personId.toString())
                                .then((value) => Navigator.pop(context));
                            isLogin = false;
                            // clearUserData();

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
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoice_app/subscreens/client.dart';
import 'package:http/http.dart' as http;
import 'package:invoice_app/subscreens/clientDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // fetchCust();
    fetchCust();
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Clients"),
        centerTitle: true,
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
                          personId = person["id"].toString();
                          personName = person['name'];

                          print("id of prsnn $personId");
                          print("name of prsnn $personName");
                          print("eleven");

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              height: 122,
                              width: double.maxFinite,
                              color: Color_green,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        width: 48,
                                        child: Column(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 15,
                                                  backgroundImage: AssetImage(
                                                      "assets/images/person.jpg"),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.phone_android),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(6),
                                        width: 140,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [Text("Client Name")],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [Text("Client Number")],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(dataItem['name']),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(dataItem['phone_number']
                                                  .toString())
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: GestureDetector(
                                              onTap: () async {
                                                // SharedPreferences prefs =
                                                //     await SharedPreferences
                                                //         .getInstance();
                                                // var keyuser = prefs.setString(
                                                //     getUser, personId);
                                                // print(getUser);
                                                // print("twelve $keyuser");

                                                // fetchEditDetails();
                                                print("edit pressed");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NewClients(
                                                              isEdit: true,
                                                              clientId:
                                                                  custIDnew,

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
                                            icon: Icon(Icons.delete)),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ClientDetails(
                                                            clientId: custIDnew,
                                                          )));
                                            },
                                            icon: Icon(Icons.info_outline))
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

                          // setState(() {
                          //   fetchCust();
                          //   isLoading = true;
                          // });
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

  Future<void> deletById(String personId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var CustKey = prefs.get(getUser);
    print(" get user id $CustKey");
    print("SEVENTEEN");
    print(CustKey);

    final url = Base_URL + customerDeleteApi + "$CustKey";

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
    fetchCust();
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
                            setState(() {
                              fetchCust();
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
}

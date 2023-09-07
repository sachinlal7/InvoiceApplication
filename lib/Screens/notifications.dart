import 'dart:convert';

import 'package:flutter/material.dart';

import '../constants_colors.dart';
import 'package:http/http.dart' as http;

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List data = [];
  bool isLoading = true;
  Future<void> getNotifications() async {
    final url = "http://192.168.1.35:8000/api/notifications/";

    final uri = Uri.parse(url);
    print(authorizationValues);
    final response = await http
        .get(uri, headers: {'Authorization': 'Bearer $authorizationValues'});
    print("status code ${response.statusCode}");
    print(response.body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as Map;
      var results = json['data'] as List;
      print(results);

      setState(() {
        data = results;
      });
    } else {
      print("error");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.maxFinite,
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final dataitem = data[index] as Map;
                  var title = dataitem['title'];
                  var message = dataitem['message'];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                        color: Color_green,
                        child: Container(
                          height: 110,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(color: Color_orange),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(message),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Date"),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.delete))
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

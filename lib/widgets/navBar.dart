import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/dashboard.dart';
import 'package:invoice_app/Screens/homescreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invoice_app/constants_colors.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/manageProfiles.dart';
import 'settings.dart';

class NavBar extends StatefulWidget {
  final String businessName;
  final String emailId;

  const NavBar({super.key, required this.businessName, required this.emailId});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool isLogin = false;
  String profileImageUrl = "";

  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // prefs.remove(getKey);
    prefs.clear();
    prefs.remove(ACCESS_KEY);
    print("REMOVE ACCESS $ACCESS_KEY");
    prefs.reload();
  }

  void fetchProfile() async {
    final url = Base_URL + updateProfileApi;
    final uri = Uri.parse(url);
    final response = await http
        .get(uri, headers: {'Authorization': 'Bearer $authorizationValue'});
    print(response.statusCode);
    print(response.body);
    var data = jsonDecode(response.body);
    print(data);
    businessName = data['data']['business_name'];
    businessEmail = data['data']['email'];
    UserName = data['data']['username'];
    // phoneNumber = data['data']['phone_number'];
    address = data['data']['address'];
    image = data['data']['profile_pic'];
    print(image);

    profileImageUrl = Url_image + image;

    print("fetchedValue is $businessName");
    print(profileImageUrl);
    final circleAvatar = CircleAvatar(
      backgroundImage: NetworkImage(profileImageUrl),
      radius: 40.0,
    );
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    fetchProfile();

    print("setstate again");
    // fetchProfile();
    debugPrint("object");
    debugPrint("data");
  }

  @override
  Widget build(BuildContext context) {
    print("build call");
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 250,
              child: UserAccountsDrawerHeader(
                  currentAccountPicture: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(profileImageUrl),
                    ),
                  ),
                  accountName: Text(
                    businessName!,
                    style: TextStyle(color: Color_white),
                  ),
                  accountEmail: Text(
                    businessEmail,
                    style: TextStyle(fontSize: 12),
                  )),
            ),
            GestureDetector(
              onTap: () {
                print(URL_image + image);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DashBoard()));
                isLogin = false;
              },
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ManageProfiles()));
                setState(() {});
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Manage Profile"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text("Pivacy Policy"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              },
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return customDialog();
                    });
              },
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About us"),
            ),
            ListTile(
              leading: Image(
                image: AssetImage("assets/images/t&c.png"),
                height: 25,
              ),
              title: Text("Terms and conditions"),
            ),
          ],
        ),
      ),
    );
  }

  Widget customDialog() {
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
                  "Are you sure you want to logout ?",
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
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                            isLogin = false;
                            clearUserData();

                            Fluttertoast.showToast(
                                msg: "Logout Sucessfully",
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

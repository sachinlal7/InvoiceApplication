import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/dashboard.dart';
import 'package:invoice_app/Screens/homescreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:invoice_app/webview/aboutus.dart';
import 'package:invoice_app/webview/contactUs.dart';
import 'package:invoice_app/webview/termsAndConditions.dart';

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
  // String profileImageUrlss = "";

  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // prefs.remove(getKey);
    prefs.clear();
    prefs.remove(ACCESS_KEY);
    print("REMOVE ACCESS $ACCESS_KEY");
    prefs.reload();
  }

  void fetchProfile() async {
    // final url = Base_URL + updateProfileApi;
    print('authorizationValue $authorizationValues');
    final url = "http://192.168.1.35:8000/api/user-updated-profile/";
    final uri = Uri.parse(url);
    final response = await http
        .get(uri, headers: {'Authorization': 'Bearer $authorizationValues'});
    print("statuss code ${response.statusCode}");
    print(response.body);
    var data = jsonDecode(response.body);
    print(data);
    phoneNumber = data['data']['phone_number'] ?? " ";
    businessEmail = data['data']['email'] ?? "";
    UserName = data['data']['username'];

    address = data['data']['address'];
    businessName = data['data']['business_name'] ?? "";

    image = data['data']['profile_pic'] ?? "";

    print(image);

    // profileImageUrlss = Url_image + image;
    // print(profileImageUrlss);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString(PROFILE_IMAGE, profileImageUrlss);

    print("fetchedValue is $businessName");
    // print(profileImageUrlss);
    final circleAvatar = CircleAvatar(
      // backgroundImage: NetworkImage(profileImageUrl),
      backgroundImage: NetworkImage(
          "http://192.168.1.35:8000/media/sergio-de-paula-c_GmwfHBDzk-unsplash_fMxB4zq.jpg"),
      radius: 40.0,
    );
    if (this.mounted) {
      setState(() {});
    }
    // getImageUrl();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // void getImageUrl() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   profileImage = prefs.getString(PROFILE_IMAGE) ?? "";
  // }

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
        key: _scaffoldKey,
        child: ListView(
          children: [
            SizedBox(
              height: 250,
              child: UserAccountsDrawerHeader(
                  currentAccountPicture: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              backgroundImage: image != null && image.isNotEmpty
                                  ? NetworkImage(
                                      "http://192.168.1.35:8000/media/sergio-de-paula-c_GmwfHBDzk-unsplash_fMxB4zq.jpg")
                                  : NetworkImage(
                                      "http://192.168.1.35:8000/media/sergio-de-paula-c_GmwfHBDzk-unsplash_fMxB4zq.jpg")),
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
                _scaffoldKey.currentState?.openEndDrawer();
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
                _scaffoldKey.currentState?.openEndDrawer();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ManageProfiles()));
                setState(() {});
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Manage Profile"),
              ),
            ),
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openEndDrawer();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              },
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text("Pivacy Policy"),
            ),
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openEndDrawer();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text("About us"),
              ),
            ),
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openEndDrawer();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs()));
              },
              child: ListTile(
                leading: Icon(Icons.phone_rounded),
                title: Text("Contact Us"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TermsConditions()));
              },
              child: ListTile(
                leading: Image(
                  image: AssetImage("assets/images/t&c.png"),
                  height: 25,
                ),
                title: Text("Terms and conditions"),
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

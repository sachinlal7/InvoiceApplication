import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/dashboardInvoice.dart';
import 'package:invoice_app/Screens/invoice_add.dart';
import 'package:invoice_app/Screens/notifications.dart';
import 'package:invoice_app/Screens/recentAcitivities.dart';
import 'package:invoice_app/Tabs/PendingInvoices.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:invoice_app/subscreens/add_clients.dart';
import 'package:invoice_app/widgets/navBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  void getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      authorizationValue = prefs.getString(ACCESS_KEY) ?? "";

      print("fourth");

      print(authorizationValue);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin ? getData() : "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 85),
              child: Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor: Color_orange,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Notifications())));
                  },
                  icon: Icon(Icons.notifications))
            ],
          ),
          drawer: NavBar(),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.26,
                    width: double.infinity,
                    child: Image(
                      image: AssetImage("assets/images/dashboard.jpg"),
                      fit: BoxFit.fill,
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0350,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddClients()));
                          print("five");
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.20,
                          width: MediaQuery.of(context).size.width * 0.40,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 221, 216, 216),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(
                                    2,
                                    2,
                                  ),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.00000001,
                              ),
                              Image(
                                image: AssetImage(
                                    "assets/images/manage_profile.png"),
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                width: MediaQuery.of(context).size.width * 0.17,
                              ),
                              Text("Managing Clients")
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PendingInvoices()));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.20,
                          width: MediaQuery.of(context).size.width * 0.40,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 221, 216, 216),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(
                                    2,
                                    2,
                                  ),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.00000001,
                              ),
                              Image(
                                image: AssetImage(
                                    "assets/images/order_history.png"),
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                width: MediaQuery.of(context).size.width * 0.17,
                              ),
                              Text("Pending Invoices")
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => dashboardInvoices()));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.20,
                          width: MediaQuery.of(context).size.width * 0.40,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 221, 216, 216),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(
                                    2,
                                    2,
                                  ),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.00000001,
                              ),
                              Image(
                                image: AssetImage(
                                    "assets/images/see_products.png"),
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                width: MediaQuery.of(context).size.width * 0.17,
                              ),
                              Text("Create Invoices")
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecentActivities()));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.20,
                          width: MediaQuery.of(context).size.width * 0.40,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 221, 216, 216),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(
                                    2,
                                    2,
                                  ),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.00000001,
                              ),
                              Image(
                                image:
                                    AssetImage("assets/images/see_status.png"),
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                width: MediaQuery.of(context).size.width * 0.17,
                              ),
                              Text(" Recent Activities")
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:invoice_app/subscreens/changePassword.dart';
import 'package:invoice_app/widgets/navBar.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _notificationsEnabled = false;

  void _toggleNotifications(bool newValue) {
    setState(() {
      _notificationsEnabled = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color_green,
      appBar: AppBar(
          backgroundColor: Color_orange,
          actions: [
            SizedBox(
              width: 50,
            )
          ],
          title: Center(child: Text("Settings"))),
      drawer: NavBar(businessName: businessName.toString(), emailId: emailId),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: 50,
              decoration: BoxDecoration(
                  color: Color_white, borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Notifications"),
                  ),
                  Spacer(),
                  Container(
                    height: 60,
                    width: 100,
                    // color: Color_orange,
                    child: SwitchListTile(
                      value: _notificationsEnabled,
                      onChanged: _toggleNotifications,
                      // title: Text(
                      //   "data",
                      //   style: TextStyle(fontSize: 6),
                      // ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePassword()));
              },
              child: Container(
                width: double.maxFinite,
                height: 50,
                decoration: BoxDecoration(
                    color: Color_white, borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Change Password"),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    )
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

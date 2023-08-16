import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants_colors.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController NewPasswordController = TextEditingController();
  bool _obscureText = true;
  bool _obscureText1 = true;

  Future<void> passwordChange() async {
    final body = {
      "old_password": oldpasswordController.text,
      "new_password": passwordController.text,
      "confirm_new_password": NewPasswordController.text
    };

    final url = "http://192.168.1.31:8000/api/change-password/";
    final uri = Uri.parse(url);
    print("auth value $authorizationValue");

    final response = await http.post(uri,
        body: body, headers: {'Authorization': 'Bearer $authorizationValue'});

    if (response.statusCode == 200) {
      oldpasswordController.text = " ";
      passwordController.text = " ";
      NewPasswordController.text = " ";

      print('password change');
    } else {
      print('password change failed');
    }

    Fluttertoast.showToast(
        msg: "Password changed successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.maxFinite,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.maxFinite,
              color: Color_blue,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: double.maxFinite,
                          color: Colors.white,
                          child: TextFormField(
                            controller: oldpasswordController,
                            decoration: InputDecoration(
                                hintText: " Old password",
                                hintStyle: TextStyle(color: Color_grey),
                                contentPadding:
                                    EdgeInsets.only(bottom: 9, left: 12),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: double.maxFinite,
                          color: Colors.white,
                          child: TextFormField(
                            obscureText: _obscureText,
                            obscuringCharacter: "*",
                            controller: passwordController,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    icon: Icon(Icons.remove_red_eye)),
                                hintText: " passsword",
                                hintStyle: TextStyle(color: Color_grey),
                                contentPadding:
                                    EdgeInsets.only(bottom: 9, left: 12),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: double.maxFinite,
                          color: Colors.white,
                          child: TextFormField(
                            obscureText: _obscureText1,
                            obscuringCharacter: "*",
                            controller: NewPasswordController,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureText1 = !_obscureText1;
                                      });
                                    },
                                    icon: Icon(Icons.remove_red_eye)),
                                hintText: "New password",
                                hintStyle: TextStyle(color: Color_grey),
                                contentPadding:
                                    EdgeInsets.only(bottom: 9, left: 12),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          passwordChange();
                        },
                        child: Container(
                          height: 40,
                          width: double.maxFinite,
                          color: Color_orange,
                          child: Center(
                              child: Text(
                            "Update Password",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

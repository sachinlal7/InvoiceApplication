import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoice_app/constants_colors.dart';

import '../widgets/navBar.dart';
import 'package:http/http.dart' as http;

class ManageProfiles extends StatefulWidget {
  const ManageProfiles({super.key});

  @override
  State<ManageProfiles> createState() => _ManageProfilesState();
}

class _ManageProfilesState extends State<ManageProfiles> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController technicalProductsController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfile();
    technicalProductsController.text = name.toString();
    print("name is $name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color_orange,
        title: Text("Manage Profiles"),
        centerTitle: true,
      ),
      drawer: NavBar(businessName: businessName, emailId: emailId),
      backgroundColor: Color_green,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage("assets/images/person.jpg")),
                ),
                // TextFormField(
                //   decoration: InputDecoration(
                //       filled: true,
                //       hintText: "Business Name",
                //       fillColor: Colors.white),
                // ),
                // SizedBox(
                //   height: 20,
                // ),

                Container(
                  height: 55,
                  width: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: technicalProductsController,
                    decoration: InputDecoration(
                        hintText: name.toString(),
                        labelText: name.toString(),
                        contentPadding: EdgeInsets.only(left: 10),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Business Name";
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  height: 55,
                  width: 370,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: EmailController,
                    decoration: InputDecoration(
                        hintText: "mobsappsolution@gmail.com",
                        contentPadding: EdgeInsets.only(left: 10),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Username";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 55,
                  width: 370,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: NameController,
                    decoration: InputDecoration(
                        hintText: "sachin lal",
                        contentPadding: EdgeInsets.only(left: 10),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 55,
                  width: 370,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                        hintText: "989962223",
                        contentPadding: EdgeInsets.only(left: 10),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 55,
                  width: 370,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                        hintText: "Noida ",
                        contentPadding: EdgeInsets.only(left: 10),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Phone No";
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(
                  height: 80,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.059,
                    width: MediaQuery.of(context).size.height * 0.70,
                    child: Center(
                        child: Text(
                      "Update",
                      style: TextStyle(
                          color: Color_white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    )),
                    decoration: BoxDecoration(
                        color: Color_orange,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void fetchProfile() async {
    final url = "http://192.168.1.31:8000/api/user-updated-profile/";
    final uri = Uri.parse(url);
    final response = await http
        .get(uri, headers: {'Authorization': 'Bearer $authorizationValue'});
    print(response.statusCode);
    print(response.body);
    var data = jsonDecode(response.body);
    print(data);
    var name = data['data']['business_name'];
    print(name);
  }
}

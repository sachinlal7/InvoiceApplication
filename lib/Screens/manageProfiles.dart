import 'package:flutter/material.dart';
import 'package:invoice_app/constants_colors.dart';

import '../widgets/navBar.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color_orange,
        title: Text("Manage Profiles"),
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
                SizedBox(
                  height: 180,
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
                        hintText: "Technical Products",
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
                      "SIGN UP",
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
}

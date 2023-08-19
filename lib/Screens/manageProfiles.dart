import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/dashboard.dart';
import 'package:invoice_app/constants_colors.dart';
import '../widgets/navBar.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
  TextEditingController imageController = TextEditingController();

  XFile? _image;
  String message = '';
  bool loading = false;
  bool showSpinner = false;
  String fetchedValue = "";

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<void> uploadImage() async {
    if (_image == null) {
      setState(() {
        message = 'No image selected.';
      });
      return;
    }

    // setState(() {
    //   loading = true;
    // });

    try {
      var headers = {
        "Authorization":
            "Bearer $authorizationValue", // Replace with actual token
        "Accept": "application/json",
      };
      print("image value $authorizationValue");

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('http://192.168.1.31:8000/api/user-updated-profile/'),
      );

      request.headers.addAll(headers);

      request.files.add(await http.MultipartFile.fromPath(
        'profile_pic', // Replace with your server's file field name
        _image!.path,
      ));

      var response = await request.send();
      print(response.statusCode);

      if (response.statusCode == 200) {
        setState(() {
          message = 'Image uploaded successfully.';
        });
      } else {
        setState(() {
          message =
              'Image upload failed with status code: ${response.statusCode}';
        });
      }
    } catch (error) {
      setState(() {
        message = 'Error uploading image: $error';
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfile();

    technicalProductsController = TextEditingController(text: businessName);
    EmailController = TextEditingController(text: businessEmail);
    NameController = TextEditingController(text: UserName);
    phoneNumberController = TextEditingController(text: phoneNumber);
    addressController = TextEditingController(text: address);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color_orange,
          title: Text("Manage Profiles"),
          centerTitle: true,
        ),
        drawer: NavBar(businessName: businessName.toString(), emailId: emailId),
        backgroundColor: Color_green,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CircleAvatar(
                            radius: 70,
                            child: ClipOval(
                              child: SizedBox(
                                width: 140, // Double the radius for the width
                                height: 140, // Double the radius for the height
                                child: _image != null
                                    ? Image.file(
                                        File(_image!.path),
                                        height: 200,
                                      )
                                    : Container(),
                              ),
                            ),
                          )),
                      Positioned(
                          bottom: 15,
                          right: 15,
                          child: GestureDetector(
                            onTap: () {
                              pickImage();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.add_a_photo),
                            ),
                          ))
                    ],
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
                          hintText: businessName,
                          contentPadding: EdgeInsets.only(left: 10),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
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
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
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
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
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
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Number";
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
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
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
                    onTap: () {
                      updateProfile().then((value) => fetchProfile());
                    },
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
    UserName = data['data']['username'];
    businessName = data['data']['business_name'];
    businessEmail = data['data']['email'];

    phoneNumber = data['data']['phone_number'];
    address = data['data']['address'];
    image = data['data']['profile_pic'];
    print("fetchedValue is $businessName");
  }

  // Future<void> updateProfile() async {
  //   final body = {
  //     "business_name": technicalProductsController.text,
  //     "email": EmailController.text,
  //     "username": NameController.text,
  //     "phone_number": phoneNumberController.text.toString(),
  //     "address": addressController.text
  //   };

  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // var customerIdValue = prefs.get(getUser);
  //   // print(" get user id $CustKey");

  //   final url = "http://192.168.1.31:8000/api/user-updated-profile/";
  //   final uri = Uri.parse(url);
  //   print(authorizationValue);
  //   print(customerIdValue);
  //   final response = await http.put(uri,
  //       body: body, headers: {'Authorization': 'Bearer $authorizationValue'});

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     print('successfully updated');
  //   } else {
  //     print('update failed');
  //   }
  //   if (mounted) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => DashBoard()));
  //   }
  // }

  Future<void> updateProfile() async {
    setState(() {
      // showSpinner = true;
    });

    if (_image == null) {
      setState(() {
        message = 'No image selected.';
      });
      return;
    }
    setState(() {
      loading = true;
    });

    try {
      var headers = {
        "Authorization":
            "Bearer $authorizationValue", // Replace with actual token
        "Accept": "application/json",
      };
      print(authorizationValue);

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('http://192.168.1.31:8000/api/user-updated-profile/'),
      );

      request.headers.addAll(headers);
      final fields = {
        "business_name": technicalProductsController.text,
        "email": EmailController.text,
        "username": NameController.text,
        "phone_number": phoneNumberController.text,
        "address": addressController.text,
      };
      request.files.add(await http.MultipartFile.fromPath(
        'profile_pic', // Replace with your server's file field name
        _image!.path,
      ));
      var response = await request.send();
      print(response.statusCode);

      if (response.statusCode == 200) {
        setState(() {
          showSpinner = false;
          uploadedImageUrl = image;
          message = 'Profile updated successfully.';
          print(message);
        });
      } else {
        setState(() {
          message =
              'Profile upload failed with status code: ${response.statusCode}';
        });
      }
    } catch (error) {
      setState(() {
        message = 'Error uploading image: $error';
      });
    }
  }
}

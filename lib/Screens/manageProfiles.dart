import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/dashboard.dart';
import 'package:invoice_app/constants_colors.dart';
import '../widgets/navBar.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
            "Bearer $authorizationValues", // Replace with actual token
        "Accept": "application/json",
      };

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(Base_URL + updateProfileApi),
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

  String profileImageUrl = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchProfile();

    technicalProductsController = TextEditingController(text: businessName);
    EmailController = TextEditingController(text: businessEmail);
    NameController = TextEditingController(text: UserName);
    phoneNumberController = TextEditingController(text: phoneNumber.toString());
    addressController = TextEditingController(text: address);
  }

  @override
  Widget build(BuildContext context) {
    // print("profile image $profileImage");
    debugPrint("profile build");
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
                        child: _image != null
                            ? CircleAvatar(
                                radius: 70,
                                backgroundImage: FileImage(File(_image!.path)),
                              )
                            : CircleAvatar(
                                radius: 70,
                                backgroundImage: image != null &&
                                        image.isNotEmpty
                                    ? NetworkImage(profileImageUrlss)
                                    : NetworkImage(
                                        "http://192.168.1.35:8000/media/sergio-de-paula-c_GmwfHBDzk-unsplash_fMxB4zq.jpg")),
                      ),
                      // )),
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
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                          counterText: "",
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
                      // updateProfile().then((value) => fetchProfile());
                      updateProfile();
                      Navigator.pushReplacement(
                          context,
                          (MaterialPageRoute(
                              builder: (context) => DashBoard())));

                      // setState(() {});
                      // Navigator.pop(context);
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

  Future<void> updateProfile() async {
    print("authorizationValues4 $authorizationValues");
    setState(() {
      loading = true;
    });

    // try {
    var headers = {
      "Authorization": "Bearer $authorizationValues",
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(Base_URL + updateProfileApi),
    );

    request.headers.addAll(headers);
    print("authorizationValues3 $authorizationValues");

    final fields = {
      "business_name": technicalProductsController.text,
      "email": EmailController.text,
      "username": NameController.text,
      "phone_number": phoneNumberController.text.toString(),
      "address": addressController.text,
    };

    request.fields.addAll(fields);

    if (_image != null) {
      print("authorizationValues2 $authorizationValues");
      request.files.add(await http.MultipartFile.fromPath(
        'profile_pic',
        _image!.path,
      ));
    }

    var response = await request.send();
    print(request.headers);
    print(request.fields);
    print(response.statusCode);
    print("authorizationValues1 $authorizationValues");

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("authorizationValues10 $authorizationValues");
      setState(() {
        loading = false;
        // uploadedImageUrl = image;
        message = 'Profile updated successfully.';
        print(message);
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else {
      setState(() {
        message =
            'Profile update failed with status code: ${response.statusCode}';
        print(message);
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }
  }
}

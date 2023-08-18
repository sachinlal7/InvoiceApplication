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

  File? image;

  final picker = ImagePicker();
  bool showSpinner = false;

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(image!.path);
      setState(() {});
    } else {
      print("no image selected");
    }

    // setState(() {
    //   image = img;
    // });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> uploadImage() async {
    var uri = Uri.parse("uri");
  }

  String fetchedValue = "";
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
                                child: image != null
                                    ? Image.file(
                                        File(image!.path).absolute,
                                        fit: BoxFit.cover,
                                      )
                                    : Image(
                                        image: NetworkImage(
                                            "http://192.168.1.31:8000/media/Screenshot_1.png"),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          )),
                      Positioned(
                          bottom: 15,
                          right: 15,
                          child: GestureDetector(
                            onTap: () {
                              myAlert();
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
                      updateProfile();
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
    businessName = data['data']['business_name'];
    businessEmail = data['data']['email'];
    UserName = data['data']['username'];
    phoneNumber = data['data']['phone_number'].toString();
    address = data['data']['address'];
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
      showSpinner = true;
    });

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    final uri = Uri.parse("http://192.168.1.31:8000/api/user-updated-profile/");

    final request = http.MultipartRequest('PUT', uri)
      ..headers['Authorization'] = 'Bearer $authorizationValue';
    final fields = {
      "business_name": technicalProductsController.text,
      "email": EmailController.text,
      "username": NameController.text,
      "phone_number": phoneNumberController.text.toString(),
      "address": addressController.text,
    };
    var multiport = new http.MultipartFile('profile_pic', stream, length);

    request.files.add(multiport);
    var response = await request.send();

    if (image != null) {
      var stream = new http.ByteStream(image!.openRead());
      stream.cast();
      var length = await image!.length();
      final uri =
          Uri.parse("http://192.168.1.31:8000/api/user-updated-profile/");
      final request = http.MultipartRequest('PUT', uri)
        ..headers['Authorization'] = 'Bearer $authorizationValue';
      final fields = {
        "business_name": technicalProductsController.text,
        "email": EmailController.text,
        "username": NameController.text,
        "phone_number": phoneNumberController.text.toString(),
        "address": addressController.text,
      };

      var multiport = new http.MultipartFile('profile_pic', stream, length);

      request.files.add(multiport);
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Successfully updated');
      } else {
        print('Update failed');
      }

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashBoard()),
        );
      }
    } catch (error) {
      print('Error updating profile: $error');
    }
  }
}

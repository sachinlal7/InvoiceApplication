import 'package:flutter/material.dart';

import '../Screens/dashboardInvoice.dart';

class BusinessInfo extends StatefulWidget {
  const BusinessInfo({super.key});

  @override
  State<BusinessInfo> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 226, 226),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 69, 150, 216),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "Business Details",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => dashboardInvoices()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        actions: [
          SizedBox(
            width: 25,
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Container(
                height: 100,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Container(
                        height: 32,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 121, 118, 118),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Business Logo",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey,
                      size: 60,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Container(
                height: 120,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Business Name",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                    SizedBox(
                      height: 25,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Business Owner Name",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Business Number",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Container(
                height: 130,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Address Line 1",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                    SizedBox(
                      height: 25,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Address Line 2",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Address Line 3",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Container(
                height: 160,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Email",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                    SizedBox(
                      height: 25,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Phone",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Mobile",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Website",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
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

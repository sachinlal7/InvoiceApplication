import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice_app/Screens/dashboard.dart';
import 'package:invoice_app/Tabs/previewInvoice.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:invoice_app/constants_colors.dart';

import '../Tabs/dropdown.dart';

import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class InvoiceAdd extends StatefulWidget {
  final String? InvoiceId;
  final isEdit;
  const InvoiceAdd({super.key, this.isEdit, this.InvoiceId});

  @override
  State<InvoiceAdd> createState() => _InvoiceAddState();
}

class _InvoiceAddState extends State<InvoiceAdd>
    with SingleTickerProviderStateMixin {
  TextEditingController clientController = TextEditingController();
  TextEditingController ProductNameController = TextEditingController();
  TextEditingController QuantityController = TextEditingController();
  TextEditingController UnitPriceController = TextEditingController();
  TextEditingController TotalPriceController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  TextEditingController FaxNumberController = TextEditingController();
  TextEditingController PaymentDateContoller = TextEditingController();
  TextEditingController DueAmountController = TextEditingController();
  TextEditingController PaidAmountController = TextEditingController();
  TextEditingController PaymentStatusController = TextEditingController();
  TextEditingController DateController = TextEditingController();
  SingleValueDropDownController singleValueController =
      SingleValueDropDownController();

  DateTime currentDate = DateTime.now();
  DateTime currentDate1 = DateTime.now();
  DateTime currentDate2 = DateTime.now();

  String _selectedValue = '';
  XFile? _image;
  bool dataFetched = false;
  List<String> customerNames = [];
  List<String> customerIDs = [];
  Map<String, String> customerNamesWithIds = {};
  String selectedCustomerId = '';
  late TabController _tabController;
  bool isEdit = false;

  Future<void> fetchCustomerNames() async {
    final url = "http://192.168.1.31:8000/api/customer-list/";
    final response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer $authorizationValue'});
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> customerList = data['data'];

      for (var customer in customerList) {
        customerNames.add(customer['name']);
        customerIDs.add(customer['id'].toString());
      }
      print("Fetched Customer Names: $customerNames");
      print("Fetched Customer IDs: $customerIDs");

      setState(() {});
    } else {
      throw Exception('Failed to fetch customer names');
    }
  }

  void datePicker(context) async {
    DateTime? userSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (userSelectedDate == null) {
      return;
    } else {
      setState(() {
        currentDate = userSelectedDate;
        selectedDate = DateFormat('yyyy-MM-dd').format(currentDate);
      });
    }
  }

  void datePicker1(context) async {
    DateTime? userSelectedDate1 = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));
    if (userSelectedDate1 == null) {
      return;
    } else {
      setState(() {
        currentDate1 = userSelectedDate1;
        selectedDate1 = DateFormat('yyyy-MM-dd').format(currentDate);
      });
    }
  }

  void datePicker2(context) async {
    DateTime? userSelectedDate2 = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));
    if (userSelectedDate2 == null) {
      return;
    } else {
      setState(() {
        currentDate2 = userSelectedDate2;
        selectedDate2 = DateFormat('yyyy-MM-dd').format(currentDate);
      });
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<void> fecthInvoiceID() async {
    await EditInvoiceDetails();
    setState(() {
      dataFetched = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _selectedValue = customerNames.isNotEmpty ? customerNames[0] : '';
    fetchCustomerNames();
    fecthInvoiceID();
    setState(() {});

    if (widget.isEdit) {
      ProductNameController = TextEditingController(text: InvoiceProductName);
      QuantityController = TextEditingController(text: InvoiceQuantity);
      UnitPriceController = TextEditingController(text: InvoiceUnitPrice);
      TotalPriceController = TextEditingController(text: InvoiceTotalPrice);
      AddressController = TextEditingController(text: InvoiceAddress);
      FaxNumberController = TextEditingController(text: InvoiceFax);
      PaidAmountController = TextEditingController(text: InvoicePaidAmount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 69, 150, 216),
          title: Center(
            child: Text(
              "Invoices",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashBoard()));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search_outlined,
                  size: 28,
                  color: Colors.white,
                ))
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                text: widget.isEdit ? "EDIT" : "NEW",
              ),
              Tab(text: 'PREVIEW'),
              Tab(text: 'HISTORY')
            ],
            unselectedLabelColor: Colors.white,
            labelColor: Colors.white,
            indicatorColor: Color_orange,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: double.maxFinite,
                  color: Color.fromARGB(255, 226, 226, 226),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text("INV00001"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              pickImage();
                            },
                            child: _image != null
                                ? CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        FileImage(File(_image!.path)),
                                  )
                                : SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: AssetImage(
                                          "assets/images/order_history.png",
                                        )),
                                  ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Date"),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text("Due Date"),
                                ],
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          datePicker(context);
                                          // showDatePicker(
                                          //     context: context,
                                          //     initialDate: DateTime.now(),
                                          //     firstDate: DateTime(1980),
                                          //     lastDate: DateTime(2025));
                                        },
                                        child: Container(
                                            height: 30,
                                            width: 120,
                                            color: Color_white,
                                            child: Center(
                                                child: Text(
                                                    "${currentDate.year}-${currentDate.month}-${currentDate.day}"))),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          datePicker1(context);
                                        },
                                        child: Container(
                                            height: 30,
                                            width: 120,
                                            color: Color_white,
                                            child: Center(
                                                child: Text(
                                                    "${currentDate1.year}-${currentDate1.month}-${currentDate1.day}"))),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.67,
                    width: double.maxFinite,
                    color: Color.fromARGB(255, 226, 226, 226),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Client"),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                      height: 35,
                                      width: 180,
                                      color: Colors.white,
                                      child: DropDownTextField(
                                        // initialValue: "name4",
                                        // controller: singleValueController,
                                        // clearOption: true,
                                        // enableSearch: true,
                                        // dropdownColor: Colors.green,
                                        // searchDecoration: const InputDecoration(
                                        //     hintText: "Select Client"),
                                        validator: (value) {
                                          if (value == null) {
                                            return "Required field";
                                          } else {
                                            return null;
                                          }
                                        },
                                        dropDownItemCount: customerNames.length,

                                        dropDownList: customerNames.map((name) {
                                          return DropDownValueModel(
                                              name: name, value: name);
                                        }).toList(),
                                        onChanged: (val) {
                                          changedValue = val.name;
                                          print(changedValue);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Product Name"),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Container(
                                      height: 35,
                                      width: 180,
                                      color: Colors.white,
                                      child: TextFormField(
                                        controller: ProductNameController,
                                        onChanged: (value) {
                                          productName = value;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Product",
                                            contentPadding: EdgeInsets.only(
                                                bottom: 9, left: 5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Quantity"),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                      height: 35,
                                      width: 180,
                                      color: Colors.white,
                                      child: TextFormField(
                                        controller: QuantityController,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          quantity = value;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "1",
                                            contentPadding: EdgeInsets.only(
                                                bottom: 9, left: 5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Unit Price"),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                      height: 35,
                                      width: 180,
                                      color: Colors.white,
                                      child: TextFormField(
                                        controller: UnitPriceController,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d+\.?\d{0,2}'))
                                        ],
                                        onChanged: (value) {
                                          unitPrice = value;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "500",
                                            contentPadding: EdgeInsets.only(
                                                bottom: 9, left: 5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Price"),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                      height: 35,
                                      width: 180,
                                      color: Colors.white,
                                      child: TextFormField(
                                        controller: TotalPriceController,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d+\.?\d{0,2}'))
                                        ],
                                        onChanged: (value) {
                                          totalPrice = value;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "2500",
                                            contentPadding: EdgeInsets.only(
                                                bottom: 9, left: 5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Address"),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                      height: 35,
                                      width: 180,
                                      color: Colors.white,
                                      child: TextFormField(
                                        controller: AddressController,
                                        onChanged: (value) {
                                          billAddress = value;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Noida",
                                            contentPadding: EdgeInsets.only(
                                                bottom: 9, left: 5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Fax Number"),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                      height: 35,
                                      width: 180,
                                      color: Colors.white,
                                      child: TextFormField(
                                        controller: FaxNumberController,
                                        onChanged: (value) {
                                          faxNumber = value;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "fax",
                                            contentPadding: EdgeInsets.only(
                                                bottom: 9, left: 5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Payment Date"),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        datePicker2(context);
                                      },
                                      child: Container(
                                          padding:
                                              EdgeInsets.only(top: 5, left: 5),
                                          height: 35,
                                          width: 180,
                                          color: Colors.white,
                                          child: Text(
                                            "${currentDate2.year}-${currentDate2.month}-${currentDate2.day}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400),
                                          )
                                          // TextFormField(
                                          //   controller: PaymentDateContoller,
                                          //   onChanged: (value) {
                                          //     paymentDate = value;
                                          //   },
                                          //   decoration: InputDecoration(
                                          //       hintText: "pay date",
                                          //       contentPadding:
                                          //           EdgeInsets.only(bottom: 9),
                                          //       border: OutlineInputBorder(
                                          //           borderSide: BorderSide.none)),
                                          // ),
                                          ),
                                    )
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text("Due Amount"),
                              //       SizedBox(
                              //         width: 50,
                              //       ),
                              //       Container(
                              //         height: 35,
                              //         width: 180,
                              //         color: Colors.white,
                              //         child: TextFormField(
                              //           controller: DueAmountController,
                              //           keyboardType:
                              //               TextInputType.numberWithOptions(
                              //                   decimal: true),
                              //           inputFormatters: [
                              //             FilteringTextInputFormatter.allow(
                              //                 RegExp(r'^\d+\.?\d{0,2}'))
                              //           ],
                              //           onChanged: (value) {
                              //             dueAmount = value;
                              //           },
                              //           decoration: InputDecoration(
                              //               hintText: "1000",
                              //               contentPadding: EdgeInsets.only(
                              //                   bottom: 9, left: 5),
                              //               border: OutlineInputBorder(
                              //                   borderSide: BorderSide.none)),
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Paid Amount"),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                      height: 35,
                                      width: 180,
                                      color: Colors.white,
                                      child: TextFormField(
                                        controller: PaidAmountController,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d+\.?\d{0,2}'))
                                        ],
                                        onChanged: (value) {
                                          paidAmount = value;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "1500",
                                            contentPadding: EdgeInsets.only(
                                                bottom: 9, left: 5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text("Payment Status"),
                              //       SizedBox(
                              //         width: 28,
                              //       ),
                              //       Container(
                              //         height: 35,
                              //         width: 180,
                              //         color: Colors.white,
                              //         child: TextFormField(
                              //           controller: PaymentStatusController,
                              //           onChanged: (value) {
                              //             paymentStatus = value;
                              //           },
                              //           decoration: InputDecoration(
                              //               hintText: "status",
                              //               contentPadding: EdgeInsets.only(
                              //                   bottom: 9, left: 5),
                              //               border: OutlineInputBorder(
                              //                   borderSide: BorderSide.none)),
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      print("object");
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             PreviewInvoice(
                                      //               selectedValue: changedValue,
                                      //             )));
                                      isEdit = true;
                                      _tabController.animateTo(1);
                                    });
                                    // fetchCustomerNames();
                                  },
                                  child: Container(
                                    height: 35,
                                    width: double.maxFinite,
                                    color: Colors.deepOrange,
                                    child: Center(
                                        child: Text(
                                      "Preview",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            PreviewInvoice(),
            PreviewInvoice()
          ],
        ),
      ),
    ));
  }

  Future<void> EditInvoiceDetails() async {
    final InvoiceId = widget.InvoiceId;

    final url = "http://192.168.1.31:8000/api/invoice-list/";
    final uri = Uri.parse(url);

    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer $authorizationValue',
    });

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      for (final InvoiceData in jsonData['data']) {
        final id = InvoiceData['id'].toString();

        if (id == InvoiceData) {
          final clientName = InvoiceData['client_name'] as String;
          final ClientAddress = InvoiceData['address'] as String;
          final ProductName = InvoiceData['product_name'] as String;
          final Quantity = InvoiceData['quantity'] as String;
          final FAXnumber = InvoiceData['fax_number'] as String;
          final UnitPrice = InvoiceData['unit_price'] as String;
          final TotalPrice = InvoiceData['total_price'] as String;
          final PaidAmount = InvoiceData['paid_amount'] as String;

          print("name of client $clientName");

          // Now you have the clientName for the given clientId
          setState(() {
            InvoiceUserName = clientName;
            InvoiceProductName = ProductName;
            InvoiceQuantity = Quantity;
            InvoiceUnitPrice = UnitPrice;
            InvoiceTotalPrice = TotalPrice;
            InvoiceAddress = ClientAddress;
            InvoiceFax = FAXnumber;
            InvoicePaidAmount = PaidAmount;

            print("value fetched $InvoiceUserName");
          });
          break; // No need to continue searching
        }
      }
    } else {
      // Handle error case
    }
    setState(() {});
  }
}

// import 'package:flutter/material.dart';
// import 'package:invoice_app/constants_colors.dart';
// import 'package:dropdown_textfield/dropdown_textfield.dart';

// import 'previewInvoice.dart';

// class NewInvoice extends StatefulWidget {
//   const NewInvoice({super.key});

//   @override
//   State<NewInvoice> createState() => _NewInvoiceState();
// }

// class _NewInvoiceState extends State<NewInvoice>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   TextEditingController clientController = TextEditingController();
//   TextEditingController ProductNameController = TextEditingController();
//   TextEditingController QuantityController = TextEditingController();
//   TextEditingController UnitPriceController = TextEditingController();
//   TextEditingController TotalPriceController = TextEditingController();
//   TextEditingController AddressController = TextEditingController();
//   TextEditingController FaxNumberController = TextEditingController();
//   TextEditingController PaymentDateContoller = TextEditingController();
//   TextEditingController DueAmountController = TextEditingController();
//   TextEditingController PaidAmountController = TextEditingController();
//   TextEditingController PaymentStatusController = TextEditingController();

//   DateTime currentDate = DateTime.now();
//   DateTime currentDate1 = DateTime.now();
//   String? selectedDate;
//   String? selectedDate1;
//   String _selectedValue = '';

//   FocusNode searchFocusNode = FocusNode();
//   FocusNode textFieldFocusNode = FocusNode();
//   // List<DropDownValueModel> dropDownListData = [
//   //   DropDownValueModel(name: 'Paid', value: "value"),
//   //   DropDownValueModel(name: 'Unpaid ', value: "value"),
//   // ];

//   // List<DropDownValueModel> DropdownItem = const [
//   //   DropDownValueModel(name: 'Client 1', value: "value"),
//   //   DropDownValueModel(
//   //       name: 'Client 2',
//   //       value: "value2",
//   //       toolTipMsg:
//   //           "DropDownButton is a widget that we can use to select one unique value from a set of values"),
//   //   DropDownValueModel(name: 'Client 3', value: "value3"),
//   // ];

//   void datePicker(context) async {
//     DateTime? userSelectedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(1980),
//         lastDate: DateTime(2025));
//     if (userSelectedDate == null) {
//       return;
//     } else {
//       setState(() {
//         currentDate = userSelectedDate;
//         selectedDate =
//             "${currentDate.year}/${currentDate.month}/${currentDate.day}";
//       });
//     }
//   }

//   void datePicker1(context) async {
//     DateTime? userSelectedDate1 = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(1980),
//         lastDate: DateTime(2025));
//     if (userSelectedDate1 == null) {
//       return;
//     } else {
//       setState(() {
//         currentDate1 = userSelectedDate1;
//         selectedDate1 =
//             "${currentDate1.year}/${currentDate1.month}/${currentDate1.day}";
//       });
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         body: Column(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height * 0.18,
//               width: double.maxFinite,
//               color: Color.fromARGB(255, 226, 226, 226),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text("INV00001"),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       SizedBox(
//                         width: 25,
//                       ),
//                       Image(
//                         image: AssetImage("assets/images/order_history.png"),
//                         height: 80,
//                       ),
//                       SizedBox(
//                         width: 25,
//                       ),
//                       Row(
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Date"),
//                               SizedBox(
//                                 height: 15,
//                               ),
//                               Text("Due Date"),
//                             ],
//                           ),
//                           SizedBox(
//                             width: 40,
//                           ),
//                           Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       datePicker(context);
//                                       // showDatePicker(
//                                       //     context: context,
//                                       //     initialDate: DateTime.now(),
//                                       //     firstDate: DateTime(1980),
//                                       //     lastDate: DateTime(2025));
//                                     },
//                                     child: Container(
//                                         height: 30,
//                                         width: 100,
//                                         color: Color_white,
//                                         child: Center(
//                                             child: Text(
//                                                 "${currentDate.year}/${currentDate.month}/${currentDate.day}"))),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 15,
//                               ),
//                               Row(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       datePicker1(context);
//                                     },
//                                     child: Container(
//                                         height: 30,
//                                         width: 100,
//                                         color: Color_white,
//                                         child: Center(
//                                             child: Text(
//                                                 "${currentDate1.year}/${currentDate1.month}/${currentDate1.day}"))),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )
//                         ],
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.67,
//                 width: double.maxFinite,
//                 color: Color.fromARGB(255, 226, 226, 226),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text("Client"),
//                               SizedBox(
//                                 width: 50,
//                               ),
//                               Container(
//                                 height: 35,
//                                 width: 200,
//                                 color: Colors.white,
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text("Product Name"),
//                               SizedBox(
//                                 width: 50,
//                               ),
//                               Container(
//                                 height: 35,
//                                 width: 200,
//                                 color: Colors.white,
//                                 child: TextFormField(
//                                   controller: ProductNameController,
//                                   onChanged: (value) {
//                                     productName = value;
//                                   },
//                                   decoration: InputDecoration(
//                                       hintText: "Product",
//                                       contentPadding:
//                                           EdgeInsets.only(bottom: 9),
//                                       border: OutlineInputBorder(
//                                           borderSide: BorderSide.none)),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text("Quantity"),
//                               SizedBox(
//                                 width: 50,
//                               ),
//                               Container(
//                                 height: 35,
//                                 width: 200,
//                                 color: Colors.white,
//                                 child: TextFormField(
//                                   controller: QuantityController,
//                                   decoration: InputDecoration(
//                                       hintText: "1",
//                                       contentPadding:
//                                           EdgeInsets.only(bottom: 9),
//                                       border: OutlineInputBorder(
//                                           borderSide: BorderSide.none)),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text("Unit Price"),
//                               SizedBox(
//                                 width: 50,
//                               ),
//                               Container(
//                                 height: 35,
//                                 width: 200,
//                                 color: Colors.white,
//                                 child: TextFormField(
//                                   controller: UnitPriceController,
//                                   decoration: InputDecoration(
//                                       hintText: "500",
//                                       contentPadding:
//                                           EdgeInsets.only(bottom: 9),
//                                       border: OutlineInputBorder(
//                                           borderSide: BorderSide.none)),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text("Total Price"),
//                               SizedBox(
//                                 width: 50,
//                               ),
//                               Container(
//                                 height: 35,
//                                 width: 200,
//                                 color: Colors.white,
//                                 child: TextFormField(
//                                   controller: TotalPriceController,
//                                   decoration: InputDecoration(
//                                       hintText: "2500",
//                                       contentPadding:
//                                           EdgeInsets.only(bottom: 9),
//                                       border: OutlineInputBorder(
//                                           borderSide: BorderSide.none)),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text("Address"),
//                               SizedBox(
//                                 width: 50,
//                               ),
//                               Container(
//                                 height: 35,
//                                 width: 200,
//                                 color: Colors.white,
//                                 child: TextFormField(
//                                   controller: AddressController,
//                                   decoration: InputDecoration(
//                                       hintText: "Noida",
//                                       contentPadding:
//                                           EdgeInsets.only(bottom: 9),
//                                       border: OutlineInputBorder(
//                                           borderSide: BorderSide.none)),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text("Fax Number"),
//                               SizedBox(
//                                 width: 50,
//                               ),
//                               Container(
//                                 height: 35,
//                                 width: 200,
//                                 color: Colors.white,
//                                 child: TextFormField(
//                                   controller: FaxNumberController,
//                                   decoration: InputDecoration(
//                                       hintText: "fax",
//                                       contentPadding:
//                                           EdgeInsets.only(bottom: 9),
//                                       border: OutlineInputBorder(
//                                           borderSide: BorderSide.none)),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text("Payment Date"),
//                               SizedBox(
//                                 width: 50,
//                               ),
//                               Container(
//                                 height: 35,
//                                 width: 200,
//                                 color: Colors.white,
//                                 child: TextFormField(
//                                   controller: PaymentDateContoller,
//                                   decoration: InputDecoration(
//                                       hintText: "pay date",
//                                       contentPadding:
//                                           EdgeInsets.only(bottom: 9),
//                                       border: OutlineInputBorder(
//                                           borderSide: BorderSide.none)),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text("Due Amount"),
//                               SizedBox(
//                                 width: 50,
//                               ),
//                               Container(
//                                 height: 35,
//                                 width: 200,
//                                 color: Colors.white,
//                                 child: TextFormField(
//                                   controller: DueAmountController,
//                                   decoration: InputDecoration(
//                                       hintText: "1000",
//                                       contentPadding:
//                                           EdgeInsets.only(bottom: 9),
//                                       border: OutlineInputBorder(
//                                           borderSide: BorderSide.none)),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text("Paid Amount"),
//                               SizedBox(
//                                 width: 50,
//                               ),
//                               Container(
//                                 height: 35,
//                                 width: 200,
//                                 color: Colors.white,
//                                 child: TextFormField(
//                                   controller: PaidAmountController,
//                                   decoration: InputDecoration(
//                                       hintText: "1500",
//                                       contentPadding:
//                                           EdgeInsets.only(bottom: 9),
//                                       border: OutlineInputBorder(
//                                           borderSide: BorderSide.none)),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text("Payment Status"),
//                               SizedBox(
//                                 width: 38,
//                               ),
//                               Container(
//                                 height: 35,
//                                 width: 200,
//                                 color: Colors.white,
//                                 child: TextFormField(
//                                   controller: PaidAmountController,
//                                   decoration: InputDecoration(
//                                       hintText: "status",
//                                       contentPadding:
//                                           EdgeInsets.only(bottom: 9),
//                                       border: OutlineInputBorder(
//                                           borderSide: BorderSide.none)),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 20),
//                           child: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 print("object");
//                                 _tabController.animateTo(2);
//                               });
//                             },
//                             child: Container(
//                               height: 35,
//                               width: double.maxFinite,
//                               color: Colors.deepOrange,
//                               child: Center(
//                                   child: Text(
//                                 "Preview",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 18),
//                               )),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

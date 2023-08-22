// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:invoice_app/constants_colors.dart';
// import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:http/http.dart' as http;
// import '../model/custModels.dart';
// import '../model/custName_mdoels.dart';

// class NewInvoice extends StatefulWidget {
//   const NewInvoice({super.key});

//   @override
//   State<NewInvoice> createState() => _NewInvoiceState();
// }

// class _NewInvoiceState extends State<NewInvoice> {
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

//   List data = [];

//   int _value = 1;

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

//   // void datePicker(context) async {
//   //   DateTime? userSelectedDate = await showDatePicker(
//   //       context: context,
//   //       initialDate: DateTime.now(),
//   //       firstDate: DateTime(1980),
//   //       lastDate: DateTime(2025));
//   //   if (userSelectedDate == null) {
//   //     return;
//   //   } else {
//   //     setState(() {
//   //       currentDate = userSelectedDate;
//   //       selectedDate =
//   //           "${currentDate.year}/${currentDate.month}/${currentDate.day}";
//   //     });
//   //   }
//   // }

//   // void datePicker1(context) async {
//   //   DateTime? userSelectedDate1 = await showDatePicker(
//   //       context: context,
//   //       initialDate: DateTime.now(),
//   //       firstDate: DateTime(1980),
//   //       lastDate: DateTime(2025));
//   //   if (userSelectedDate1 == null) {
//   //     return;
//   //   } else {
//   //     setState(() {
//   //       currentDate1 = userSelectedDate1;
//   //       selectedDate1 =
//   //           "${currentDate1.year}/${currentDate1.month}/${currentDate1.day}";
//   //     });
//   //   }
//   // }

//   getclientName() async {
//     try {
//       // final url = Base_URL + custlistendpoint;
//       final url = "http://192.168.1.31:8000/api/customer-list/";
//       final uri = Uri.parse(url);
//       final response = await http
//           .get(uri, headers: {'Authorization': 'Bearer $authorizationValue'});
//       final data = jsonDecode(response.body) as List;
//       print("status code ${response.statusCode}");

//       if (response.statusCode == 200) {
//       setState(() {
        
//       });
//       }
//     } catch (e) {
//       print(e.toString());
//     }
    
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("drop build");
//     getclientName();
//     return Scaffold(
//         body: Center(
//             child: DropdownButton(
//       items: data.map((e) {
//         return DropdownMenuItem(
//           child: Text(e['name']),
//           value: e["name"],
//         )
//       }),
//       value: _value,
//       onChanged: (val) {
//         _value = val as int;
//       },
//     )));
//   }
// }

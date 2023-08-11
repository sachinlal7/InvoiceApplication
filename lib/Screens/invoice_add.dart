import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/dashboard.dart';
import 'package:invoice_app/Tabs/editInvoice.dart';
import 'package:invoice_app/Tabs/previewInvoice.dart';

import '../Tabs/dropdown.dart';
import '../constants_colors.dart';

class InvoiceAdd extends StatefulWidget {
  const InvoiceAdd({super.key});

  @override
  State<InvoiceAdd> createState() => _InvoiceAddState();
}

class _InvoiceAddState extends State<InvoiceAdd> {
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
            tabs: [
              Tab(
                text: 'EDIT',
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
          children: [NewInvoice(), PreviewInvoice(), TestPage()],
        ),
      ),
    ));
  }
}

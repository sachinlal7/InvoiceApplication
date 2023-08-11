import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/createInvoice.dart';
import 'package:invoice_app/Tabs/editTabBar.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:invoice_app/subscreens/invoiceList.dart';

import 'invoice_add.dart';

class dashboardInvoices extends StatefulWidget {
  const dashboardInvoices({super.key});

  @override
  State<dashboardInvoices> createState() => _dashboardInvoicesState();
}

class _dashboardInvoicesState extends State<dashboardInvoices> {
  void _createNewInvoice() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => InvoiceAdd()));
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
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
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
                  text: 'All',
                ),
                Tab(text: 'Outstanding'),
                Tab(text: 'Paid')
              ],
              unselectedLabelColor: Colors.white,
              labelColor: Colors.white,
              indicatorColor: Color_orange,
            ),
          ),
          body: TabBarView(
            children: [
              InvoiceList(),
              Center(child: Text('Outstanding Tab Content')),
              Center(child: Text('Paid Tab Content')),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _createNewInvoice,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}

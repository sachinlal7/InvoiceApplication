import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/createInvoice.dart';
import 'package:invoice_app/Screens/dashboard.dart';
import 'package:invoice_app/Tabs/editTabBar.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:invoice_app/subscreens/invoiceList.dart';

import '../subscreens/outstandingInvoices.dart';
import '../subscreens/paidInvoices.dart';
import 'invoice_add.dart';

class dashboardInvoices extends StatefulWidget {
  const dashboardInvoices({super.key});

  @override
  State<dashboardInvoices> createState() => _dashboardInvoicesState();
}

class _dashboardInvoicesState extends State<dashboardInvoices> {
  bool isSearching = false; // Track whether searching is active
  TextEditingController searchController = TextEditingController();
  String search = " ";

  void _createNewInvoice() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                InvoiceAdd(isEdit: false, InvoiceId: invoiceID)));
  }

  void _toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) {
        // Clear the search field and perform any reset logic here
        searchController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 69, 150, 216),
            title: isSearching
                ? TextField(
                    controller: searchController,
                    onChanged: (String? value) {
                      setState(() {
                        search = value.toString();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search by Names',
                      hintStyle: TextStyle(color: Color_white),
                      border: InputBorder.none,
                    ),
                  )
                : Center(
                    child: Text(
                      "Invoices",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
            leading: isSearching
                ? IconButton(
                    onPressed: _toggleSearch,
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => DashBoard()));
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
            actions: [
              IconButton(
                  onPressed: _toggleSearch,
                  icon: Icon(
                    isSearching ? Icons.close : Icons.search_outlined,
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
              InvoiceList(searchController: searchController),
              OutStandingInvoices(),
              PaidInvoices(),
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

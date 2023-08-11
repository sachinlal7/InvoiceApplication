import 'package:flutter/material.dart';
import 'package:invoice_app/Screens/dashboardInvoice.dart';

import '../Tabs/editTabBar.dart';
import '../constants_colors.dart';

class CreateInvoice extends StatefulWidget {
  const CreateInvoice({super.key});

  @override
  State<CreateInvoice> createState() => _CreateInvoiceState();
}

class _CreateInvoiceState extends State<CreateInvoice> {
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
                "Invoice",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => dashboardInvoices()));
                },
                icon: Icon(
                  Icons.arrow_back_ios,
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
            children: [
              EditInvoice(),
              Center(child: Text('Outstanding Tab Content')),
              Center(child: Text('Paid Tab Content')),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
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

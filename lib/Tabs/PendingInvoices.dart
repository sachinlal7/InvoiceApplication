import 'package:flutter/material.dart';

import '../constants_colors.dart';

class PendingInvoices extends StatefulWidget {
  const PendingInvoices({super.key});

  @override
  State<PendingInvoices> createState() => _PendingInvoicesState();
}

class _PendingInvoicesState extends State<PendingInvoices> {
  List data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Invoices"),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.maxFinite,
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      color: Color_green,
                      child: ListTile(
                        title: Text("Client Name"),
                        subtitle: Text("INV000001"),
                        trailing: Text("\$0.00"),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

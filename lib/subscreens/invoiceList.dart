import 'package:flutter/material.dart';
import 'package:invoice_app/constants_colors.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({super.key});

  @override
  State<InvoiceList> createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  List data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

import 'package:flutter/material.dart';

import '../constants_colors.dart';

class RecentActivities extends StatefulWidget {
  const RecentActivities({super.key});

  @override
  State<RecentActivities> createState() => _RecentActivitiesState();
}

class _RecentActivitiesState extends State<RecentActivities> {
  List data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recent Activities"),
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

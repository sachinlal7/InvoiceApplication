import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../Screens/details_page.dart';
import '../constants_colors.dart';
import '../model/custModels.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // For holding response as UserPets
  late CustDetails custDetails;
  // for data is loaded flag
  bool isDataLoaded = false;
  // error holding
  String errorMessage = '';

  // API Call
  Future<CustDetails> getDataFromAPI() async {
    Uri uri = Uri.parse(Base_URL + custlistendpoint);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      // All ok
      CustDetails custDetails = custDetailsFromJson(response.body);
      setState(() {
        isDataLoaded = true;
      });
      return custDetails;
    } else {
      errorMessage = '${response.statusCode}: ${response.body} ';
      return CustDetails(data: [], message: '', status: '');
    }
  }

  callAPIandAssignData() async {
    custDetails = await getDataFromAPI();
  }

  @override
  void initState() {
    callAPIandAssignData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API Call'),
        centerTitle: true,
      ),
      body: isDataLoaded
          ? errorMessage.isNotEmpty
              ? Text(errorMessage)
              : custDetails.data.isEmpty
                  ? const Text('No Data')
                  : ListView.builder(
                      itemCount: custDetails.data.length,
                      itemBuilder: (context, index) => getRow(index),
                    )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        onTap: () {
          // Navigate to Next Details
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailsPage(custDet: custDetails.data[index]),
              ));
        },
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              custDetails.data[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('customer: ${custDetails.data[index].name}'),
          ],
        ),
      ),
    );
  }
}

// // To parse this JSON data, do
// //
// //     final custList = custListFromJson(jsonString);

// import 'dart:convert';

// CustList custListFromJson(String str) => CustList.fromJson(json.decode(str));

// String custListToJson(CustList data) => json.encode(data.toJson());

// class CustList {
//   String status;
//   String message;
//   List<Datum> data;

//   CustList({
//     required this.status,
//     required this.message,
//     required this.data,
//     required id,
//     required name,
//     required phoneNumber,
//     required email,
//     required addedBy,
//   });

//   factory CustList.fromJson(Map<String, dynamic> json) => CustList(
//         status: json["status"],
//         message: json["message"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         addedBy: null,
//         email: null,
//         id: null,
//         name: null,
//         phoneNumber: null,
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class Datum {
//   int id;
//   String name;
//   String phoneNumber;
//   String email;
//   String addedBy;

//   Datum({
//     required this.id,
//     required this.name,
//     required this.phoneNumber,
//     required this.email,
//     required this.addedBy,
//   });

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         name: json["name"],
//         phoneNumber: json["phone_number"],
//         email: json["email"],
//         addedBy: json["added_by"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "phone_number": phoneNumber,
//         "email": email,
//         "added_by": addedBy,
//       };
// }

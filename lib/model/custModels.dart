// To parse this JSON data, do
//
//     final custDetails = custDetailsFromJson(jsonString);

import 'dart:convert';

CustDetails custDetailsFromJson(String str) =>
    CustDetails.fromJson(json.decode(str));

String custDetailsToJson(CustDetails data) => json.encode(data.toJson());

class CustDetails {
  CustDetails({
    this.status,
    this.message,
    required this.data,
  });
  final String? status;
  final String? message;
  final List<Datum> data;

  factory CustDetails.fromJson(Map<String, dynamic> json) => CustDetails(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final int id;
  final String name;
  final String phoneNumber;
  final String email;
  final String addedBy;

  Datum({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.addedBy,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        addedBy: json["added_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_number": phoneNumber,
        "email": email,
        "added_by": addedBy,
      };
}

class CustNameModels {
  final String status;
  final String message;
  final List<Datum> data;

  CustNameModels({
    required this.status,
    required this.message,
    required this.data,
  });
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
}

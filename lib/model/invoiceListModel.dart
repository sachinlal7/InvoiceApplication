class invoice_models {
  String? status;
  String? message;
  List<Data>? data;

  invoice_models({this.status, this.message, this.data});

  invoice_models.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? clientId;
  String? clientName;
  Null? logo;
  String? invoiceNumber;
  String? invoiceDate;
  String? dueDate;
  String? address;
  String? productName;
  int? quantity;
  String? faxNumber;
  String? unitPrice;
  String? totalPrice;
  String? paidAmount;
  String? dueAmount;
  String? paymentDate;
  String? paymentStatus;

  Data(
      {this.id,
      this.clientId,
      this.clientName,
      this.logo,
      this.invoiceNumber,
      this.invoiceDate,
      this.dueDate,
      this.address,
      this.productName,
      this.quantity,
      this.faxNumber,
      this.unitPrice,
      this.totalPrice,
      this.paidAmount,
      this.dueAmount,
      this.paymentDate,
      this.paymentStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    clientName = json['client_name'];
    logo = json['logo'];
    invoiceNumber = json['invoice_number'];
    invoiceDate = json['invoice_date'];
    dueDate = json['due_date'];
    address = json['address'];
    productName = json['product_name'];
    quantity = json['quantity'];
    faxNumber = json['fax_number'];
    unitPrice = json['unit_price'];
    totalPrice = json['total_price'];
    paidAmount = json['paid_amount'];
    dueAmount = json['due_amount'];
    paymentDate = json['payment_date'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['client_name'] = this.clientName;
    data['logo'] = this.logo;
    data['invoice_number'] = this.invoiceNumber;
    data['invoice_date'] = this.invoiceDate;
    data['due_date'] = this.dueDate;
    data['address'] = this.address;
    data['product_name'] = this.productName;
    data['quantity'] = this.quantity;
    data['fax_number'] = this.faxNumber;
    data['unit_price'] = this.unitPrice;
    data['total_price'] = this.totalPrice;
    data['paid_amount'] = this.paidAmount;
    data['due_amount'] = this.dueAmount;
    data['payment_date'] = this.paymentDate;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}

import 'package:khana_delivery/models/product_modal.dart';

class OrderModal {
  int? orderId;
  String? userId;
  String? orderDate;
  String? totalAmount;
  List<Product>? products;

  OrderModal(
      {this.orderId,
        this.userId,
        this.orderDate,
        this.totalAmount,
        this.products});

  OrderModal.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    userId = json['user_id'];
    orderDate = json['order_date'];
    totalAmount = json['total_amount'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['order_date'] = this.orderDate;
    data['total_amount'] = this.totalAmount;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
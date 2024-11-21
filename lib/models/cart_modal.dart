import 'package:khana_delivery/models/product_modal.dart';

class CartModal {
  int? _cartId;
  int? _quantity;
  Product? _product;

  CartModal({int? cartId, int? quantity, Product? product}) {
    if (cartId != null) {
      this._cartId = cartId;
    }
    if (quantity != null) {
      this._quantity = quantity;
    }
    if (product != null) {
      this._product = product;
    }
  }

  int? get cartId => _cartId;
  set cartId(int? cartId) => _cartId = cartId;
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;
  Product? get product => _product;
  set product(Product? product) => _product = product;

  CartModal.fromJson(Map<String, dynamic> json) {
    _cartId = json['cart_id'];
    _quantity = json['quantity'];
    _product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this._cartId;
    data['quantity'] = this._quantity;
    if (this._product != null) {
      data['product'] = this._product!.toJson();
    }
    return data;
  }
}
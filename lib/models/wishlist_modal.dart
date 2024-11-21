import 'package:khana_delivery/models/product_modal.dart';

class WishListModal {
  int? wishlistId;
  Product? product;

  WishListModal({this.wishlistId, this.product});

  WishListModal.fromJson(Map<String, dynamic> json) {
    wishlistId = json['wishlist_id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wishlist_id'] = this.wishlistId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

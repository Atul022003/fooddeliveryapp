class Product {
  int? productId;
  int? categoryId;
  int? quantity;
  String? name;
  String? description;
  String? price;
  String? imageUrl;
  String? categoryName;
  String? categoryImage;

  Product(
      {this.productId,
        this.categoryId,
        this.quantity,
        this.name,
        this.description,
        this.price,
        this.imageUrl,
        this.categoryName,
        this.categoryImage});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    imageUrl = json['image_url'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['image_url'] = this.imageUrl;
    data['category_name'] = this.categoryName;
    data['category_image'] = this.categoryImage;
    return data;
  }
}
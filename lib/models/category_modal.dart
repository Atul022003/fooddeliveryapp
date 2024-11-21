class Category {
  int? categoryId;
  String? name;
  String? categoryImage;

  Category({this.categoryId, this.name, this.categoryImage});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['category_image'] = this.categoryImage;
    return data;
  }
}
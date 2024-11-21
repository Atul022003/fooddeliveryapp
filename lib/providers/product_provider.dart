import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:khana_delivery/constants.dart';

import '../models/category_modal.dart';
import '../models/product_modal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For json decoding

class ProductProvider with ChangeNotifier {

 List<Product> get allProducts => _allProducts;
  List<Product> _allProducts = [];


  List<Category> get allCategories => _allCategories;
  List<Category> _allCategories = [];

 List<Product> get allCategoriesProducts => _allCategoriesProducts;
 List<Product> _allCategoriesProducts = [];

  void getAllCategories() async {
    //api call

    _allCategories = [];
    const url = "${Constants.baseUrl}${Constants.allCategoriesAPI}";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      // Parse the JSON string
      List<dynamic> categoryJson = jsonDecode(response.body);

      // Map JSON data to List<Category>
      var categories = categoryJson.map((json) => Category.fromJson(json)).toList();
      _allCategories = categories;
    }

    log("Categories Refreshed : ${allCategories.length}");
    notifyListeners();
  }

  void getAllProductsByCategoryId(int categoryId) async {
    _allCategoriesProducts = [];
    final url = "${Constants.baseUrl}${Constants.getCategoryItemsApi}/$categoryId";
    log("message > $url");
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      // Parse the JSON string
      List<dynamic> productJson = jsonDecode(response.body);

      // Map JSON data to List<Category>
      var products = productJson.map((json) => Product.fromJson(json)).toList();
      _allCategoriesProducts = products;
    }
    log("Products Refreshed : ${allCategoriesProducts.length}");
    notifyListeners();
  }

  ////////////
  void getAllProduct() async {
    //api call

    _allProducts = [];
    const url = "${Constants.baseUrl}${Constants.allProductsAPI}";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      // Parse the JSON string
      List<dynamic> productJson = jsonDecode(response.body);

      // Map JSON data to List<Category>
      var products = productJson.map((json) => Product.fromJson(json)).toList();
      _allProducts = products;
    }
    log("Products Refreshed : ${allProducts.length}");
    notifyListeners();
  }
}
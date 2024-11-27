import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:khana_delivery/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:khana_delivery/models/cart_modal.dart';
import 'package:khana_delivery/models/product_modal.dart'; // For json decoding

class   CartProvider with ChangeNotifier{


  List<CartModal> get allCartItems => _allCartItems;
  List<CartModal> _allCartItems = [];

  List<Product> getPlaceOrderProducts(){
    List<Product> listOfProducts = [];

    allCartItems.forEach((cartItem){

      final product = cartItem.product;
      product?.quantity = cartItem.quantity;
      listOfProducts.add(product!);

    });

    return listOfProducts;
  }

  double getCartTotalAmount(){
    double total = 0;
    allCartItems.forEach((allCartItem){

      total = total + (allCartItem.quantity ?? 0) * double.parse(allCartItem.product?.price ?? "0");

    });

    return total;
  }

  CartModal? getCartModal(int productId){

    for(var cart in allCartItems){
      if(cart.product?.productId == productId){
        return cart;
      }
    }
    return null;
  }

  Future<void> refreshCart() async {

    _allCartItems.clear();
    final userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    final url = "${Constants.baseUrl}${Constants.getCartApi}$userId";
    log("final url - $url");
    final response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},);

    if(response.statusCode == 200){
      List<dynamic> cartJson = jsonDecode(response.body);

      // Map JSON data to List<Category>
      var cartItems = cartJson.map((json) => CartModal.fromJson(json)).toList();
      _allCartItems = cartItems;
      log("Cart Items : ${cartItems.length}");
    } else {
      log("Error Cart Data");
    }

    notifyListeners();
  }

  Future<bool> addToCart(int productId, String userId) async {
    const url = "${Constants.baseUrl}${Constants.cartApi}";
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "product_id" : productId,
          "user_id" : userId,
        })
    );

    if(response.statusCode == 200){
      refreshCart();
      return true;
    } else {
      return false;
    }

  }

  Future<bool> removeFromCart(int productId, String userId) async {
    final url = "${Constants.baseUrl}${Constants.cartApi}$productId/$userId";
    log("final url - ${url}");
    final response = await http.delete(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "product_id" : productId,
          "user_id" : userId,
        })
    );

    if(response.statusCode == 200){
      refreshCart();
      return true;
    } else {
      return false;
    }

  }

  Future<bool>clearCart() async{
    final userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    final url = "${Constants.baseUrl}${Constants.cartApi}$userId";
    final response = await http.delete(Uri.parse(url),
      headers: { "Content-Type": "Application/json"},);

    if (response.statusCode==200){
      refreshCart();
      return true;
    }
    else{
      return false;
    }
  }
 }
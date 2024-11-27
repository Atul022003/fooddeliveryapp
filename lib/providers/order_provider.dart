import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:khana_delivery/providers/cart_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;

import '../models/order_modal.dart';

class OrderProvider with ChangeNotifier{
  List<OrderModal > get allOrders => _allOrders;
  List<OrderModal > _allOrders = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> placeOrder(BuildContext context) async {
    _isLoading = true;

    final cartProvider = Provider.of<CartProvider>(context,listen: false);

    final userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    const url = "${Constants.baseUrl}${Constants.placeOrderApi}";
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_id": userId,
          "total_amount": cartProvider.getCartTotalAmount(),
          "products": cartProvider.getPlaceOrderProducts()
        })
    );
    _isLoading = false;
    if (response.statusCode == 200) {
      cartProvider.clearCart();
      return true;
    }
    else {
      return false;
    }
    notifyListeners();
  }
  void getAllOrders ( ) async{
    _isLoading = true;
    _allOrders.clear();
    final userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    final url = "${Constants.baseUrl}${Constants.allOrders}$userId";
    log("Order url > $url");
    final response =  await http.get(Uri.parse(url),
      headers: {"Content-Type":"applications/json"},);
    if (response.statusCode==200){
      List<dynamic>orderjson = jsonDecode(response.body) ;
      var orderss = orderjson.map((json) => OrderModal.fromJson ( json)).toList();
      _allOrders = orderss;
      log("Order: ${orderss.length}");
    }
    else{
      log("orders not found");
    }
    _isLoading = false;
    notifyListeners();


  }
}



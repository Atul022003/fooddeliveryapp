
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:khana_delivery/constants.dart';
import 'package:khana_delivery/models/wishlist_modal.dart';



class WishlistProvider with ChangeNotifier{


  List<WishListModal> get allWishListItems => _allWishlistItems;
  List<WishListModal> _allWishlistItems = [];

  WishListModal? getWishListModal(int productId){
    for(var wishlist in allWishListItems ){
      if(wishlist.product?.productId == productId){
        return wishlist;
      }
    }
    return null;
  }

Future<void> addToWishlist(int productId) async{
  final userId = FirebaseAuth.instance.currentUser?.uid ?? "";
  const String url= "${Constants.baseUrl}${Constants.getWishlistApi}";
  final response = await http.post(Uri.parse(url),
  headers: { "Content-Type":"application/json"},
  body:jsonEncode({"product_id":productId,"user_id": userId})
  ,);
  if (response.statusCode == 200){
    refreshWishList();
  }
}

Future<void> refreshWishList() async{
  _allWishlistItems.clear();
  final userId = FirebaseAuth.instance.currentUser?.uid ?? "";
  final url = "${Constants.baseUrl}${Constants.getWishlistApi}$userId";
  log("url - ${url}");
  final response =  await http.get(Uri.parse(url),
    headers: {"Content-Type":"applications/json"},);
  if (response.statusCode == 200){
    List<dynamic> wishlistJson = jsonDecode(response.body);
    var WishlistItems = wishlistJson.map((json) => WishListModal.fromJson(json)).toList();
    _allWishlistItems = WishlistItems;
    log("Wishlist: ${WishlistItems.length}" );
  }
  else{
    log("Error Wishlist"  );
  }
  notifyListeners();


}

  Future<bool> removeFromWishlist(int productId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    final url = "${Constants.baseUrl}${Constants.getWishlistApi}$productId/$userId";
    log("final url - ${url}");
    final response = await http.delete(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "product_id" : productId,
          "user_id" : userId,
        })
    );

    log("respo - ${response.body}");

    if(response.statusCode == 200){
      refreshWishList();
      return true;
    } else {
      return false;
    }

  }

}
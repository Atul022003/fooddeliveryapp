import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:khana_delivery/constants.dart';
import '../models/category_modal.dart';
import '../models/product_modal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For json decoding

class AuthenticationProvider with ChangeNotifier {

  Future<bool> registerUser(String userId, String name, String profilePicture, String email) async {
    //api call
    const url = "${Constants.baseUrl}${Constants.registerAPI}";
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
        "user_id" : userId,
        "name" : name,
        "profile_picture" : profilePicture,
        "email" : email
      })
    );

    if(response.statusCode == 200){
      return true;
    } else {
      return false;
    }

  }


}
import 'dart:convert';
import 'dart:developer';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:khana_delivery/models/address_modal.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class AddressProvider with ChangeNotifier{
  List<Address> get allAddress => _allAddress;
  List<Address> _allAddress = [];
  void getAllAddress ( ) async{
    _allAddress.clear();
    final userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    final url = "${Constants.baseUrl}${Constants.getAddressApi}$userId";
    final response =  await http.get(Uri.parse(url),
      headers: {"Content-Type":"applications/json"},);
    if (response.statusCode==200){
      List<dynamic>addressjson = jsonDecode(response.body) ;
      var addresses = addressjson.map((json) => Address.fromJson ( json)).toList();
      _allAddress = addresses;
      log("Address: ${addresses.length}");
    }
    else{
      log("Address not found");
    }
    notifyListeners();


  }




}
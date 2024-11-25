import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:khana_delivery/models/address_modal.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class AddressProvider with ChangeNotifier{
  List<Address> get allAddress => _allAddress;
  List<Address> _allAddress = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Address? userSelectedAddress;

  Address? getUserSelectedAddress(){
    if(userSelectedAddress == null){
      if(allAddress.isNotEmpty){
        return allAddress.first;
      } else {
        return null;
      }
    }

    return userSelectedAddress;
  }

  void getAllAddress ( ) async{
    _isLoading = true;
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
    _isLoading = false;
    notifyListeners();


  }
  Future<bool> saveAddress(String address, String landmark, double lat, double longi) async {
    _isLoading = true;
    final userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    const url = "${Constants.baseUrl}${Constants.getAddressApi}";
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_id" : userId,
          "address" : address,
          "landmark" : landmark,
          "latitude" : lat,
          "longitude" : longi,
        })
    );
    _isLoading = false;
    if (response.statusCode==200){
      getAllAddress();
      return true;
    }
    else{
      return false;
    }

  }
  Future<bool>updateAddress(  int addressid ,String address , String landmark,double lat,double longi) async{
    _isLoading = true;
    final userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    final url = "${Constants.baseUrl}${Constants.updateAddressApi}$addressid";
    final response = await http.put(Uri.parse(url),
             headers: { " Content - Type": " Application/json"},
             body :jsonEncode({
    "user_id" : userId,
    "address" : address,
    "landmark" : landmark,
    "latitude" : lat,
    "longitude" : longi,
    }) );
    _isLoading = false;
    if (response.statusCode==200){
    getAllAddress();
    return true;
    }
    else{
    return false;
    }
  }
  Future<bool>deleteAddress( int addressId) async{
    _isLoading = true;
   final url = "${Constants.baseUrl}${Constants.deleteAddressApi}$addressId";
    final response = await http.delete(Uri.parse(url),
        headers: { "Content-Type": "Application/json"},);

    _isLoading = false;
    if (response.statusCode==200){
      getAllAddress();
      return true;
    }
    else{
      return false;
    }
  }




}
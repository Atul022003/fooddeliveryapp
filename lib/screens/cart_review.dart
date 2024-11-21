import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khana_delivery/models/cart_modal.dart';
import 'package:khana_delivery/models/product_modal.dart';
import 'package:khana_delivery/providers/cart_provider.dart';
import 'package:khana_delivery/screens/homePage.dart';
import 'package:provider/provider.dart';

class CartReview extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CartReviewState();
  }

}
class CartReviewState extends State<CartReview>{
  @override
  Widget build (BuildContext context) {
    CartProvider cartProvider = Provider.of(context);


   return ListView.builder(
     itemCount: cartProvider.allCartItems.length,
     itemBuilder: (context,index ){
       CartModal data = cartProvider.allCartItems[index];
       return ProductWidget(data.product!, context);
     },
   );


  }

}
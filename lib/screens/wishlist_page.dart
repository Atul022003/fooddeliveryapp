import 'package:flutter/cupertino.dart';
import 'package:khana_delivery/models/product_modal.dart';
import 'package:khana_delivery/models/wishlist_modal.dart';
import 'package:flutter/material.dart';
import 'package:khana_delivery/providers/wishlist_provider.dart';
import 'package:khana_delivery/screens/homePage.dart';
import 'package:provider/provider.dart';

class WishListPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WishListPageState();
  }

}
class WishListPageState extends State<WishListPage>{

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of(context);
   return ListView.builder(itemCount: wishlistProvider.allWishListItems.length,
   itemBuilder: (context,index ){
     WishListModal data = wishlistProvider.allWishListItems[index];
     return ProductWidget(data.product!, context);
   },);
  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khana_delivery/models/product_modal.dart';
import 'package:khana_delivery/models/category_modal.dart' as app_category;
import 'package:khana_delivery/providers/cart_provider.dart';
import 'package:khana_delivery/providers/product_provider.dart';
import 'package:khana_delivery/providers/wishlist_provider.dart';
import 'package:khana_delivery/screens/homePage.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class CategorieProduct extends StatefulWidget{

  final app_category.Category category;
  CategorieProduct(this.category);

//  final Category category;
  //CategorieProduct(this.category,);



  @override
  State<StatefulWidget> createState() {
   return CategorieProductState();
  }

}
class CategorieProductState extends State<CategorieProduct>{

  @override
  void initState() {
    final provider = Provider.of<ProductProvider>(context ,listen: false);
    provider.getAllProductsByCategoryId(widget.category.categoryId ?? 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ProductProvider>(context);
    final wishlistprovider = Provider.of<WishlistProvider>(context);
    final cartprovider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Column(
        children: provider.allCategoriesProducts.map((product){
          return ProductWidget(product, context);
        }).toList(),
      ),
    );


  }


}




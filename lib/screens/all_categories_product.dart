import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khana_delivery/providers/wishlist_provider.dart';
import 'package:khana_delivery/screens/categorie_product.dart';
import 'package:provider/provider.dart';
import 'package:khana_delivery/models/category_modal.dart' as app_category;
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import 'homePage.dart';

class AllCategoriesProduct extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AllCategoriesProductState();
  }

}
class AllCategoriesProductState extends State<AllCategoriesProduct>{


  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishProvider = Provider.of<WishlistProvider>(context);


    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: SingleChildScrollView(child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
              child: Text("Categories",style: TextStyle(fontSize: 20),),
            ),
            Wrap(
              runSpacing: 15,
              spacing: 15,
              children: productProvider.allCategories.map((category) => CategoryWidget(category)).toList(),


            ),

            Padding(padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
              child: Text("Products",style: TextStyle(fontSize: 20),),
            ),

            Column(children: productProvider.allProducts.map((products) => ProductWidget(products,context)).toList(),),
          ],

        ),),



      ),



    );
  }

  Widget CategoryWidget(app_category.Category category){
    return InkWell(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder:(context) => CategorieProduct(category)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child:  Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(category.categoryImage ?? ""),

            ),

            SizedBox(height: 10,),
            Text(category.name ?? "",style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),),
    ) ;
  }

}
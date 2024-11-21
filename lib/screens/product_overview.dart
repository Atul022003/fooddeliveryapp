import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khana_delivery/models/product_modal.dart';
import 'package:khana_delivery/screens/wishlist_page.dart';
import 'package:khana_delivery/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';



class  ProductOverView extends StatefulWidget{
  final Product product;
  ProductOverView(this.product, {super.key});

  @override
  State<StatefulWidget> createState() {

    return  ProducrOverViewState ();
  }

}
class ProducrOverViewState extends State<ProductOverView>{
  Widget bottomNaviagtionBar({
    required Color iconColor,
    required Color backgroundColor,
    required Color color,
    required String title,
    required IconData iconData,
  }) {
    return Expanded(child: Container(
      padding: EdgeInsets.all(20),
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
              iconData,
            size: 17,
            color: iconColor,
          ),
          SizedBox(width: 5,),

          Text(
            title,
            style: TextStyle(color: color),
          )
        ],
      ),
    ));
  }
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final wishListProvider = Provider.of<WishlistProvider>(context);
    final wishListModal = wishListProvider.getWishListModal(product.productId ?? 0);
    final cartProvider = Provider.of<CartProvider>(context);
    final cartModal = cartProvider.getCartModal(product.productId ?? 0);

    double iconData = MediaQuery.of(context).size.width * 0.8;


   return Scaffold(
     bottomNavigationBar: Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         InkWell(
           onTap: (){

             if(wishListModal == null){
               wishListProvider.addToWishlist(product.productId ?? 0);
             } else {
               wishListProvider.removeFromWishlist(product.productId ?? 0);
             }

             },
           child: bottomNaviagtionBar(
              backgroundColor: Colors.brown,
              color: Colors.white,
              iconColor: Colors.white,
              title: ( wishListModal == null) ? "Add to Wishlist" :"Remove",
               iconData:( wishListModal == null)? Icons.favorite_outline: Icons.favorite,
           ),




         ),
         cartModal == null ? InkWell(
           onTap: (){
             if (cartModal== null){
               cartProvider.addToCart(product.productId ?? 0,FirebaseAuth.instance.currentUser?.uid ?? "");
             }
             else {
               cartProvider.removeFromCart(product.productId ?? 0,
                   FirebaseAuth.instance.currentUser?.uid ?? "");
             }
           },
           child:
               bottomNaviagtionBar(
                   backgroundColor: Colors.grey,
                   color: Colors.white,
                   iconColor: Colors.white,
                   title: (cartModal == null)? "Add to Cart":"Remove Cart",
                   iconData:(cartModal == null)?Icons.shop_outlined: Icons.shop
               ),


         ) : Container(height:40,

           decoration: BoxDecoration(
               color: Colors.grey,
               borderRadius: BorderRadius.only(topLeft: Radius.circular(14),topRight: Radius.circular(14),
                   bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))

           ),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               InkWell(onTap: (){
                 cartProvider.removeFromCart(product.productId ?? 0,FirebaseAuth.instance.currentUser?.uid ?? "");
               },
                 child:  Padding(child: Icon(Icons.remove,color: Colors.black,),padding: EdgeInsets.all(10),),
               ),
               Text("${cartModal.quantity}",style: TextStyle(fontWeight: FontWeight.bold),),
               InkWell(onTap: (){
                 cartProvider.addToCart(product.productId ?? 0,FirebaseAuth.instance.currentUser?.uid ?? "");
               },
                 child:  Padding(child: Icon(Icons.add,color: Colors.black,),padding: EdgeInsets.all(10),),
               ),

             ],

           ),
         ),






       ],
     ),
     appBar: AppBar(


     ),
     body: Column(

       crossAxisAlignment: CrossAxisAlignment.start,
       children: [

         Container(
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(30),
           ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(left: 15,right: 15),
              child: ClipRRect( borderRadius: BorderRadius.circular(10),child:  Image.network(
                product.imageUrl ?? "", fit: BoxFit.cover,
              ),
              ),),

              const SizedBox(height: 20,),
              Padding(padding: EdgeInsets.only(left: 10),
                child: Text(product.name ?? "",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),),
              Padding(padding: EdgeInsets.all(10),child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( "₹${product.price ?? ""}",style: TextStyle(color: Colors.green,fontSize: 20)),
                  const SizedBox(height: 10,),
                  Text("Description :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),
                  SizedBox(height: 10,),
                  Text( product.description??"",style: TextStyle(fontSize: 17),)
                ],
              ),),
            ],

          ),

         ),







       ],

     ),
   );
  }

}
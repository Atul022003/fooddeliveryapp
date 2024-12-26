import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khana_delivery/main.dart';
import 'package:khana_delivery/models/category_modal.dart' as app_category;
import 'package:khana_delivery/models/product_modal.dart';
import 'package:khana_delivery/providers/cart_provider.dart';
import 'package:khana_delivery/providers/product_provider.dart';
import 'package:khana_delivery/providers/wishlist_provider.dart';
import 'package:khana_delivery/screens/address_page.dart';
import 'package:khana_delivery/screens/all_categories_product.dart';
import 'package:khana_delivery/screens/cart_review.dart';
import 'package:khana_delivery/screens/categorie_product.dart';
import 'package:khana_delivery/screens/my_orders.dart';
import 'package:khana_delivery/screens/product_overview.dart';
import 'package:khana_delivery/screens/profile_page.dart';
import 'package:khana_delivery/screens/profile_pagee.dart';
import 'package:khana_delivery/screens/wishlist_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}
class HomePageState extends State<HomePage>{

  int _menuIndex = 0;
  List<String> _titles = ["Home","Profile","Address","Review Cart","My Orders","Wishlist","Notifications","Rating & Review","Complaint","FAQs"];

  @override
  void initState() {

    LocalNotificationService.initialize();
    final provider = Provider.of<ProductProvider>(context,listen: false);
    final cartProvider = Provider.of<CartProvider>(context,listen: false);
    final wishlistProvider = Provider.of<WishlistProvider>(context,listen: false);
    provider.getAllCategories();
    provider.getAllProduct();
    cartProvider.refreshCart();
    wishlistProvider.refreshWishList();



    super.initState();
  }

  void changeMenu(int newIndex){
    Navigator.pop(context);
    setState(() {
      _menuIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {

    //final productProvider = Provider.of<ProductProvider>(context);
    //final cartProvider = Provider.of<CartProvider>(context);


    return Scaffold(
      drawer: Drawer(
        child: Container(

          child: Column(
            children: [
              SizedBox(height: 20,),
              listTile(icon:Icons.home_outlined, title: "Home",onTap: (){
                changeMenu(0);
              }),
              listTile(title:"Profile ", icon:Icons.person_outlined, onTap:(){
                changeMenu(1);
              }),
              listTile(icon:Icons.location_on_outlined ,title:"Address",onTap: (){
                changeMenu(2);
              }),
              listTile(icon:Icons.shop_outlined ,title:"Review Cart",onTap: (){
                changeMenu(3);
              }),
              listTile(icon:Icons.shopping_bag, title: "My Orders",onTap: (){
                changeMenu(4);
              }),
              listTile(icon:Icons.favorite_outline, title: "Wishlist",onTap: (){
                changeMenu(5);
              }),
              listTile(icon:Icons.notifications_outlined, title: "Notiffication",onTap: (){
                changeMenu(6);
              }),
              listTile(icon:Icons.star_outline, title: "Rating & Review",onTap: (){
                changeMenu(7);
              }),
              listTile(icon:Icons.copy_outlined, title: "Raise a Complaint ",onTap: (){
                changeMenu(8);
              }),
              listTile(icon:Icons.format_quote_outlined, title: "FaQs",onTap: (){
                changeMenu(9);
              }),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Contact Support',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                ],
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Call us ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                  Text('+916394897783', style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Mail us at',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  Text('=atulm7576@gmail.com',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                ],
              )


            ],
          ),
        ),

      ),


      appBar: AppBar(

        title: Text(_titles[_menuIndex]),

      ),
      body: getCurrentPage(),

    );
  }

  Widget getCurrentPage(){
    if(_menuIndex == 0){
      return AllCategoriesProduct();
    } else if(_menuIndex == 1){
      return ProfilePagee();
    }
    else if(_menuIndex == 2){
      return AddressPage();  }
    else if(_menuIndex == 3){
      return CartReview();
    }
    else if(_menuIndex == 4){
      return MyOrders();  }
    else if(_menuIndex == 5){
      return WishListPage();  }

    else {
      return const SizedBox();
    }
  }




  Widget CategoryWidget(app_category.Category category){
    return InkWell(

      child: Container(

    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    ),
    child:  Column(
    children: [
    CircleAvatar(
    radius: 40,
    backgroundImage: NetworkImage(category.categoryImage ?? "",),
    ),
    SizedBox(height: 10,),
    Text(category.name ?? "",style: TextStyle(fontWeight: FontWeight.bold),)
    ],
    ),),
      onTap: (){

      },
    );
  }

}

Widget ProductWidget( Product product,BuildContext context) {

  final wishListProvider = Provider.of<WishlistProvider>(context,listen: false);
  final cartProvider = Provider.of<CartProvider>(context,listen: false);
  final cartModal = cartProvider.getCartModal(product.productId ?? 0);
  final wishListModal = wishListProvider.getWishListModal(product.productId ?? 0);
  return InkWell(child: Padding(
    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column for text details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name ??" ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 5),
              Text( product.price ??" ", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                product.description ??  " ",
                style: TextStyle(color: Colors.grey[800]),
              ),
              SizedBox(height: 5),
              OutlinedButton.icon(
                onPressed: () {

                  if(wishListModal == null){
                    wishListProvider.addToWishlist(product.productId ?? 0);
                  } else {
                    wishListProvider.removeFromWishlist(product.productId ?? 0);
                  }


                },
                style: OutlinedButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: Icon(wishListModal == null ? Icons.favorite_outline : Icons.favorite, size: 16),
                label: Text(wishListModal == null ? "Wishlist" : "Remove", style: TextStyle(fontSize: 14)),
              ),

            ],
          ),
        ),
        SizedBox(width: 20,),
        Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10), // Add space between text and image
              child:ClipRRect(borderRadius: BorderRadius.circular(10),child:  Image.network(
                product.imageUrl ?? "", // Update this with your image path
                width: 150, // Set the width of the image
                height: 150, // Set the height of the image
                fit: BoxFit.cover, // Adjusts the image size
              ),
              ),

            ),
            Positioned(
                bottom: 2,
                child: cartModal == null ? ElevatedButton.icon(
                  onPressed: (){

                    cartProvider.addToCart(product.productId ?? 0,FirebaseAuth.instance.currentUser?.uid ?? "");

                  },
                  icon: Icon(Icons.add, color: Colors.black),
                  label: Text("Add"),



                ) : Container(height:40,

                  decoration: BoxDecoration(
                      color: Colors.white,
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
                )),
          ],

        ),
        // Image on the right side

      ],
    ),
  ),onTap: (){
    Navigator.push(context,MaterialPageRoute(builder: (context) => ProductOverView(product)));


  },);
}

Widget listTile({ required String title, required IconData icon, required Null Function() onTap}) {
  return ListTile(
    onTap: onTap,

    leading: Icon(
      icon,
      size: 25,
    ),
    title: Text(
      title,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}
Widget CartWidget( Product product,BuildContext context) {

  final wishListProvider = Provider.of<WishlistProvider>(context,listen: false);
  final cartProvider = Provider.of<CartProvider>(context,listen: false);
  final cartModal = cartProvider.getCartModal(product.productId ?? 0);

  final totalAmount = double.parse(product.price ?? "0") * (cartModal?.quantity ?? 0);

  return InkWell(child: Padding(
    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column for text details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name ??" ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 5),
              Text("₹ ${product.price ??" "}", style: TextStyle()),
              SizedBox(height: 10),
              Text(
                "${cartModal?.quantity} qty x (${product.price}) = ₹ $totalAmount",
                style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 16),
              ),
              SizedBox(height: 5),


            ],
          ),
        ),
        SizedBox(width: 20,),
        Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10), // Add space between text and image
              child:ClipRRect(borderRadius: BorderRadius.circular(10),child:  Image.network(
                product.imageUrl ?? "", // Update this with your image path
                width: 90, // Set the width of the image
                height: 90, // Set the height of the image
                fit: BoxFit.cover, // Adjusts the image size
              ),
              ),

            ),
            Positioned(
                bottom: 2,
                child: cartModal == null ? ElevatedButton.icon(
                  onPressed: (){

                    cartProvider.addToCart(product.productId ?? 0,FirebaseAuth.instance.currentUser?.uid ?? "");

                  },
                  icon: Icon(Icons.add, color: Colors.black),
                  label: Text("Add"),



                ) : Container(height:40,

                  decoration: BoxDecoration(
                      color: Colors.white,
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
                )),
          ],

        ),
        // Image on the right side

      ],
    ),
  ),onTap: (){
    Navigator.push(context,MaterialPageRoute(builder: (context) => ProductOverView(product)));


  },);
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khana_delivery/models/cart_modal.dart';
import 'package:khana_delivery/models/product_modal.dart';
import 'package:khana_delivery/providers/cart_provider.dart';
import 'package:khana_delivery/screens/homePage.dart';
import 'package:provider/provider.dart';

import '../providers/address_provider.dart';
import 'add_address.dart';

class CartReview extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CartReviewState();
  }

}
class CartReviewState extends State<CartReview>{

  @override
  void initState() {
    final provider = Provider.of<AddressProvider>(context,listen: false);
    provider.getAllAddress();
    super.initState();
  }
  @override
  Widget build (BuildContext context) {

    final provider = Provider.of<AddressProvider>(context);
    CartProvider cartProvider = Provider.of(context);


   return Scaffold(
     bottomNavigationBar: cartProvider.allCartItems.isNotEmpty ? Card(
       margin: EdgeInsets.all(10),
       child:
       Padding(padding: EdgeInsets.all(20),child: Column(
         mainAxisSize: MainAxisSize.min,
         children: [

           Row(children: [

             Text("Total Amount",style: TextStyle(fontWeight: FontWeight.bold),),
             Spacer(),
             Text("₹ ${cartProvider.getCartTotalAmount()}",
               style: TextStyle(fontWeight: FontWeight.bold,
               fontSize: 19),)


           ],),
           ElevatedButton(onPressed: (){}, child: Text("Place Order"))

         ],),),) : SizedBox(),
     body: cartProvider.allCartItems.isEmpty ? Center(child:
     Column(

       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         SizedBox(height: 20,),
         Icon(Icons.add_shopping_cart_outlined,size: 100,),
         Text("No items in cart!",style: TextStyle(fontSize: 20),)

       ],),) : Column(
     children: [
       ListView.builder(
         shrinkWrap: true,
         itemCount: cartProvider.allCartItems.length,
         itemBuilder: (context,index ){
           CartModal data = cartProvider.allCartItems[index];
           return CartWidget(data.product!, context);
         },
       ),
       AddressWidget(context)


     ],
   ),);




  }

}

Widget AddressWidget(BuildContext context){
  final provider = Provider.of<AddressProvider>(context ,listen: false);

  final userAddress = provider.getUserSelectedAddress();

  return Card(
    margin: EdgeInsets.all(20),
    child: Padding(child: Column(children: [

      Row(children: [
        Text("Delivery to-",style: TextStyle(fontWeight: FontWeight.bold),),
        Spacer(),
        TextButton(onPressed: (){}, child: Text("Change"))
      ],),

      SizedBox(height: 10,),
      userAddress == null ? Column(children: [

        Text("Please add atleast one address!!"),
        TextButton(onPressed: (){

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddAddressPage()));

        }, child: Text("Add New Address"))

      ],) : Text(userAddress.address ?? "",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
    ],),padding: EdgeInsets.all(10),),);
}
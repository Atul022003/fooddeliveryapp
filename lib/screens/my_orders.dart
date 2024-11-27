import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khana_delivery/models/order_modal.dart';
import 'package:khana_delivery/models/product_modal.dart';
import 'package:provider/provider.dart';


import '../providers/order_provider.dart';
import 'order_detailPage.dart';

class MyOrders extends StatefulWidget{
  //Product product;
 // MyOrders(this.product);
  @override
  State<StatefulWidget> createState() {
   return MyOrdersState();
  }

}
class MyOrdersState extends State<MyOrders>{

  @override
  void initState() {
    final orderProvider = Provider.of<OrderProvider>(context,listen: false);
    orderProvider.getAllOrders();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final orderProvider = Provider.of<OrderProvider>(context);
   return Scaffold(
     body: orderProvider.isLoading ? CircularProgressIndicator() :
     orderProvider.allOrders.isEmpty ? Text("No orders found") :
     Column(children: orderProvider.allOrders.map((order)=>Orderwiget(order,context)).toList(),),

   );
  }
  

}
Widget Orderwiget(OrderModal order, BuildContext context ){

  
  return  ListTile(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailpage(order)));
    },
    title: Text(order.orderDate??""),
    subtitle: Text(" totalAmount =  ${order.totalAmount ?? ""}"),
  );
}
Widget OrderDetailwiget(Product product, BuildContext context ){

  return ListTile(
    leading: Image.network(product.imageUrl ?? "",width: 100,height: 100,fit: BoxFit.cover,),
    title: Text(product.name ?? ""),
    subtitle:Text(product.price ?? ""),
  );

  return  Row(
    children: [
      Image.network(product.imageUrl ??"" ,height: 90,),
      Column(children: [
        Text(" ${ product.name ?? ""}"),
        Text("Rs. ${ product.price ?? ""}")
      ],)

  ]);
}
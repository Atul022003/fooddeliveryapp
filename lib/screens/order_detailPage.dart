import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khana_delivery/models/order_modal.dart';
import 'package:khana_delivery/models/product_modal.dart';
import 'package:khana_delivery/screens/my_orders.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';

class OrderDetailpage extends StatefulWidget{
  OrderModal order;
  OrderDetailpage(this.order);
  

  @override
  State<StatefulWidget> createState() {
    return OrderDetailpageState();
  }

}
class OrderDetailpageState extends State<OrderDetailpage>{

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(" Order Detail"),
      ),
      body:
      Padding(padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
          decoration: getCardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order Details",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                SizedBox( height: 15,),
                Text(" Order ID: ${widget.order.orderId}"),
                SizedBox( height: 10,),
                Text("${widget.order.orderDate}"),





              ],

            ),

          ),

          SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: getCardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              Text("Products you have bought",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                SizedBox( height: 15,),
              Column(
                children: widget.order.products?.map((product)=>OrderDetailwiget(product,context)).toList() ?? List.empty(),
              )
            ],),
          )
        ],

      ),)

    );
  }

}

BoxDecoration getCardDecoration(){
  return BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          //offset: Offset(0, 4),
            color: Color(0xFFe6e6e6), //edited
            spreadRadius: 2,
            blurRadius: 5  //edited
        )]);
}
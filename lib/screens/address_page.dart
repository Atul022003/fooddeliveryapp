import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khana_delivery/providers/address_provider.dart';
import 'package:khana_delivery/screens/add_address.dart';
import 'package:provider/provider.dart';

class AddressPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AddressPageState();
  }

}
class AddressPageState extends State<AddressPage>{

  @override
  void initState(){
    final provider = Provider.of<AddressProvider>(context ,listen: false);
    provider.getAllAddress();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: Text("Tab to add"),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddAddressPage()));
        },
        child: Icon(Icons.add_rounded),

      ),
    );
  }

}
Widget AddressWidget( ){
  return Column(

  );

}
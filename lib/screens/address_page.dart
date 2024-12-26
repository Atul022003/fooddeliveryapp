
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khana_delivery/models/address_modal.dart';
import 'package:khana_delivery/providers/address_provider.dart';
import 'package:khana_delivery/screens/add_address.dart';
import 'package:khana_delivery/screens/delete_address.dart';
import 'package:khana_delivery/screens/update_address.dart';
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
    final addressProvider = Provider.of<AddressProvider>(context);
    return Scaffold(


      body: Stack(children: [

        if(addressProvider.isLoading) const CircularProgressIndicator(),

        (addressProvider.allAddress.isNotEmpty) ?  SingleChildScrollView(
          child: Column(children: [
            Column(
              children: addressProvider.allAddress.map((address)=>AddressWidget(address,context)).toList(),
            ),
            SizedBox(height: 100,)

          ],),
        ) :Text("Tap to add",textAlign:TextAlign.center ,)
      ],) ,
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
Widget AddressWidget(Address address,BuildContext context){
  final provider = Provider.of<AddressProvider>(context,listen: false);



  return ListTile(title: Text(address.address ?? "") ,

    subtitle: Text(address.landmark ?? ""),
  onTap: (){
    Navigator.push(context,MaterialPageRoute(builder: (context) => UpdateAddress( address)));

  },
    trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){
     showDialog(context: context, builder:(BuildContext context ){
       return AlertDialog(
         title:Text("Delete"),
         content: Text("Are you Sure to delete"),
         actions: [
           TextButton(onPressed: (){
             Navigator.pop(context);
           }, child:Text("Cancel")),
           TextButton(onPressed: (){
             provider.deleteAddress(address.id ?? 0);
             Navigator.pop(context);
           }, child:Text("Ok"))

         ],

       );
     });


    },),

  );


}

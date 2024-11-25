import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../models/address_modal.dart';
import '../providers/address_provider.dart';

class DeleteAddress extends StatefulWidget{

  final Address address;
  DeleteAddress(this.address, {super.key});

  @override
  State<StatefulWidget> createState() {
    return DeleteAddressState();
  }

}
class DeleteAddressState extends State<DeleteAddress>{

  late GoogleMapController mapController;
  LatLng? _initialPosition;
  CameraPosition? _userLocationMoved;

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  Future<void>_deleteAddress() async {

    final provider = Provider.of<AddressProvider>(context , listen: false);

    final address = _addressController.text.trim();
    final landmark = _landmarkController.text.trim();
    final lat =  _userLocationMoved?.target.latitude ?? 0;
    final longi =  _userLocationMoved?.target.longitude ?? 0;

    if(address.isEmpty || _initialPosition == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Write proper address")));
      return;
    }

    if(lat == 0 || longi == 0){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select a valid location on map")));
      return;
    }


    provider.updateAddress( widget.address.id ?? 0 ,address, landmark, lat,longi);


  }
  void moveToOriginalLocation(){
    mapController.animateCamera(CameraUpdate.newLatLng(_initialPosition!));
  }

  @override
  void initState() {
    _initialPosition = LatLng(double.parse(widget.address.latitude ?? "0"),double.parse(widget.address.longitude ?? "0,o"));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Address"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: _initialPosition == null
                  ? Text("Unable to get current location")
                  : Stack(children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    mapController = controller;

                  },
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition!,
                    zoom: 14.0,
                  ),
                  zoomControlsEnabled: false,
                  onCameraMove: (position){
                    _userLocationMoved = position;
                  },
                ),
                Align(
                  alignment: Alignment.center,
                  child:Icon(Icons.location_on,color: Colors.red,size: 40,) ,

                ),


                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(padding: EdgeInsets.only(right: 10,bottom: 10),
                    child: InkWell(child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(padding: EdgeInsets.all(5),child: Icon(Icons.my_location),),
                    ),onTap: (){

                      moveToOriginalLocation();

                    },)
                    ,),
                )




              ],),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Address",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _landmarkController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Landmark",
              ),
            ),
            SizedBox(height: 10),
            Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: (){
                    _deleteAddress();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Address deleted!")));
                    Navigator.pop(context);
                  },
                  child: Text("delete Address",style:TextStyle(color: Colors.grey),),


                )

            ),


          ],
        ),
      ),

    );
  }

}
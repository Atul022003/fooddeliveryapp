import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddAddressPageState();
  }
}

class AddAddressPageState extends State<AddAddressPage> {
  late GoogleMapController mapController;
  LatLng? _initialPosition;
  CameraPosition? _userLocationMoved;
  bool _isMapLoading = true;

  final TextEditingController _addressController = TextEditingController();
 final TextEditingController _landmarkController = TextEditingController();


  @override
  void initState() {
    getLocation();
    super.initState();
  }

  Future<void> getLocation() async {
    setState(() {
      _initialPosition = null;
      _isMapLoading = true;
    });

    await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR: ${error.toString()}");
    });

    try {
      final location = await Geolocator.getCurrentPosition();
      setState(() {
        _initialPosition = LatLng(location.latitude, location.longitude);
        _userLocationMoved = CameraPosition(target: LatLng(location.latitude, location.longitude));
        _isMapLoading = false;

        // Use _addMarker here after it is defined as a class-level method

      });
    } catch (e) {
      setState(() {
        _initialPosition = null;
        _isMapLoading = false;
      });
    }
  }

  // *** Change: _addMarker moved to the class level ***

  Future<void>_saveAddress() async{
    final address = _addressController.text.trim();
    final landmark = _landmarkController.text.trim();
    if( address.isEmpty || _initialPosition == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Write proper address")));
      return;
    }

    _userLocationMoved?.target.latitude;
    _userLocationMoved?.target.longitude;



}

void moveToOriginalLocation(){
    mapController.animateCamera(CameraUpdate.newLatLng(_initialPosition!));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Address"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: _isMapLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _initialPosition == null
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
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Address",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Landmark",
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: (
                  //  _saveAddress,
                    ) {
                  // Implement save functionality here
                },
                child: Text("Save Address"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

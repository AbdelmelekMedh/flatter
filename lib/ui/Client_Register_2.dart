//import 'package:flutter/gestures.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:geolocation/geolocation.dart';
//import 'package:flutter_map/flutter_map.dart';
//import 'package:latlong/latlong.dart';
//
//
//class Client_Register_2 extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//// TODO: implement createState
//    return clientregisterState2();
//  }
//}
//
//class clientregisterState2 extends State<Client_Register_2> {
//  TextEditingController _UserNameController = new TextEditingController();
//  TextEditingController _PasswordController = new TextEditingController();
//  MapController controller = new MapController();
//
//
//  getPermission() async {
//    final GeolocationResult result = await Geolocation.requestLocationPermission(
//      permission: const LocationPermission(
//      android: LocationPermissionAndroid.fine,
//      ios: LocationPermissionIOS.always,
//      ));
//    return result;
//  }
//
//  getLocation(){
//    return getPermission().then((result) async{
//      if(result.isSuccessful) {
//        final  coords =
//            await Geolocation.currentLocation(accuracy: LocationAccuracy.best);
//
//        return coords;
//      }
//      return Geolocation.currentLocation(accuracy: LocationAccuracy.best);
//    }
//    );
//
//  }
//
//  buildMap() {
//    debugPrint("////////////////"+getLocation().toString());
//    getLocation().then((response) {
//      debugPrint("////////////////"+response);
//      if(response.isSucceful) {
//        response.listen((value) {
//          debugPrint("////////////////"+value.location.lattitude);
//          controller.move(
//          new LatLng(value.location.lattitude, value.location.longitude),
//         15.0 );
//          debugPrint("////////////////"+value.location.lattitude);
//        });
//      }
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//// TODO: implement build
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text("Register",
//          style: TextStyle(
//            fontSize: 25,
//            fontFamily: 'Liu',
//          ),),
//        backgroundColor: Color.fromARGB(400, 61, 157, 183),
//      ),
//      backgroundColor: Colors.grey.shade50,
//      body:
//          new FlutterMap(
//            mapController: controller,
//              options: new MapOptions(center: buildMap(),minZoom: 5.0),
//          layers: [
//            new TileLayerOptions(
//              urlTemplate:
//                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//              subdomains: ['a', 'b', 'c']
//            )
//          ],)
//
//
//
//    );
//  }
//}

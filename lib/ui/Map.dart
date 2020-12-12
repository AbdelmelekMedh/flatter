import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


class Map extends StatefulWidget {
  @override
  State<Map> createState() => MapSampleState();
}

class MapSampleState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  MapType type ;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Set<Marker> markers ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    type = MapType.hybrid;
    markers = Set.from([]) ;
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Client Register",
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Liu',
          ),),
        backgroundColor: Color.fromARGB(400, 61, 157, 183),
      ),
      backgroundColor: Colors.grey.shade50,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/appback.jpg"),
                fit: BoxFit.cover)
        ),
        child : Column(
          children : <Widget> [
            new Container(
              // padding:  const EdgeInsets.fromLTRB(0, 70, 0, 0),
              height:  MediaQuery.of(context).size.height*0.13,
              width :  MediaQuery.of(context).size.width * 1,
             child : Center(
               child: Text (
                 'Select Your Adress',
                 style: TextStyle(
                   fontSize: 20,
                   fontFamily: 'Liu',
                   color:  Color.fromRGBO( 61, 158, 183,1),
                 ),
               ),
             ),
              ),
            
          Container(
            height: MediaQuery.of(context).size.height * 0.53,
            width :  MediaQuery.of(context).size.width * 0.9,
            child: GoogleMap(
              markers: markers,
              mapType:type ,
              onTap: (position) {
                Marker mk1 = Marker(
                    markerId: MarkerId('1'),
                  position: position,
                );
                setState(() {
                  markers.add(mk1);
                });
              },
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Container(
            //alignment: Alignment.bottomLeft,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: "btn5",
                    onPressed: (){
                      setState(() {
                        type = type == MapType.hybrid ? MapType.normal :
                        MapType.hybrid ;
                      });
                    },
                    child: Icon(Icons.map),
                    backgroundColor: Color.fromRGBO( 61, 158, 183,1),
                  ),
                  FloatingActionButton(
                    heroTag: "btn3",
                    onPressed: () async{
                      (await _controller.future).animateCamera(CameraUpdate.zoomIn());
                    },
                    child: Icon(Icons.zoom_in),
                    backgroundColor: Color.fromRGBO( 61, 158, 183,1),
                  ),
                  FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: ()async{
                      (await _controller.future).animateCamera(CameraUpdate.zoomOut());
                    },
                    child: Icon(Icons.zoom_out),
                    backgroundColor: Color.fromRGBO( 61, 158, 183,1),
                  ),

                ],

              ),

          ),
            new Container(
              // padding:  const EdgeInsets.fromLTRB(0, 70, 0, 0),
              height:  MediaQuery.of(context).size.height*0.04,
              width :  MediaQuery.of(context).size.width * 1,

            ),
            FloatingActionButton.extended(
              heroTag: "btn2",
              label: Text("      Register      ", style: new TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: 'Liu',
              ),) ,
              onPressed: ()async{
                if(markers.length < 1)
                  print("no marker edit ");
                print(markers.last.position);
              },
              backgroundColor: Color.fromRGBO( 61, 158, 183,1),
            ),
          ],

        ),
      ),

    );
  }

}

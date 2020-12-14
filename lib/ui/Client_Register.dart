import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:MelekFlatt/http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:country_code_picker/country_code_picker.dart';





/**
 * accepts three parameters, the endpoint, formdata (except fiels),files (key,File)
 * returns Response from server
 */
Future<Response> sendForm(
    String url, Map<String, dynamic> data, Map<String, File> files) async {
  Map<String, MultipartFile> fileMap = {};
  for (MapEntry fileEntry in files.entries) {
    File file = fileEntry.value;
    String fileName = basename(file.path);
    fileMap[fileEntry.key] =
        MultipartFile(file.openRead(), await file.length(), filename: fileName);
  }
  data.addAll(fileMap);
  var formData = FormData.fromMap(data);
  Dio dio = new Dio();
  return await dio.post(url,
      data: formData, options: Options(contentType: 'multipart/form-data'));
}

/**
 * accepts two parameters,the endpoint and the file
 * returns Response from server
 */
Future<Response> sendFile(String url, File file) async {
  Dio dio = new Dio();
  var len = await file.length();
  var response = await dio.post(url,
      data: file.openRead(),
      options: Options(headers: {
        Headers.contentLengthHeader: len,
      } // set content-length
      ));
  return response;
}


/***
 ***
 ***/

class Client_Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return clientregisterState();
  }
}

class clientregisterState extends State<Client_Register> {

  Completer<GoogleMapController> _controller = Completer();
  MapType type ;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(36.901452, 10.186891),
    zoom: 10.4746,
  );
  Set<Marker> markers ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    type = MapType.hybrid;
    markers = Set.from([]) ;
  }



  TextEditingController _UserNameController = new TextEditingController();
  TextEditingController _PasswordController = new TextEditingController();
  TextEditingController _ConfirmPasswordController =
      new TextEditingController();
  TextEditingController _PhoneController = new TextEditingController();
  TextEditingController _PhotoController = new TextEditingController();
  File _image;
  final picker = ImagePicker();


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  String response = "";
  String userused = "";
  String confirmi = "" ;
  String testadduser = "";
  String adres = "";
  Color colori = Color.fromRGBO( 0, 0, 0,1) ;

  createUser() async{
    //var image = await ImagePicker.pickImage(source: ImageSource.camera);
   // final pickedFile = await picker.getImage(source: ImageSource.gallery);
    var res1 = await sendForm('http://localhost:5000/',
        {'nom': _UserNameController.text , 'password':  _PasswordController.text , 'phone' : _PhoneController.text,'adresse' : adres }, {'picture': _image});

  // print("sssssssss" + res1.toString()) ;

      if( res1.toString() == "" ){
        setState(() {
          testadduser= "matzedech" ;
          print("ok");

          

        });
      }

      else{
        testadduser= "tzed" ;
      }


//    var result = await http_post("",{
//      "nom" : _UserNameController.text ,
//      "password": _PasswordController.text,
//      "phone": _PhoneController.text,
//      "picture" : jsonEncode(_image)
//
//    });

//    if (result.ok){
//      setState(() {
//        response = result.data['response'];
//      });
//
//    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
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
          child: new Column(
            children: <Widget>[
//
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  new Container(
                    height: MediaQuery.of(context).size.height * 0.13,
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: _image == null
                        ? Center(
                        child : new Text(
                            'Select Image For Your Profile.',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Liu',
                          ),
                        ))
                        : Image.file(_image),
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width * 0.13,
                  ),
                  new Container(
                    child: new FloatingActionButton(
                      onPressed: getImage,
                      child: Icon(Icons.camera),
                      backgroundColor: Color.fromRGBO(61, 158, 183, 1),
                    ),
                  ),
                ],
              ),
              new Container(
                height: MediaQuery.of(context).size.height * 0.01,
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Container(
                width: 320.0,
                height: MediaQuery.of(context).size.height * 0.09,
                  child: Column(
                    children : <Widget>[

                      new TextField(
                        style: new TextStyle(
                          fontFamily: 'Liu',
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                        controller: _UserNameController,
                        decoration: new InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 3.0),
                            filled: true,
                            fillColor: Color.fromRGBO( 255, 255, 255,0.3),
                            icon: Icon(
                              Icons.person,
                              color: Color.fromRGBO(61, 158, 183, 1),
                              size: 35.0,
                            ),
                            hintText: 'UserName',
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0)
                                )
                            ),
                            //icon: new Icon(Icons.lock),
                            hintStyle: new TextStyle(
                              fontFamily: 'Liu',
                              fontSize: 20,
                            )
                        ),
                      ),
                      new Text(
                        userused,
                        style: TextStyle(
                          color:  Color.fromRGBO( 61, 158, 183,1),
                          fontSize: 15.3,
                          fontFamily: 'Liu',
                        ),
                      ),
                    ]

                  ),
              ),
              Container(
                width: 320.0,
                height: MediaQuery.of(context).size.height * 0.06,
                child: TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  controller: _PasswordController,
                  decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 3.0),
                      filled: true,
                      fillColor: Color.fromRGBO( 255, 255, 255,0.3),
                      icon: Icon(
                        Icons.lock,
                        color: Color.fromRGBO(61, 158, 183, 1),
                        size: 35.0,
                      ),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0)
                          )
                      ),
                      //icon: new Icon(Icons.lock),
                      hintStyle: new TextStyle(
                        fontFamily: 'Liu',
                        fontSize: 20,
                      )
                  ),
                ),
              ),
              Container(
                width: 320.0,
                height: MediaQuery.of(context).size.height * 0.09,
                child: TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  controller: _ConfirmPasswordController,
                  decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 3.0),
                      filled: true,
                      fillColor: Color.fromRGBO( 255, 255, 255,0.3),
                      icon: Icon(
                        Icons.lock,
                        color: Color.fromRGBO(61, 158, 183, 1),
                        size: 35.0,
                      ),
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0)
                          )
                      ),
                      //icon: new Icon(Icons.lock),
                      hintStyle: new TextStyle(
                        fontFamily: 'Liu',
                        fontSize: 20,
                      )
                  ),
                ),
              ),
              new Text(
                confirmi,
                style: TextStyle(
                  color:  Color.fromRGBO( 61, 158, 183,1),
                  fontSize: 15.3,
                  fontFamily: 'Liu',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget> [
                  Icon(Icons.phone,
                    color: Color.fromRGBO(61, 158, 183, 1),
                    size: 35.0,),
                  CountryCodePicker(
                    initialSelection : 'TN' ,
                    showFlag: false,

                    ) ,
                  Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: TextField(
                    style: new TextStyle(
                      fontFamily: 'Liu',
                      fontSize: 20,
                      color:colori,

                    ),
                    textAlign: TextAlign.center,
                    controller: _PhoneController,
                    decoration: new InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 3.0),
                        filled: true,
                        fillColor: Color.fromRGBO( 255, 255, 255,0.3),
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0)
                            )
                        ),
                        //icon: new Icon(Icons.lock),
                        hintStyle: new TextStyle(
                          fontFamily: 'Liu',
                          fontSize: 20,
                        ),
                    ),
                  ),
                ),
                ],
              ),
              Column(
          children : <Widget> [
            new Container(
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
            height: MediaQuery.of(context).size.height * 0.27,
            width :  MediaQuery.of(context).size.width * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.27,
                  width :  MediaQuery.of(context).size.width * 0.75,
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
                 Column(
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
              ],
            ),
          ),

//            FloatingActionButton.extended(
//              heroTag: "btn2",
//              label: Text("      Register      ", style: new TextStyle(
//              color: Colors.white,
//              fontSize: 25,
//              fontFamily: 'Liu',
//              ),) ,
//              onPressed: ()async{
//                if(markers.length < 1)
//                  print("no marker edit ");
//                print(markers.last.position);
//              },
//              backgroundColor: Color.fromRGBO( 61, 158, 183,1),
//            ),
          ],

        ),
          new Container(
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.width * 0.13,
              ),
              new Container(
                //margin: const EdgeInsets.only(left: 50.5),
                width: 320.0,
                //height: 55,
                child: new RaisedButton(
                  onPressed:
                  () async {
                    await createUser();
                    if(markers.length < 1){
                  print("no marker edit ");}
                else {print(markers.last.position);
                adres = markers.last.position.toString() ;
                }

                      if(_PasswordController.text == _ConfirmPasswordController.text){
                        if(_PhoneController.text.length == 8) {
                    if(testadduser == "matzedech" ) {
                    setState(() {
                      colori = Color.fromRGBO( 0, 0, 0,1);
                    userused="user in used";
                    });
                    }
                          else{
                          showDialog(
                              context: context,
                              builder: (context){
                                return  AlertDialog(
                                  title: Text("signUp Succeful"),
                                  content: Text("l'utilisateur a ete creer avec succee"),
                                  actions: <Widget>[
                                    FlatButton(onPressed: (){
                                      Navigator.pushNamed(context, '/');

                                    }, child: Text("Confirm"),
                                    )
                                  ],
                                );
                              }

                          );}
                        }
                        else{
                          print("okeyyxsxs");
                          setState(() {
                            confirmi=" ";
                            colori = Color.fromRGBO( 204, 0, 0,1);
                          });
                        }
                      }
                      else {
                        setState(() {

                          confirmi="password dont much ";
                        });
                      }



                    }


                  ,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(38.0),
                      side: BorderSide(color: Colors.white)

                  ),
                  child: new Text("Continue  Registration", style: new TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Liu',
                  ),
                  ),

                  color: Color.fromRGBO( 61, 158, 183,1),
                ),
              ),
            ],
          ),
        )
        );
  }
}

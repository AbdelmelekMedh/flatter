import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:MelekFlatt/http/http.dart';


class Register extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return registerState();
  }

}
class registerState extends State<Register>{
  TextEditingController _UserNameController = new TextEditingController();
  TextEditingController _PasswordController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Register",
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Liu',
          ),),
        backgroundColor: Color.fromARGB(400, 61, 157, 183),
      ),
      backgroundColor: Colors.grey.shade50,
      body: new Container(
        // alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/appback.jpg"),
                fit: BoxFit.cover)
        ),
        child: new Column(
          children: <Widget>[
            new Padding(padding: const EdgeInsets.fromLTRB(0,  5, 0, 0)),
            new Container(
              height:  MediaQuery.of(context).size.height*0.13,
              width :  MediaQuery.of(context).size.width * 1 ,
              child : Center(
              child : new Text(
                'You are ? ',
                style: TextStyle(
                  color:  Color.fromRGBO( 61, 158, 183,1),
                  fontSize: 27,
                  fontFamily: 'Liu',
                ),
              ),
              ),
            ),
            new  Container(
               //margin: const EdgeInsets.only(left: 20.5),
                height:  MediaQuery.of(context).size.height*0.33,
                width :  MediaQuery.of(context).size.width * 1 ,
               child: new RaisedButton(
                 //onPressed: (){ Navigator.pushNamed(context, '/register');},
                 onPressed: (){debugPrint('d');},
                 shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(18.0),
                     side: BorderSide(color: Colors.white)

                 ),
                 child: new Text("Service Provider ", style: new TextStyle(
                   color: Colors.white,
                   fontSize: 27,
                   fontFamily: 'Liu',
                 ),
                 ),

                 color: Color.fromRGBO( 61, 158, 183,0.5),
               ),
             ),
              Container(
                height: MediaQuery.of(context).size.height*0.33,
                width :  MediaQuery.of(context).size.width * 1 ,
                     child: new RaisedButton(
                       onPressed: (){ Navigator.pushNamed(context, '/Cregister');},
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(18.0),
                           side: BorderSide(color: Colors.white)

                       ),
                       child: new Text("Client", style: new TextStyle(
                         color: Colors.white,
                         fontSize: 27,
                         fontFamily: 'Liu',
                       ),
                       ),

                       color: Color.fromRGBO( 61, 158, 183,0.5),
                     ),
                   ),

               ],


        ),
      ),
    );
  }

}
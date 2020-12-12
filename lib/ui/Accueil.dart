import 'package:flutter/material.dart';
import 'package:i3ana/ui/Grid.dart';
import 'package:i3ana/ui/Home.dart';
import 'package:i3ana/ui/Login.dart';
import 'package:i3ana/ui/ProfilePage.dart';
import 'package:i3ana/ui/service_list.dart';


class Accueil extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return accueilState();
  }

}

class accueilState extends State<Accueil> {

  @override
  Widget build(BuildContext context) {

  return new Scaffold(

  appBar: new AppBar(
  title: new Text("Home",
  style: TextStyle(
  fontSize: 25,
  //fontFamily: 'Liu',
  ),),
    actions: <Widget>[
      Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            child: Icon(
              Icons.account_circle,
              size: 35.0,
            ),
          )
      ),
      Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Icon(
                Icons.exit_to_app,
              size: 35.0,
            ),
          )
      ),
    ],
  backgroundColor: Color.fromARGB(400, 61, 157, 183),
    automaticallyImplyLeading: false,
  ),
  backgroundColor: Colors.white,

  body: SingleChildScrollView(

    child:Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/appback.jpg"),
              fit: BoxFit.cover)
      ),

      child: Column(
          children: <Widget>[

        Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width ,

      child: Padding(
          padding: const EdgeInsets.fromLTRB(10,20,4,0),
          child: TextField(
        /*
          autofocus: false,
          cursorColor: Color.fromARGB(400, 61, 157, 183),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            hintText: 'Rechercher un service',
            border: InputBorder.none,
          */
          //autofocus: true,
          decoration: new InputDecoration(
            labelText: "Rechercher un service",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(
              ),
            ),
            //fillColor: Colors.green
          ),
          textAlign: TextAlign.center,

          keyboardType: TextInputType.text,
          style: new TextStyle(
            fontFamily: "Poppins",
        ),
        )),
        ),
        Container(
          height: 4.0,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width ,

          child: Grid(),
          padding: EdgeInsets.fromLTRB(4,2,4,0),
        ),
        Container(
          height: 4.0,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width ,
          child:
         ServiceList(),
        ),

      ]),
    ),
  ),

  );
  }

  }


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeState();
  }

}
class homeState extends State<Home>{
  TextEditingController _UserNameController = new TextEditingController();
  TextEditingController _PasswordController = new TextEditingController();
  String lyes = "yy" ;
  String phone = "ph";
  String photoo = "hj" ;

   getValue() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String stringValue = prefs.getString('keys') ;
      String phonee = prefs.getString('key') ;
      String photo = prefs.getString('photo') ;


        setState((){
          lyes = stringValue ;
          phone =phonee;
          if(photo[0]=="h")
          photoo =photo ;
          else photoo = "http://localhost:5000/" + photo.substring(8) ;
          print("///////// " + stringValue);
        });



      return stringValue;
  }

  @override
  void initState() {
    getValue() ;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
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
            new Container(

              // padding:  const EdgeInsets.fromLTRB(0, 70, 0, 0),
              height:  MediaQuery.of(context).size.height*0.27,
              width :  MediaQuery.of(context).size.width * 1,
              //color: Color.fromRGBO( 61, 157, 183,0.4) ,

              child: new Center(
                  child: new Column(
                    children: <Widget>[

                      new Container(
                        height:MediaQuery.of(context).size.height*0.05 ,
                      ),
                      //new Image.network('http://localhost:5000/image_picker_953E6535-8162-491B-BDF3-69EE89949BDC-40213-000026A53AC5708A.jpg',)
                      CircleAvatar(

                          radius: 90,
                          backgroundImage: NetworkImage(photoo)
                      )
                    ],
                  )
              ),
            ),
            new Padding(padding: const EdgeInsets.fromLTRB(0,  5, 0, 0)),
            new Text(
              '------------ Profil ------------',
              style: TextStyle(
                color:  Color.fromRGBO( 61, 158, 183,1),
                fontSize: 30.3,
                fontFamily: 'Liu',
              ),
            ),
            new Container(
              height:  MediaQuery.of(context).size.height*0.37,
              width :  MediaQuery.of(context).size.width * 0.85 ,
              //color: Color.fromRGBO( 0, 0, 0,0.1),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                 // border: Border.all(width: 5.0, color: Colors.white),
                  borderRadius:  BorderRadius.all(Radius.circular(18.0)),
                  color: Color.fromRGBO( 0, 153, 153,0.3),
                ),
            child :  Center(
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //new Padding(padding: const EdgeInsets.fromLTRB(0,  25, 0, 0)),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 35.0,
                      ),
                      new Padding(padding: const EdgeInsets.fromLTRB(0,  25, 0, 0)),
                      Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ],
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "      "+ lyes,
                        style: TextStyle(
                          color:  Color.fromRGBO( 255, 255, 255,1),
                          fontSize: 30.3,
                          fontFamily: 'Liu',
                        ),
                      ),
                      new Text(
                        "      "+phone,
                        style: TextStyle(
                          color:  Color.fromRGBO( 255, 255, 255,1),
                          fontSize: 30.3,
                          fontFamily: 'Liu',
                        ),
                      ),


                    ],
                  )


                  ]
              ),
            ),
              ),
            ),
          ],


        ),
      ),
    );

  }

}
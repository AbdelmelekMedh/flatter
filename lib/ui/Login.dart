import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:MelekFlatt/ui/Home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:MelekFlatt/http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return loginState();
  }

}
class loginState extends State<Login>{
  TextEditingController _UserNameController = new TextEditingController();
  TextEditingController _PasswordController = new TextEditingController();
  String response = "";

  bool _isLoggedIn = false;
  Map userProfile;
  String image = "";



  LoginUser() async{

    var result = await http_post("login", {
      "nom" : _UserNameController.text ,
      "password": _PasswordController.text,

    });

    print(result.data);
    if ((result.data != "password dont match" ) && (result.data != "mail invalid match" ) ){
      saveValue() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('keys', result.data['nom']);
        prefs.setString('key', result.data['phone'].toString());
        if (image == ""){
          prefs.setString('photo', result.data['picture'].toString());
        }
        else prefs.setString('photo', image);
      }
      saveValue();

      setState(() {
        response = "valide";
        print(response);
      }
       );
    }
    else{
      response = "invalide";
    }

  }

  final fbLogin = FacebookLogin();
  _loginWithFB() async {
    final result = await fbLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = json.decode(graphResponse.body);
        print(profile);
        //User u = new User(email: '${profile['email']}', );

        //pass your token and other information to your back end
        setState(() {
          // create "bool _isLoggedIn = false;"
          // a bool variable to get the user is logged in or not
           userProfile = profile;
          //create Map userProfile; to get the user details
          _isLoggedIn = true;
         // User u = new User(email: profile.email);
          return Home();
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false);
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false);
        break;
    }
  }
  _logout() {
    fbLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
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
                  height:  MediaQuery.of(context).size.height*0.33,
                  width :  MediaQuery.of(context).size.width * 1,
                  //color: Color.fromRGBO( 61, 157, 183,0.4) ,
                child: Center(
                child: new Column(
                  children: <Widget>[
                    new Container(
                      height:MediaQuery.of(context).size.height*0.07 ,
                    ),
                   new Image.asset('images/LogoLast.png',width: 350.0,height: MediaQuery.of(context).size.height*0.26),
                  ],
                )
              ),
              ),
              new Container(
               // padding:  const EdgeInsets.fromLTRB(0, 90, 0, 0),
               // color: Color.fromRGBO( 61, 157, 183,0.7),
                height:  MediaQuery.of(context).size.height*0.35,
                width :  MediaQuery.of(context).size.width * 1,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      height:MediaQuery.of(context).size.height*0.07 ,
                    ),
                  Container(
                  width: 320.0,
                    height: 55,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _UserNameController,
                      decoration: new InputDecoration(
                        filled: true,
                          fillColor: Colors.white,
                        hintText: 'Username',
                          border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(38.0)
                              )
                          ),
                       // fillColor: Colors.red,
                        //icon: new Icon(Icons.person),
                          hintStyle: new TextStyle(
                            fontFamily: 'Liu',
                            fontSize: 20,
                          )
                      ),
                    ),
                  ),
                    new Padding(padding: const EdgeInsets.fromLTRB(0,  20, 0, 0)),
                Container(
                  width: 320.0,
                  height: 55,
                    child: TextField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      controller: _PasswordController,
                      decoration: new InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                        hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(38.0)
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
                    new Padding(padding: const EdgeInsets.fromLTRB(0,  30, 0, 0)),
                     new Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            //margin: const EdgeInsets.only(left: 50.5),
                            width: 320.0,
                            height: 55,
                            child: new RaisedButton(
                              onPressed: () async {
                               await LoginUser();
                               if(response == "valide")
                                 {
                                   Navigator.pushNamed(context, '/acceuil');
                                 }
                               else {
                                 showDialog(
                                     context: context,
                                     builder: (context){
                                       return  AlertDialog(
                                         title: Text("signIn Fail"),
                                         content: Text("check your name or password"),
                                         actions: <Widget>[
                                           FlatButton(onPressed: (){
                                             Navigator.of(context).pop();

                                           }, child: Text("Confirm"),
                                           )
                                         ],
                                       );
                                     }

                                 );
                               }
                                },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(38.0),
                                  side: BorderSide(color: Colors.white)

                              ),
                              child: new Text("LOGIN", style: new TextStyle(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,//row juste case betoul fi jadwel lpartie hadhi il espace binethom
                      crossAxisAlignment: CrossAxisAlignment.start,// w hadhi espace bin fouk z louta par rapport lil case hadhika

                      children: <Widget>[
                        new Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            color:  Color.fromRGBO( 61, 158, 183,1),
                            fontSize: 15.3,
                            fontFamily: 'Liu',
                          ),
                        ),
                        new RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    text:'         New User ?',
                                    style: TextStyle(
                                      color:  Color.fromRGBO( 61, 158, 183,1),
                                      fontSize: 15.3,
                                      fontFamily: 'Liu',
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = (){Navigator.pushNamed(context, '/Cregister');}
                                )
                              ]
                          ),
                        ),

                      ],
                    ),

                    //new Padding(padding: const EdgeInsets.fromLTRB(0,  100, 0, 0)),
                  ],
                ),
              ),
              new Padding(padding: const EdgeInsets.fromLTRB(0,  60, 0, 0)),
                    new Container(
                      child: new Column(
                        children : <Widget>[
                    new Text(
                      '--------------- Or Login Using ---------------',
                      style: TextStyle(
                        color:  Color.fromRGBO( 61, 158, 183,1),
                        fontSize: 15.3,
                          fontFamily: 'Liu',
                      ),
                    ),

                          new  Center(
                              child: _isLoggedIn

                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.network(
                                    userProfile["picture"]["data"]["url"],
                                    height: 50.0,
                                    width: 50.0,
                                  ),
                                  Text(userProfile["name"]),
                                  OutlineButton(
                                    child: Text("Logout"),
                                    onPressed: () {
                                      _logout();
                                    },
                                  )
                                ],
                              )
                                  : Center(
                                child: SignInButton(
                                  Buttons.Facebook,
                                  text : "Login with Facebook",
                                  onPressed: () async {
                                  await  _loginWithFB();
                                  setState(() {
                                    _UserNameController.text = userProfile["name"] ;
                                    image = userProfile["picture"]["data"]["url"] ;
                                  });
                                  },
                                ),
                              )),
                        ],
                    )
                    ),
                  ],
                ),




        ),

    );
  }

}
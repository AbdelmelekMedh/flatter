import 'package:flutter/material.dart';
import 'package:i3ana/UI/Client_Register.dart';
import 'package:i3ana/UI/Register.dart';
import 'package:i3ana/ui/Client_Register_2.dart';
import 'package:i3ana/ui/Home.dart';
import 'package:i3ana/ui/Map.dart';
import 'package:i3ana/ui/Accueil.dart';
import 'UI/Login.dart';

void main() {
  runApp(new MaterialApp(
    title: "I3ANA",
    //home: new Login(),
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/register' : (context) => Register(),
     '/Cregister' : (context) => Client_Register(),
    // '/Cregister2' : (context) => Client_Register_2(),
     '/Home' : (context) => Home(),
     '/map' : (context) => Map(),
     '/acceuil' : (context) => Accueil(),
    },
  ));
}


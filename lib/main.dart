import 'package:flutter/material.dart';
import 'package:MelekFlatt/UI/Client_Register.dart';
import 'package:MelekFlatt/UI/Register.dart';
import 'package:MelekFlatt/ui/Client_Register_2.dart';
import 'package:MelekFlatt/ui/Home.dart';
import 'package:MelekFlatt/ui/Map.dart';
import 'package:MelekFlatt/ui/Accueil.dart';
import 'UI/Login.dart';

void main() {
  runApp(new MaterialApp(
    title: "MelekFlatt",
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


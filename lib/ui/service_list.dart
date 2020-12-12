import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:i3ana/ui/service_view.dart';

class ServiceList extends StatefulWidget {
  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  List<service> services = [
  ];

  @override
   initState()  {
    // TODO: implement initState
    super.initState();

     http.get("http://localhost:5000/getService")
        .then((http.Response response){
      List<dynamic>servicesFromServer = json.decode(response.body);
      for(int i=0; i<servicesFromServer.length;i++){
        Map<String,dynamic> serviceJ  = servicesFromServer[i]; //Chaque bloc JSON est une Voiture de type Map
        print(serviceJ);
       String  photo = "http://localhost:5000/" + serviceJ['picture'].substring(8);
        setState(() {
          services.add(service(serviceJ['nom'],serviceJ['prenom'],serviceJ['phone'],serviceJ['messervices'],photo,serviceJ['tarif']));
        });

      }
      print(">>>>>>> "+services.length.toString());
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
        itemBuilder: (context, index) {
          return ServiceView(services[index].nom, services[index].prenom, services[index].phone, services[index].typeservice, services[index].image,services[index].tarif);
        },
        itemCount: services.length,
      ),
      // body: ListView(
      //   children: [
      //     CarView("peugeot","208","Images/208.jpg"),
      //     CarView("peugeot","206","Images/bmw.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //   ],
      // ),
    );
  }
}

class service{
  String serviceId;
  String nom;
  String prenom;
  int phone;
  String typeservice;
  String image;
  int tarif;

  service(this.nom, this.prenom, this.phone, this.typeservice,
      this.image, this.tarif);

  @override
  String toString() {
    return 'service{serviceId: $serviceId, nom: $nom, prenom: $prenom, phone: $phone, typeservice: $typeservice, image: $image, tarif: $tarif}';
  }


}
import 'package:flutter/material.dart';

class ServiceView extends StatelessWidget{
  String nom;
  String prenom;
  int phone;
  String typeservice;
  String image;
  int tarif;


  ServiceView(this.nom, this.prenom, this.phone, this.typeservice,
      this.image, this.tarif);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap:() {

        },
        child: Row(
          children: [
            Image.network(
              image,
              height: 100,
              width: 100,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: <Widget> [
              Text(nom,style: TextStyle(
                color:  Color.fromRGBO( 61, 158, 183,1),
                fontSize: 15.3,
                fontFamily: 'Liu',
              ),),

            Text("  "+prenom,style: TextStyle(
              color:  Color.fromRGBO( 61, 158, 183,1),
              fontSize: 15.3,
              fontFamily: 'Liu',
            ),),
              ] ,),
                  Text(typeservice,style: TextStyle(
                    color:  Color.fromRGBO( 204, 0, 0,1),
                    fontSize: 25.3,
                    fontFamily: 'Liu',
                  ),),
                  Row(
                    children:<Widget>[ Text("+216 "+phone.toString(),style: TextStyle(
                      color:  Color.fromRGBO( 61, 158, 183,1),
                      fontSize: 15.3,
                      fontFamily: 'Liu',
                    ),),
                      Text("                               "+tarif.toString()+"DT" ,style: TextStyle(
                        color:  Color.fromRGBO( 204, 0, 0,1),
                        fontSize: 15.3,
                        fontFamily: 'Liu',
                      ),)
                    ]
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
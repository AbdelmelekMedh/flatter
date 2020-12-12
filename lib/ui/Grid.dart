import 'package:flutter/material.dart';
import 'package:i3ana/http/http.dart';

class Grid extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GridState();
  }

}



class GridState extends State<Grid>{
  List<Container>listData=new List();
  prepareList() async
  {
    for(int k=0;k<corcess.length;k++)
    {
      listData.add(Container(

        child: Hero(
          tag: "text$k",
          child: Material(
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx){
                  return Details("text$k");
                }));
              },
              child: Card(
                color: Color.fromRGBO( 255, 255, 255,1),
                child: Wrap(

                  children: <Widget>[
                    Container(
                      decoration: new BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(50.0)

                        ),
                        //icon: new Icon(Icons.lock),

                      ),
                      child: Column(

                        children: <Widget>[

                          Image.asset("images/"+corcessImg[k],
                            fit: BoxFit.fitWidth,
                            height: 160.0,
                            alignment: Alignment.center,
                            ),
                          Text(corcess[k],
                            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    )
                  ],


                ),
              ),
            ),
          ),
        ),
      ));
    }
  }
  List<String>corcess=new List();
  List<String>corcessImg=new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    corcess.add("electrician");
    corcess.add("air-conditioner");
    corcess.add("cleaner");
    corcess.add("paint");

    corcessImg.add("electrician.png");
    corcessImg.add("air-conditioner.png");
    corcessImg.add("cleaner.png");
    corcessImg.add("paint.png");
    prepareList();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.count(crossAxisCount: 2,
      children: listData,
    );
  }

}

class Details extends StatelessWidget{
  String tag;
  Details(this.tag);
  String text ;
  String nom ;



  Testaffich() async {
    if(tag=="text0")
      {
        text = "electricien";
        var result = await http_post("/getserv",{
      "messervices" : text ,


    });

    if (result.ok){
      nom = result.data['messervices'];
      }

      }
   else if(tag=="text1")
    {
      text = "air condition";
      var result = await http_post("/getserv",{
        "messervices" : text ,


      });

      if (result.ok){
        nom = result.data['messervices'];
      }
    }
    else if(tag=="text2")
    {
      text = "cleaner";
      var result = await http_post("/getserv",{
        "messervices" : text ,


      });

      if (result.ok){
        nom = result.data['messervices'];
      }
    }
    else{
      text = "paint";
      var result = await http_post("/getserv",{
        "messervices" : text ,


      });

      if (result.ok){
        nom = result.data['messervices'];
      }
    }
    }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Details Page"),),
      body: ListView(
        children: <Widget>[
          Hero(tag: tag, child: Material(
            child: Card(
              child: Container(
                  child: Text("electricien"),


              ),
            ),
          ))
        ],
      ),
    );
  }
}
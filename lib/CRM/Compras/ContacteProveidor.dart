import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuCompras.dart';
import 'package:Balewaterproject/util.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../../BackGroundPantalla.dart';



class ContacteProveidor extends StatefulWidget {
  @override
  _ContacteProveidorState createState() => _ContacteProveidorState();
}

class _ContacteProveidorState extends State<ContacteProveidor> {
  final mycontrolador = TextEditingController();
  @override
  void dispose() {
    mycontrolador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: BackGroundPantalla(

          child: new Column(
            children: <Widget>[
              Expanded(
                child: new CustomScrollView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: false,
                  slivers: <Widget>[
                    new SliverPadding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      sliver: new SliverList(
                        delegate: new SliverChildBuilderDelegate(
                              (context, index) => detallComanda(mycontrolador, context),
                          childCount: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}

Container detallComanda(TextEditingController mycontrolador, BuildContext context) {
  return Container(
    height: 750, // Se adapta a todas las pantallas
    width: 680,

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: new BorderRadius.circular(30.0),
    ),


    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 25,
        ),
        Text("Proveidor",
            style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: 18)),
        TextField(
          controller: mycontrolador,
          decoration: InputDecoration(
              hintText: "Proveidor",
              hintStyle: TextStyle(
                  color: Colors.grey, fontSize: 12.0)),
        ),
        SizedBox(
          height: 25,
        ),
        Text("Titol del correo",
            style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: 18)),
        TextField(
         // controller: mycontrolador,
          decoration: InputDecoration(
              hintText: "motiu",
              hintStyle: TextStyle(
                  color: Colors.grey, fontSize: 12.0)),
        ),
        SizedBox(
          height: 30,
        ),
        Text("Correu",
            style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: 18)),
        Padding(
          padding: const EdgeInsets.only(
              top: 6.0,
            left: 16.0,
            right: 16.0
          ),
          child: TextField(
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "text correu"),
            maxLines: 10,
           // controller: descriptionTextController,
          ),
        ),
        Container( // Boton enviar correo
          margin: EdgeInsets.only(
            top: 20.0,
              left: 70.0,
              right: 30.0
          ),
          height: 90.0,
          width: 180.0,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                RaisedButton(
                    onPressed: () {

                      Toast.show("     Correu enviat      ", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                      pushPage(context, MenuCompras());
                    },
                    textColor: Colors.white,

                    padding: const EdgeInsets.all(0.0),
                    child: Container(

                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),

                      padding: const EdgeInsets.only(
                          top: 10.0,
                          left: 30.0,
                          right: 30.0,
                          bottom: 10
                      ),
                      child: const Text(
                          'Enviar',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black)
                      ),
                    )
                )
              ]
          ),
        )
      ],
    ),
  );
}
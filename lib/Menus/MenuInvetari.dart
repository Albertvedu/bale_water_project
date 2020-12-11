
import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/CRM/Facturacion/ProveidorsFac.dart';
import 'package:Balewaterproject/CRM/Ventas/Clients.dart';
import 'package:Balewaterproject/CRM/Ventas/ComandesClient.dart';
import 'package:Balewaterproject/Menus/MenuItem.dart';
import 'package:flutter/material.dart';

import '../util.dart';
import 'BannerBaleWater.dart';
import 'MenuVendes.dart';

class MenuInventari extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(texte: "Inventari"),
            graella(context)
          ],
        ),
      ),
    );
  }

  Widget graella(BuildContext context) {
    return Container(
//        margin: EdgeInsets.only(top: 100.0, left: 20.0),
//        height: 300,
//        child: Column(
//          children: <Widget>[
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                MenuItem(page: enConstruccio(), text: "xxxxxxx",width: 130, image: "image/recollida2.jpeg" ),
//                MenuItem(page: enConstruccio(), text: "xxxxxxx", width: 130, image: "image/recollida2.jpeg"),
//              ],
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                MenuItem(page: enConstruccio(), text: "Productes", width: 130, image: "image/recollida2.jpeg"),
//                MenuItem(page: enConstruccio(), text: "xxxxxxxx",width: 130, image: "image/recollida2.jpeg"),
//              ],
//            ),
//          ],
//        )
    );
  }
}
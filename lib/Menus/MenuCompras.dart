import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/CRM/Compras/ComandesARebre.dart';
import 'package:Balewaterproject/CRM/Compras/ComandesProveidor.dart';
import 'package:Balewaterproject/CRM/Compras/ContacteProveidor.dart';
import 'package:Balewaterproject/CRM/Compras/Proveidors.dart';
import 'package:Balewaterproject/CRM/Ventas/Productes.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuItem.dart';
import 'package:flutter/material.dart';

class MenuCompras extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(texte: "Compres"),
            Expanded(child: graella(context))
          ],
        ),
      ),
    );
  }

  Widget graella(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 0.0, left: 1.0),
        height: 300,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MenuItem(page: Proveidors(), text: "Proveidors", width: 130, image: "image/proveidors.png" ),
                MenuItem(page: ComandesProveidor(), text: "Comandes", width: 130, image: "image/comandesPro.png"),
              ],
            ),
            SizedBox(height: 12.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MenuItem(page: Productes(), text: "Productes", width: 130, image: "image/productesPro.png"),
                MenuItem(page: ComandesARebre(verFactura: false, texte: "Comandes a rebre",), text: "Prod a rebre", width: 130, image: "image/productArebre.png"),
              ],
            ),
            SizedBox(height: 12.0,),
             MenuItem( page: ContacteProveidor(), text: "Contacte", width: 150, image: "image/contacte.jpeg"),

          ],
        )
    );
  }
}
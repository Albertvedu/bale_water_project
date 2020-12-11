import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/CRM/Compras/ComandesARebre.dart';
import 'package:Balewaterproject/CRM/Compras/ComandesProveidor.dart';
import 'package:Balewaterproject/CRM/Compras/ContacteProveidor.dart';
import 'package:Balewaterproject/CRM/Compras/Proveidors.dart';
import 'package:Balewaterproject/CRM/Ventas/Productes.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuItem.dart';
import 'package:flutter/material.dart';

class MenuCompras extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
        child: Column(
          children: <Widget>[
            BannerBaleWater(texte: "Compres"),
            Expanded(child: graella(context))
          ],
        ),
      ),
    );
  }

  Widget graella(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(top: 0.0, left: 0),
        height: 300,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MenuItem(page: Proveidors(), text: "Proveidors", width: 130, image: "image/proveidors.png"),
                MenuItem(page: ComandesProveidor(), text: "Comandes", width: 130, image: "image/comandesPro.png"),
                screenSize.height < 600
                    ? Container(
                        child: Row(
                        children: [
                          MenuItem( page: Productes(), text: "Productes", width: 130, image: "image/productesPro.png"),
                          MenuItem( page: ComandesARebre( verFactura: false, texte: "Comandes a rebre",), text: "Prod a rebre", width: 130, image: "image/productArebre.png"),
                          MenuItem( page: ContacteProveidor(), text: "Contacte", width: 150, image: "image/contacte.jpeg"),
                        ],
                      ))
                    : Container(),
              ],
            ),
            SizedBox(height: 12.0,
            ),
            screenSize.height > 600 ?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MenuItem(
                    page: Productes(),
                    text: "Productes",
                    width: 130,
                    image: "image/productesPro.png"),
                MenuItem(
                    page: ComandesARebre(
                      verFactura: false,
                      texte: "Comandes a rebre",
                    ),
                    text: "Prod a rebre",
                    width: 130,
                    image: "image/productArebre.png"),
              ],
            ): Container(),
            SizedBox(
              height: 12.0,
            ),
            screenSize.height > 600 ?
            MenuItem(
                page: ContacteProveidor(),
                text: "Contacte",
                width: 150,
                image: "image/contacte.jpeg")
                : Container(),
          ],
        ));
  }
}

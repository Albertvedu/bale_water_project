import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/CRM/Ventas/Balance.dart';
import 'package:Balewaterproject/CRM/Ventas/Clients.dart';
import 'package:Balewaterproject/CRM/Ventas/ComandesClient.dart';
import 'package:Balewaterproject/CRM/Ventas/Balance2.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuItem.dart';
import 'package:Balewaterproject/Mostrar/ComandesARecollir.dart';
import 'package:Balewaterproject/CRM/Ventas/Productes.dart';
import 'package:flutter/material.dart';

class MenuVendes extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(texte: "Vendes"),
            graella(context)
          ],
        ),
      ),
    );
  }
  Widget graella(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
          margin: EdgeInsets.only(
              top: screenSize.height > 600 ? 50 : 0,
              left: 1.0),
          height: 300,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MenuItem(page: Clients(), text: "Clients", width: 130, image: "image/clients.png" ),
                  MenuItem(page: Balance(quieroverBalance: false, verFactura: false, texte: "Comandes",), text: "Comandes", width: 130, image: "image/comandes.jpeg"),
                  screenSize.height < 600 ?
                      Container(
                        child: Row(
                          children: [
                            MenuItem(page: Productes(), text: "Productes", width: 130, image: "image/productes.png"),
                            MenuItem(page: Balance(quieroverBalance: true, verFactura: false, texte: "Balanç mensual"), text: "Balanç", width: 130, image: "image/balance.png"),
                          ],
                        )
                      ): Container(),
                ],
              ),
              SizedBox( height: 12.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MenuItem(page: Productes(), text: "Productes", width: 130, image: "image/productes.png"),
                  MenuItem(page: Balance(quieroverBalance: true, verFactura: false, texte: "Balanç mensual"), text: "Balanç", width: 130, image: "image/balance.png"),
                ],
              ),
            ],
          )
      ),
    );
  }
}
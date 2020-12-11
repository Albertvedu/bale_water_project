
import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/CRM/Compras/ComandesARebre.dart';
import 'package:Balewaterproject/CRM/Facturacion/ClientsFac.dart';
import 'package:Balewaterproject/CRM/Facturacion/ProveidorsFac.dart';
import 'package:Balewaterproject/CRM/Ventas/Balance.dart';
import 'package:Balewaterproject/CRM/Ventas/Clients.dart';
import 'package:Balewaterproject/CRM/Ventas/ComandesClient.dart';
import 'package:flutter/material.dart';

import '../util.dart';
import 'BannerBaleWater.dart';
import 'MenuItem.dart';
import 'MenuVendes.dart';

class MenuFactures extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(texte: "Factures"),
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
              top: screenSize.height > 600 ? 100 : 0,
              left: 1.0),
          height: 300,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MenuItem(page: Balance(quieroverBalance: false, verFactura: true,texte: "Factures client"), text: "Clients", width: 130, image: "image/clients.png" ),
                  MenuItem(page: ComandesARebre(verFactura: true, texte: "Factures proveïdors",), text: "Proveïdors", width: 130, image: "image/proveidors.png"),
                ],
              ),
//            SizedBox(height: 12.0,),
//            MenuItem(page: enConstruccio(), text: "Pagaments", width: 150, image: "image/recollida2.jpeg"),

            ],
          )
      ),
    );
  }
}
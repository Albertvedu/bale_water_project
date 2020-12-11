import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/CRM/Ventas/Balance2.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:flutter/material.dart';

class Balance extends StatelessWidget{
  bool quieroverBalance, verFactura;
  String texte;
  Balance({
    Key key,
    this.quieroverBalance,
    this.verFactura,
    this.texte}): super(key: key);

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(texte: texte),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Balance2(quieroverBalance2: quieroverBalance, verFactura: verFactura, )),
            )
          ],
        ),
      ),
    );

  }
}

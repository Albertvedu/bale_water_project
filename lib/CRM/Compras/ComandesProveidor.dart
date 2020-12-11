import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/CRM/Compras/LlistarProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../BackGroundPantalla.dart';

class ComandesProveidor extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

               // TODO aqui escollir proveidot i fer-li una comanda

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(texte: "Realitzar una comanda"),
            Expanded(child: LlistarProduct())
          ],
        ),
      ),
    );
  }

}


import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/model/Record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Datos_Firebase.dart';
import '../util.dart';
import 'DadesClient.dart';

class ComandesARecollir extends StatefulWidget{
  String coleccion;

  ComandesARecollir( {
    Key key,
    this.coleccion}): super(key: key);
  @override
  _ComandesARecollirState createState() => _ComandesARecollirState();
}
class _ComandesARecollirState extends State<ComandesARecollir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Comandes per recollir"),
              Expanded(child:
              buildBody(context, "perRecollir")
              ),
            ],
          )
      ),
    );
  }
}

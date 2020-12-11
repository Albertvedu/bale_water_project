import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Datos_Firebase.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:flutter/material.dart';

class ComandesAServir extends StatefulWidget{
  String coleccion;

  ComandesAServir( {
    Key key,
    this.coleccion}): super(key: key);
  @override
  _ComandesAServirState createState() => _ComandesAServirState();
}
class _ComandesAServirState extends State<ComandesAServir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Comandes a servir",),
              Expanded(child:
                buildBody(context, "comandesAservir")
              ),
            ],
          )
      ),
    );
  }
}

import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:flutter/material.dart';

class Presopostos extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

      return Scaffold(
        body: BackGroundPantalla(
          child:  Column(
            children: <Widget>[
              BannerBaleWater(),

            ],
          ),
        ),
      );

  }

}
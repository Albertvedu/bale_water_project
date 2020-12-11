
import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/HomePage.dart';
import 'package:Balewaterproject/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';
import 'Menus/BannerBaleWater.dart';
import 'Menus/HomePage.dart';
import 'util.dart';




class StartPage extends StatelessWidget {

  @override
  build(context) {
    return Scaffold(
      body: BackGroundPantalla(
        child: Column(
          children: <Widget>[
              BannerBaleWater(texte: ""),
              _boto(context)
        ],
      )
    )
    );
  }
}
Widget _boto(BuildContext context){
  return Container(
    height: 40,
    margin: EdgeInsets.only(top: 150, left: 20.0),
    child: RaisedButton(
      onPressed: () {
        pushPage(context, LoginPage());
      },
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
              Color(0xFF42A5F5),
            ],
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Text( "Acces Staff",
            style: TextStyle(fontSize: 20)
        ),
      ),
    ),
  );

}
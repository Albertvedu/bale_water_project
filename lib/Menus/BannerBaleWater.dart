import 'package:flutter/material.dart';

class BannerBaleWater extends StatelessWidget {
  String texte;
  BannerBaleWater( {
    Key key,
    this.texte}): super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double top = screenSize.height > 600 ? 15 : 3;
    return Container(
      margin: EdgeInsets.only(
          top: top,
          left: 40.0,
          right: 40.0,
          bottom: 3.0
      ),
      child: Column(
        children: <Widget>[
          Image.asset("image/banner.png"),
          Container(
            margin: new EdgeInsets.only(
                top: top,

            ),
            height: 25.0,
            width: 250.0,
            child: new Center(
              child: new Text(
                texte,
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.teal,
                    fontWeight: FontWeight.w900
                ),
              ),
            ),
          )

        ],
      )
    );
  }
}
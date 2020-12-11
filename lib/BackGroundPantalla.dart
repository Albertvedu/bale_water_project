import 'package:flutter/material.dart';

class BackGroundPantalla extends StatelessWidget{
  final Widget child;

  BackGroundPantalla ({@required this.child});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Scaffold(
      body: Stack(
          children: <Widget>[
            Container(
              margin:EdgeInsets.only(
                  top: 30.0,
                  right: 15.0,
                  left: 15.0
              ),
              height: screenHeight,
              width: screenWidth,
              decoration: new BoxDecoration(
                  border: Border.all(),
                  color: Colors.white,
                  boxShadow: [
                    new BoxShadow(
                        color: Color(0xFFc5cdd9),

                        offset: new Offset(10.0, 10.0),
                        blurRadius: 10.0
                    )
                  ],
                  borderRadius: new BorderRadius.circular(30.0),

                  gradient: new LinearGradient(
                      colors: [
                        Color(0xFFfcfcfc),
                        Color(0xFFebe8e8)
//                        Color(0xFFF3F4F7),
//                        Color(0xFF281236)
                      ],
                      begin: const FractionalOffset(1.0,0.1 ),
                      end: const FractionalOffset(1.0, 1)
                  )
              ),
              child: child,
            )
    ],
    ),
    );
  }

}
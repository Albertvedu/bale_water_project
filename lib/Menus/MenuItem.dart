import 'package:flutter/material.dart';
import '../util.dart';

class MenuItem extends StatelessWidget {
  Widget page;
  String text, image;
  double width;

  MenuItem({
    Key key,
    this.page,
    this.text,
    this.width,
    this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pushPage(context, page),
      child:  Card(
        borderOnForeground: true,
        elevation: 8.0,
            child: Column(
                children: <Widget>[
                  //const SectionTitle(title: 'Tappable'),
                  Image.asset(image,
                      width: 130,
                      height: 120,
                      fit:BoxFit.fill ),

                ]
            ),
          )

    );
  }
}
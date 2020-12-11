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
    final screenSize = MediaQuery.of(context).size;
    double horizontalPadding = screenSize.height > 600 ? 22 : 0;
    return GestureDetector(
      onTap: () => pushPage(context, page),
      child:  Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Card(
          borderOnForeground: true,
          elevation: 8.0,
              child: Column(
                  children: <Widget>[
                    //const SectionTitle(title: 'Tappable'),
                    Image.asset(image,
                        width: 110,
                        height: 100,
                        fit:BoxFit.fill ),

                  ]
              ),
            ),
      )

    );
  }
}
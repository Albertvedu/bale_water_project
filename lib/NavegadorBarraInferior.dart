import 'dart:io';

import 'package:flutter/material.dart';

class NavegadorBarraInferior extends StatefulWidget {
  final String initialRoute;
  final ValueChanged<String> navCallback;

  NavegadorBarraInferior({
    Key key,
    this.initialRoute: '/',
    @required this.navCallback,
  }) : super(key: key);

  @override
  _BottomNavState createState() => new _BottomNavState();
}

class _BottomNavState extends State<NavegadorBarraInferior> {
  String _currentRoute;
  final bool seleccionado= false;
  @override
  void initState() {
    super.initState();
    _currentRoute = widget.initialRoute;

  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      elevation: 12.0,
      child: new Container(
        height: 56.0,
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildButton('/',"Home", "Vendes"),
            _buildButton('/vendes', "Vendes", "Vendes"),
            _buildButton('/compres', "Compres", "Compres"),
            _buildButton('/factures',"Factures", "Factures"),
            //_buildButton('/inventari', "Invent", "Invetari"),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String namedRoute, String data, String tooltip) {
    final ThemeData theme = Theme.of(context);

    return new Flexible(
      flex: 1,
      child: new Tooltip(
        message: tooltip,
        child: new InkWell(
          focusColor: seleccionado ?
          Colors.teal : Colors.grey,
          onTap: () => onButtonTap(namedRoute, seleccionado),
          child: new Center(
            child: new Text(data,

              //color: _currentRoute == namedRoute ? theme.accentColor : theme.disabledColor,
            ),
          ),
        ),
      ),
    );
  }

  onButtonTap(String namedRoute, bool seleccionado) {
    setState(() {
      _currentRoute = namedRoute;
      seleccionado: _currentRoute = namedRoute;
    });
    widget.navCallback(_currentRoute);
  }
}
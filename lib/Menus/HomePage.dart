import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/CRM/Ventas/ComandesClient.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuCompras.dart';
import 'package:Balewaterproject/Menus/MenuFactures.dart';
import 'package:Balewaterproject/Menus/MenuInvetari.dart';
import 'package:Balewaterproject/Menus/MenuItem.dart';
import 'package:Balewaterproject/Menus/MenuVendes.dart';
import 'package:Balewaterproject/Mostrar/ComandesARecollir.dart';
import 'package:Balewaterproject/Mostrar/ComandesAServir.dart';
import 'package:Balewaterproject/NavegadorBarraInferior.dart';
import 'package:Balewaterproject/model/Record.dart';
import 'package:Balewaterproject/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'dart:convert' show base64;

import '../CRM/Ventas/Clients.dart';

final colorBackground = const Color(0xFFF3F4F7);
final colorPrimary = const Color(0xFF35465B);
final colorAccent = const Color(0xFF7576FD);
final colorGrey = const Color(0xFFA5ADB7);

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() =>  HomePageState();
}

class HomePageState extends State<HomePage> {
  final _navigatorKey =  GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bale Water',
      theme:  ThemeData(
        brightness: Brightness.light,
        backgroundColor: colorBackground,
        primaryColor: colorPrimary,
        accentColor: colorAccent,
        splashColor: colorAccent,
        disabledColor: colorGrey,
      ),
      home:  Column(
        children: <Widget>[
          Expanded(
            child: new Navigator(
              key: _navigatorKey,
              onGenerateRoute: _onGenerateRoute,
            ),
          ),
          NavegadorBarraInferior(navCallback: (String namedRoute) {
            print("Navigating to $namedRoute");
            _navigatorKey.currentState.pushReplacementNamed(namedRoute);
          }),
        ],
      ),
    );
  }
// Barra menu inferior
  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    Widget child;
    if (settings.name == '/') {
      child =  ScreenHome();
    }
    else if (settings.name == '/vendes') {
      child =  MenuVendes();
    }
    else if (settings.name == '/compres') {
      child =  MenuCompras();
    }
    else if (settings.name == '/factures') {
      child =  MenuFactures();
    }
//    else if (settings.name == '/inventari') {
//      child =  MenuInventari();
//    }

    if (child != null) {
      return  MaterialPageRoute(builder: (c) => child);
    }
    return null;
  }
}

class ScreenHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
          body: BackGroundPantalla(
            child: Column(
              children: <Widget>[
                BannerBaleWater(texte: "Home"),
                graella(context)
              ],
            ),
          )
      );
  }
}
Widget graella(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  return Expanded(
    child: Container(
        margin: EdgeInsets.only(
            top: screenSize.height > 600 ? 100 : 0,
            left: 1.0),
        height: 300,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MenuItem(page: ComandesAServir(coleccion: "comandesAservir"),  text: "", width: 130, image: "image/a_servir.png"),
                MenuItem(page: ComandesARecollir(coleccion: "perRecollir"), text: "", width: 130, image: "image/a_recollir.jpeg"),
              ],
            ),
                Expanded(child:
                _buildBody(context) // NO mostar res per pantalla pero actualitzar comandas que arriban de la Web.

                ),

          ],
        )
    ),
  );
}
Widget _buildBody(BuildContext context ) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection("comanda").snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return CircularProgressIndicator();
      return _buildList(context, snapshot.data.documents );
    },
  );

}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return
    ListView(
      padding: const EdgeInsets.only(top: 30.0),
      children: snapshot.map((data) =>
          _buildListItem(context, data)).toList(),
    );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot datos) {
  final record = Record.fromSnapshot(datos);

  if (record.servida == false) {
    _deleteFirebase(context, record, "perRecollir");
    _writeFirebase(context, record, "comanda");
    _writeFirebase(context, record, "comandesAservir");
    return Container();
  } else if (record.recollida == false) {
    _deleteFirebase(context, record, "comandesAservir");
    _writeFirebase(context, record, "comanda");
    _writeFirebase(context, record, "perRecollir");
    return Container();
  } else {
    _deleteFirebase(context, record, "perRecollir");
    return Container();
  }
}
void _deleteFirebase(BuildContext context, Record record, String coleccion) {
  Firestore.instance.collection(coleccion).document(record.id.toString())
      .delete();
}

void _writeFirebase(BuildContext context, Record record, String coleccion) {
  String a = record.dat_servei.substring(3,5);
  String b = record.dat_servei.substring(0,2);
  Firestore.instance.collection(coleccion).document(record.id.toString())
      .setData({
    'id': record.id,
    'idClient': record.idClient,
    'nom': record.nom,
    'cognoms': record.cognoms,
    'email': record.email,
    'telef': record.telef,
    'data_servei': record.dat_servei,
    'data_comanda': record.dat_comanda,
    'horas': record.horas,
    'product_id': record.product_id,
    'recollida': record.recollida,
    'servida': record.servida,
    'importComanda': record.importComanda,
    'productNom': record.product_Nom,
    'adreca': record.adreca,
    'localitat': record.localitat,
    'provincia': record.provincia,
    'cp': record.cp,
    'mes' : int.parse(a),
    'dia' : int.parse(b)});
}
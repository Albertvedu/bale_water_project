import 'package:Balewaterproject/CRM/Compras/Proveidors.dart';
import 'package:Balewaterproject/CRM/Facturacion/ClientsFac.dart';
import 'package:Balewaterproject/CRM/Facturacion/ProveidorsFac.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuCompras.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../BackGroundPantalla.dart';
import '../../util.dart';
class ComandesARebre extends StatelessWidget {
  bool verFactura;
  String texte;
  ComandesARebre({Key key, this.verFactura, this.texte}):super(key: key);
  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(texte: texte),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("comandaProveidor").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.documents.length == 0) _noComandes(context);
                  return  Expanded(
                    child: Column(
                      children: [
                        _cabecera(),
                        _list(snapshot.data.documents, verFactura),
                      ],
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
Widget _cabecera(){
  return Container(
      color: Colors.blueAccent.withOpacity(0.15),
      height: 54.0,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text("id",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: Text("Producte",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: Text("Data servei",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0
                    ),),
                ),
              ],
            ),
          ),
        ],
      )

  );
}
Widget _item( int id, String empresa, int unitats, String articulo, List<DocumentSnapshot> documents, int index) {


  return ListTile(
    leading: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(id.toString(),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0
        ),),
    ),
    title: Text(empresa,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.0
      ),
    ),
    subtitle: Text("unitats: " + unitats.toString(),
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.blueGrey,
      ),
    ),
    trailing: Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("$articulo",
          style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.w500,
            fontSize: 12.0,
          ),
        ),
      ),
    ),
  );
}
Widget _list(List<DocumentSnapshot> documents, bool verFactura) {
print("longi de docmente.............................  " + documents.length.toString());
  return Expanded(
    child: ListView.separated(
      itemCount: documents.length,
      itemBuilder: (BuildContext context, int index) {
        int id = documents[index].data['idComanda'];
        String empresa = documents[index].data['nomProveidor'] ;
        int unitats = documents[index].data['unitats'];
        String articulo = documents[index].data['dataEntrega'];
        //return _item( id, empresa, unitats, articulo, documents, index);

        if ( verFactura ) {
          return GestureDetector(
            onTap: () {
              pushPage(context, ProveidorsFac( id: id, texte: "Factures"));
            },
            child: Container(
                child:
                _item( id, empresa, unitats, articulo, documents, index)
            ),
          );
        }  else
          return GestureDetector(
            onTap: () {
              pushPage(context, ProveidorsFac( id: documents[index].data['id'], texte: "Albarà d'entrega"));
            },
            child: Container(
                child:
                _item( id, empresa, unitats, articulo, documents, index)
            ),
          );
        },

      separatorBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.blueAccent.withOpacity(0.2),
          height: 6.0,
        );
      },
    ),
  );
}
AlertDialog _noComandes(BuildContext context) {
  return AlertDialog(

    title: Text('Comandes a rebre ' ),
    content: SingleChildScrollView(

      child:
      Text('No hi ha comandes pendents ' ),
      // Text('You\’re like me. I’m never satisfied.'),

    ),
    actions: <Widget>[
      FlatButton(
        child: Text('Ok.'),
        onPressed: () {
          pushPage(context, MenuCompras());
        },
      ),
    ],
  );
}
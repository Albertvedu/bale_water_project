import 'package:Balewaterproject/Mostrar/ComandesAServir.dart';
import 'package:Balewaterproject/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Mostrar/ComandesARecollir.dart';
import 'Mostrar/DadesClient.dart';
import 'model/Record.dart';




Widget buildBody(BuildContext context, String coleccio) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection(coleccio).snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return CircularProgressIndicator();
      if (snapshot.data.documents.isEmpty)   {
        if ( coleccio == "comandesAservir") return comanServidasVacio(context, "servir");
        else return comanServidasVacio(context, "recollir");
      }
      else return buildList(context, snapshot.data.documents, coleccio );
    },
  );
}

Widget buildList(BuildContext context, List<DocumentSnapshot> snapshot, String coleccio) {
  return ListView.builder(
      padding: const EdgeInsets.only(top: 30.0),
      itemCount: snapshot.length,
      itemBuilder: (context, index){
        return buildListItem(context, snapshot[index], coleccio);
      },
    );
}

Widget buildListItem(BuildContext context, DocumentSnapshot datos, String coleccio) {
  final record = Record.fromSnapshot(datos);
  if (record.servida == false) {
    deleteFirebase(context, record, "perRecollir");
    writeFirebase(context, record, "comanda");
    writeFirebase(context, record, "comandesAservir");
    return impresioDades(context, record, coleccio);
  } else if (record.recollida == false) {
    deleteFirebase(context, record, "comandesAservir");
    writeFirebase(context, record, "comanda");
    writeFirebase(context, record, "perRecollir");
    return impresioDades(context, record, coleccio);
  } else {
    deleteFirebase(context, record, "perRecollir");
    return impresioDades(context, record, coleccio);
  }
}

void deleteFirebase(BuildContext context, Record record, String coleccion) {
  Firestore.instance.collection(coleccion).document(record.id.toString())
      .delete();
}

void writeFirebase(BuildContext context, Record record, String coleccion) {
  String a, b;
  // Retalla data er obtenir dia i mes
  if (record.dat_servei.length == 7 || record.dat_servei.length == 9) {
     a = record.dat_servei.substring(2, 4);
     b = record.dat_servei.substring(0, 1);
  }
  if (record.dat_servei.length == 8 || record.dat_servei.length == 10) {
     a = record.dat_servei.substring(3, 5);
     b = record.dat_servei.substring(0, 2);
  }
  Firestore.instance.collection(coleccion).document(record.id.toString())
      .updateData({
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
    'dia' : int.parse(b)})
      .then((_) {
//    Scaffold.of(context).showSnackBar(
//        SnackBar(content: Text('Successfully Added')));
  }).catchError((onError) {
    print(onError);
  });
}
//Widget stockProducte(BuildContext context, Record record) {
//  return StreamBuilder(
//      stream: Firestore.instance.collection("productes").document(
//          record.product_id).snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) return Text("Loading");
//        return Container(
//          width: double.maxFinite,
//          child: Padding(
//            padding: const EdgeInsets.only(top: 14, right: 5.0),
//            child: Row(
//              children: <Widget>[
//                Expanded(
//                  child: Text("Disponibles:" ,
//                      textAlign: TextAlign.start),
//                ),
//                Expanded(
//                  child: Text(snapshot.data['enAlmacen'].toString(),
//                      style: TextStyle(
//                          color: Colors.black,
//                          fontWeight: FontWeight.w500,
//                          fontSize: 14.0
//                      ),
//                      textAlign: TextAlign.end),
//
//                ),
//              ],
//            ),
//          ),
//        );
//      });
//}
Widget impresioDades(BuildContext context, Record record, String coleccio) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    height: 120.0,
    child: Container(
      decoration: new BoxDecoration(boxShadow: [
        new BoxShadow(
          color: Colors.blueAccent.withOpacity(0.2),
          blurRadius: 2.0,
        ),
      ]),
      child: Card(
          child: Row(
            children: <Widget>[
              Container(
                width: 150.0,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      lineaCard( "Comanda:" ,  record.id.toString()),
                      lineaCard("Id producte: " , record.product_id ),
                      boton(context, record, coleccio)
                    ]
                ),
              ),
              VerticalDivider(
                width: 5.0,
              ),
              Container(
                width: 165.0,
                child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      lineaCard( "Servei:" , record.dat_servei),
                      lineaCard("Lloguer: " , record.horas.toString() + " h."),
                    ]
                ),
              )
            ],
          )
      ),
    ),
  );
}

Widget lineaCard( String text_1, String text_2){
  // final screenSize = MediaQuery.of(context).size;
  return  Container(
    width: 250.0,
    //color: Colors.tealAccent,
    child: Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(

        children: <Widget>[
          Expanded(
            child: Text(text_1,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 14.0)),
          ),
          Expanded(
            child: Text(text_2,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.0
                ),
                textAlign: TextAlign.end),
          )
        ],
      ),
    ),
  );
}
AlertDialog comanServidasVacio(BuildContext context, String text) {
  return AlertDialog(
    title: Text('Comandes a ' + text),
    content: SingleChildScrollView(
      child:
      Text('No hi ha comandes per ' + text),
      // Text('You\’re like me. I’m never satisfied.'),

    ),
    actions: <Widget>[
      FlatButton(
        child: Text('Ok.'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
}
Widget boton(BuildContext context, Record record, String coleccio){
  return Container(
    margin: EdgeInsets.only(top: 10.0),
    height: 32,
    child: RaisedButton(
      onPressed: () {
        if ( coleccio == "perRecollir")
          pushPage(context, DadesClient(record: record, texte: "RECOLLIDA", texte2: "recollit", ruta: ComandesARecollir(),));
        else pushPage(context, DadesClient(record: record, texte: "SERVIDA", texte2: "servit", ruta: ComandesAServir(),));
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
        child: const Text(
            'Més dades',
            style: TextStyle(fontSize: 13)
        ),
      ),
    ),
  );
}

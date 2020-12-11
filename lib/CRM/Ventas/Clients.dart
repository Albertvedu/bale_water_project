import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/model/Record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Datos_Firebase.dart';


class Clients extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Llistat de clients",),
              Expanded(child:
              _buildBody(context, "comanda"),
              ),
            ],
          )
      ),
    );
  }

  Widget _buildBody(BuildContext context, String coleccio) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(coleccio).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        final nomsEnLaLlista = Set<String>();
        final unics = snapshot.data.documents.where((element) => nomsEnLaLlista.add(element.data["nom"] + element.data["cognoms"])).toList();

        return _buildList(context, unics, coleccio );
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot, String coleccio) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 30.0),
        itemCount: snapshot.length,
        itemBuilder: (context, index){
          return _buildListItem(context, snapshot[index], coleccio);
        },
      );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot datos, String coleccio)  {
    final record = Record.fromSnapshot(datos);
    return _mostrarDetall(context, record);
  }

  Container _mostrarDetall(BuildContext context, Record record) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: new BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.blueAccent.withOpacity(0.2),
          blurRadius: 2.0,
        ),
      ],
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              width: screenSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  lineaCard( "Id Client:" , record.idClient.toString()),
                  lineaCard( "Nom :" , record.nom ),
                  lineaCard("Cognoms: " , record.cognoms ),
                  lineaCard( "email:" , record.email),
                  lineaCard( "Tel·lefon:" , record.telef ),
                  lineaCard( "adreça:" , record.adreca ),
                  lineaCard( "localitat:" , record.localitat ),
                  lineaCard( "Provincia:" , record.provincia ),
                  lineaCard( "Data registre:" , record.dat_comanda ),


//                    Row(
//                      children: <Widget>[
//                        _btnRetroceso(context, record ),
//                        if (texte != "") _boton(context, record),
//                      ],
//                    )
                ]
              ),
            ),
          ],
        )
      ),
    );
  }

  void deleteFirebase(Record record, String coleccion) {
    Firestore.instance.collection(coleccion).document(record.id.toString()).delete();
  }

  void _writeFirebase(Record record  ) {
    // aquí no deuria haver un StreamBuilder.
    // StreamBuilder és per a mostrar dades a partir d'un stream (consulta a firebase)

    StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
        .collection('client')
        .where("cognoms", isEqualTo: record.cognoms)
        .where("nom", isEqualTo: record.nom)
        .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
        if (!data.hasData) {

          Firestore.instance.collection("client").document(record.id.toString())
            .setData({
            'idClient': record.idClient,
            'nom': record.nom,
            'cognoms': record.cognoms,
            'email': record.email,
            'provincia': record.provincia,
            'telf': record.telef,
            'data_comanda': record.dat_comanda,
            'adreca': record.adreca,
            'localitat': record.localitat,
            'cp': record.cp,})
            .then((_) {

          }).catchError((onError) {
            print(onError);
          });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}









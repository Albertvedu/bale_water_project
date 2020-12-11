import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Proveidors extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BackGroundPantalla(
        child:  Column(
          children: <Widget>[
            BannerBaleWater(texte: "Llista Proveidors"),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("proveidors").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return  Expanded(
                    child: Column(
                      children: [
                        _cabecera(),
                        _list(snapshot.data.documents),
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
  print("....................................................nn");
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
                  child: Text("Nom client",
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
          Padding(padding: const EdgeInsets.only(right: 30.0),
            child: Text("Producte",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0
              ),),
          )
        ],
      )

  );
}
Widget _item( String id, String empresa, String situada, String articulo, List<DocumentSnapshot> documents, int index) {
  print("................................................. ... dentro ...  " + documents[0].data['codigo']);

  return ListTile(
    leading: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(id,
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
    subtitle: Text(situada,
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
Widget _list(List<DocumentSnapshot> documents) {
  print("....................................................longi " + documents[0].data['codigo']);
  print("....................................................longi " + documents.length.toString());
  return Expanded(
    child: ListView.separated(
      itemCount: documents.length,
      itemBuilder: (BuildContext context, int index) {
        String id = documents[index].data['codigo'];
        String empresa = documents[index].data['empresa'] ;
        String situada = documents[index].data['situadaEn'];
        String articulo = documents[index].data['articulo'];
        print("....................................................antes return " + index.toString());
        return _item( id, empresa, situada, articulo, documents, index);
      },

      separatorBuilder: (BuildContext context, int index) {
        print("....................................................nn333");
        return Container(
          color: Colors.blueAccent.withOpacity(0.2),
          height: 6.0,
        );
      },
    ),
  );
}
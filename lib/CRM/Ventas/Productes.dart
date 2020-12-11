import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/model/RecordProducte.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class Productes extends StatefulWidget{
  String coleccion;

  Productes( {
    Key key,
    this.coleccion}): super(key: key);
  @override
  _ProductesState createState() => _ProductesState();
}
class _ProductesState extends State<Productes> {
  QuerySnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Llistat de productes",),
              Expanded(child:
              _buildBody(context, this.widget.coleccion)
              ),
            ],
          )
      ),
    );
  }

//  @override
//  void initState() {
//    //Experimento();
//  }

  Widget _buildBody(BuildContext context, String coleccio) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("productes").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        // if (snapshot.data.documents.isEmpty)  _comanServidasVacio(context);
        return _buildList(context, snapshot.data.documents, coleccio);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot,
      String coleccio) {
    return
      ListView(
        padding: const EdgeInsets.only(top: 30.0),
        children: snapshot.map((data) =>
            _buildListItem(context, data, coleccio)).toList(),
      );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot datos, String coleccio) {
    final record = RecordProducte.fromSnapshot(datos);

    return _impresioDades(context, record);
  }

  Widget _impresioDades(BuildContext context, RecordProducte record) {
    return Container(
      height: 350.0,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 80.0),
                    child: Image.network(record.imageCastle,
                        width: 200,
                        height: 80),
                  ),
                  Container(
                    width: 250.0,
                    margin: EdgeInsets.only(
                        top: 90.0,
                        left: 20.0
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,,
                      children: <Widget>[
                        Padding(padding: const EdgeInsets.symmetric(
                            horizontal: 10.0)),
                        _lineaCard("id: ", record.id.toString()),
                        _lineaCard("Nom: " , record.nomCastle),
                        _lineaCard("Proveedor: ", record.proveedor),
                        _lineaCard("Stock: ", record.stock.toString()),
                        _lineaCard("servidas: ", record.servidas.toString()),
                        _lineaCard("En Almacen: ", record.enAlmacen.toString()),
                        _lineaCard("Averiados: ", record.averiados.toString()),
                        _lineaCard("Precio Coste: ", record.precioCoste.toString()),
                        _lineaCard("Precio Alquiler: ", record.precioAlquiler.toString()),
                      ],
                    ),
                  )
                ],
              )
            ]
        ),
      ),
    );
  }
  Widget _lineaCard( String text_1, String text_2){
    // final screenSize = MediaQuery.of(context).size;
    return  Container(
      width: 250.0,
      //color: Colors.tealAccent,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(text_1,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 18.0)),
          ),
          Expanded(
            child: Text(text_2,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 16.0
                ),
                textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }
}


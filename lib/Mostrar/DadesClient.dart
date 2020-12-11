import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Mostrar/ComandesAServir.dart';
import 'package:Balewaterproject/model/Record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../BackGroundPantalla.dart';
import '../util.dart';
import 'ComandesAServir.dart';

class DadesClient extends StatelessWidget {
  Record record;
  String texte, texte2;
  Widget ruta;
  int _disponible;

  DadesClient({
    Key key,
    this.record,
  this.texte,
  this.texte2,
  this.ruta}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Detall comanda",),
              Expanded(child:
              _mostrarDetall(context, record)
              ),
            ],
          )
      ),
    );
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
                      _lineaCard( "Id Comanda:" , record.id.toString() ),
                      _lineaCard( "Id Producte:" , record.product_id ),
                      _lineaCard("Nom producte: " , record.product_Nom ),
                      _lineaCard( "Nom client:" , record.nom + " " +record.cognoms),
                      _lineaCard( "Data comanda:" , record.dat_comanda ),
                      _lineaCard( "Data servei:" , record.dat_servei ),
                      _lineaCard( "Horas:" , record.horas.toString() ),
                      _lineaCard( "Servida:" , record.servida.toString() ),
                      _lineaCard( "Recollida:" , record.recollida.toString() ),
                      _stockProducte(context, record),

                      Row(
                        children: <Widget>[
                          _btnRetroceso(context, record ),
                          texte != ""  ? _boton(context, record) : null,
                        ],
                      )
                    ]
                ),
              ),
            ],
          )
      ),
    );
  }
  Widget _btnRetroceso(BuildContext context, Record record) {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: Container(
        margin: EdgeInsets.only(left: 20.0),
        decoration: new BoxDecoration(boxShadow: [
          new BoxShadow(
            color: Colors.blueAccent.withOpacity(0.2),
            blurRadius: 5.0,
          ),
        ]),
        width: 50.0,
        // color: Colors.tealAccent,
        child: GestureDetector(
            onTap: ()=> Navigator.of(context).pop(),
            child: Icon(FontAwesomeIcons.backward)
        ),
      ),
    );
  }
  Widget _boton(BuildContext context, Record record){
    return Container(
       height: 40,
      margin: EdgeInsets.only(left: 40.0),
      child: RaisedButton(
        onPressed: () {
          if ( texte == "SERVIDA") {
            if ( _disponible > 0 )
              pushPage(context, _alertDialog(context, record));
            else
              pushPage(context, _noDisponibles(context));
          }else pushPage(context, _alertDialog(context, record));
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
          child: Text( texte,
              style: TextStyle(fontSize: 20)
          ),
        ),
      ),
    );
  }
  AlertDialog _alertDialog(BuildContext context, Record record) {
    return  AlertDialog(
        title: Text('El producte ha sigut $texte2 ?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('El producte has donará per $texte2.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok.'),
            onPressed: () {
              modificarStockProducte(context, record);
              _cambiarEstatComanda(context, record);
              pushPage(context, ruta);
              // _buildBody(context);
              //thisCard.currentState.toggleCard();
            },
          ),
          FlatButton(
            child: Text('Cancel.'),
            onPressed: () {
              Navigator.of(context).pop();

            },
          ),
        ],

    );
  }
  Widget _lineaCard( String text_1, String text_2){
    // final screenSize = MediaQuery.of(context).size;
    return  Container(
      width: double.maxFinite,
      //color: Colors.tealAccent,
      child: Padding(
        padding: const EdgeInsets.all( 10.0),
        child: Row(

          children: <Widget>[
            Expanded(
              child: Text(text_1,
                  textAlign: TextAlign.start),
            ),
            Expanded(
              child: Text(text_2,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0
                  ),
                  textAlign: TextAlign.end),
            )
          ],
        ),
      ),
    );
  }
  //Lee de Firebase disponible de producto en almacén
  Widget _stockProducte(BuildContext context, Record record) {
    print("--------------------------------------------------------- id ---- " + record.product_id);
    return StreamBuilder(
        stream: Firestore.instance.collection("productes").document(
            record.product_id).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text("Loading");
          _disponible = snapshot.data['enAlmacen'];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Disponibles en almacén: " + snapshot.data['enAlmacen'].toString()),
          );
        });
  }
  void modificarStockProducte(BuildContext context, Record record) {
    if (texte == "SERVIDA"){
      Firestore.instance.collection("productes")
          .document(record.product_id)
          .updateData({"enAlmacen": FieldValue.increment(-1)});
    }
    else {
      Firestore.instance.collection("productes")
          .document(record.product_id)
          .updateData({"enAlmacen": FieldValue.increment(1)});
    }
  }
// Un pedido servido se pasa a estado servido
  void _cambiarEstatComanda(BuildContext context, Record record) {
    if (texte == "SERVIDA") {
      Firestore.instance.collection("comanda").document(record.id.toString())
          .updateData({
        'servida': record.servida = true,
      });
    }
    else {
      Firestore.instance.collection("comanda").document(record.id.toString())
          .updateData({
        'recollida': record.recollida = true,
        'servida': record.servida = true,
      });
    }
  }
  AlertDialog _noDisponibles(BuildContext context) {
    return AlertDialog(
      title: Text('No hi unitats diponilbes'),
      content: SingleChildScrollView(
        child:
        Text(''),
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
}

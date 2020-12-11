import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuCompras.dart';
import 'package:Balewaterproject/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../BackGroundPantalla.dart';

class RegistrarComanda extends StatefulWidget {
  String productId;
  String nomProducte, proveidor;
  int unitats;

  RegistrarComanda({ Key key,
    this.productId,
    this.nomProducte,
    this.proveidor,
    this.unitats}):super (key: key);

  @override
  _RegistrarComandaState createState() => _RegistrarComandaState();
}

class _RegistrarComandaState extends State<RegistrarComanda> {

  @override
  void initState() {
    print(
        " ..............................................................   metodo init.. coamnda escrita  " +
            widget.unitats.toString());
    _writeComandaFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Comandes proveidor",),
              _comandaEnviada(context),
            ],
          )
      ),
    );
  }

  void _writeComandaFirebase() async {
    String mesEntrega;
    var idComanda = (await Firestore.instance.collection("comandaProveidor")
        .getDocuments()).documents.length + 1;
    var preu = (await Firestore.instance.collection("productes").document(
        widget.productId).get()).data["precioCoste"];
    // var nomProveidor = (await Firestore.instance.collection("proveidors").document(widget.productId).get()).data["empresa"];
    var dia = DateTime
        .now()
        .day;
    var mes = DateTime
        .now()
        .month;
    var any = DateTime
        .now()
        .year;
    var dataComanda = dia.toString() + '-' + mes.toString() + '-' +
        any.toString();
    if (mes == 12)
      mesEntrega = dia.toString() + '/' + 1.toString() + '/' + any.toString();
    else
      mesEntrega = mes.toString();
    var dataEntrega = dia.toString() + '/' + mesEntrega + '/' + any.toString();
    Firestore.instance.collection("comandaProveidor").document(idComanda
        .toString()) // amb .add( en comptes de .setData ) es pot aconseguir id automatic a FireBase, pero no es fiable
        .setData({
      'idComanda': idComanda,
      'nomProducte': widget.nomProducte,
      'idProducte': widget.productId,
      'nomProveidor': widget.proveidor,
      'dataComanda': dataComanda,
      'dataEntrega': dataEntrega,
      'unitats': widget.unitats.toString(),
      'preuUnitat': preu,
      'preuTotal': (preu) * widget.unitats});
  }

  AlertDialog _comandaEnviada(BuildContext context) {
    return AlertDialog(
      title: Text('Comande enviada '),
      content: SingleChildScrollView(
        child:
        Text('Rebràs confirmació del proveidor '),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok.'),
          onPressed: () {
            _sumaCompraAMagatzem(context);
            pushPage(context, MenuCompras());
          },
        ),
      ],
    );
  }


  void _sumaCompraAMagatzem(BuildContext context) async {

    Firestore.instance.collection("productes")
        .document(widget.productId)
        .updateData({"enAlmacen": FieldValue.increment(widget.unitats)});
  }
}
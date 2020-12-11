import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecordProducte {
  final String id, nomCastle,imageCastle, proveedor;
  var stock, enAlmacen, servidas, averiados;
  var precioCoste, precioAlquiler;

  final DocumentReference reference;

  RecordProducte.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['id'] != null),
        assert(map['nomCastle'] != null),
        assert(map['imageCastle'] != null),
        assert(map['proveedor'] != null),
        assert(map['stock'] != null),
        assert(map['enAlmacen'] != null),
        assert(map['servidas'] != null),
        assert(map['averiados'] != null),
        assert(map['precioCoste'] != null),
        assert(map['precioAlquiler'] != null),
        id = map['id'],
        nomCastle = map['nomCastle'],
        proveedor = map['proveedor'],
        stock = map['stock'],
        enAlmacen = map['enAlmacen'],
        servidas = map['servidas'],
        averiados = map['averiados'],
        precioCoste = map['precioCoste'],
        precioAlquiler = map['precioAlquiler'],
        imageCastle = map['imageCastle'];


  RecordProducte.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$id:$nomCastle>";
}
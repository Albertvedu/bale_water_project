import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Record {
  final String nom, cognoms, product_id, product_Nom, email, telef, provincia;
  final String dat_servei, dat_comanda, adreca, localitat;
  final int id, idClient, horas, dia, mes, importComanda, cp ;
  bool recollida, servida;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['id'] != null),
        assert(map['idClient'] != null),
        assert(map['nom'] != null),
        assert(map['cognoms'] != null),
        assert(map['email'] != null),
        assert(map['telef'] != null),
        assert(map['recollida'] != null),
        assert(map['servida'] != null),
        assert(map['data_servei'] != null),
        assert(map['data_comanda'] != null),
        assert(map['product_id'] != null),
        assert(map['horas'] != null),
        assert(map['mes'] != null),
        assert(map['dia'] != null),
        assert(map['importComanda'] != null),
        assert(map['productNom'] != null),
        assert(map['adreca'] != null),
        assert(map['localitat'] != null),
        assert(map['provincia'] != null),
        assert(map['cp'] != null),
        id = map['id'],
        idClient = map['idClient'],
        nom = map['nom'],
        cognoms = map['cognoms'],
        email = map['email'],
        telef = map['telef'],
        recollida = map['recollida'],
        horas = map['horas'],
        product_id = map['product_id'],
        dat_servei = map['data_servei'],
        dat_comanda= map['data_comanda'],
        servida = map['servida'],
        product_Nom = map['productNom'],
        importComanda = map['importComanda'],
        adreca = map['adreca'],
        localitat = map['localitat'],
        provincia = map['provincia'],
        cp = map['cp'],
        mes = map['mes'],
        dia = map['dia'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$nom:$cognoms>";
}
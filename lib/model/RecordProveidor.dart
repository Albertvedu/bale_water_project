import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecordProveidor {
  final String idProducte, nomProducte;
  final String nomProveidor, dataComanda, dataEntrega;
  int preuUnitat, preuTotal, idComanda, unitats;

  final DocumentReference reference;

  RecordProveidor.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['idComanda'] != null),
        assert(map['idProducte'] != null),
       // assert(map['idProveidor'] != null),
        assert(map['nomProducte'] != null),
        assert(map['nomProveidor'] != null),
        assert(map['dataComanda'] != null),
        assert(map['dataEntrega'] != null),
        assert(map['preuUnitat'] != null),
        assert(map['preuTotal'] != null),
        assert(map['unitats'] != null),

        idComanda = map['idComanda'],
        idProducte = map['idProducte'],
        //idProveidor = map['idProveidor'],
        nomProducte = map['nomProducte'],
        nomProveidor = map['nomProveidor'],
        dataComanda = map['dataComanda'],
        dataEntrega = map['dataEntrega'],
        unitats = map['unitats'],
        preuUnitat = map['preuUnitat'],
        preuTotal = map['preuTotal'];


  RecordProveidor.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$idComanda:$idProducte>";
}
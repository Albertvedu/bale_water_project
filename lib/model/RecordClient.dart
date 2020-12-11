//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//
//class RecordClient {
//  final String nom, cognoms,email, provinciaC,telf;
//  final String dat_comandaC, adreca, localitat;
//  final int idClient, cp ;
//
//  final DocumentReference reference;
//
//  RecordClient.fromMap(Map<String, dynamic> map, {this.reference})
//      : assert(map['idClient'] != null),
//        assert(map['nom'] != null),
//        assert(map['cognoms'] != null),
//        assert(map['email'] != null),
//        assert(map['provincia'] != null),
//        assert(map['telf'] != null),
//        assert(map['data_comanda'] != null),
//        assert(map['adreca'] != null),
//        assert(map['localitat'] != null),
//        assert(map['cp'] != null),
//        idClient = map['idClient'],
//        nom = map['nom'],
//        cognoms = map['cognoms'],
//        email = map['email'],
//        provincia = map['mes'],
//        telf = map['telf'],
//        dat_comanda= map['data_comanda'],
//        adreca = map['adreca'],
//        localitat = map['localitat'],
//        cp = map['cp'];
//
//  RecordClient.fromSnapshot(DocumentSnapshot snapshot)
//      : this.fromMap(snapshot.data, reference: snapshot.reference);
//
//  @override
//  String toString() => "RecordClient<$nom:$cognoms>";
//}
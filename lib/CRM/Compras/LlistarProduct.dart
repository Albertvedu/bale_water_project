import 'package:Balewaterproject/CRM/Compras/ComandesProveidor.dart';
import 'package:Balewaterproject/CRM/Compras/GestionarComanda.dart';
import 'package:Balewaterproject/Menus/HomePage.dart';
import 'package:Balewaterproject/util.dart';
import 'package:flutter/material.dart';


class LlistarProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return new StuffInTiles(listOfTiles[index], context);
        },
        itemCount: listOfTiles.length,
      ),
    );

  }
}

class StuffInTiles extends StatelessWidget {
  final MyTile myTile;
  final BuildContext context;
  StuffInTiles(this.myTile, this.context);

  @override
  Widget build(BuildContext context) {
    return _buildTiles(myTile );
  }

  Widget _buildTiles(MyTile t) {
    if (t.children.isEmpty)
      return new ListTile(
          dense: true,
          enabled: true,
          isThreeLine: false,
          onLongPress: () => print("long press"),
          onTap: () => pushPage(context, GestionarComanda(productId: t.id, title: t.title,proveidor: t.subtitle, preu: t.preu)),
          subtitle: new Text(t.subtitle),
          leading: new Text(t.id),
          selected: true,
          trailing: new Text(t.preu + ",00e."),
          title: new Text(t.title,  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.blueAccent)));

    return new ExpansionTile(
      key: new PageStorageKey<int>(3),
      title: new Text(t.title),
      children: t.children.map(_buildTiles).toList(),
    );
  }
}

class MyTile {
  String title, subtitle, id, preu;
  List<MyTile> children;
  MyTile(this.title, this.subtitle, this.id, this.preu,[this.children = const <MyTile>[]]);
}

List<MyTile> listOfTiles = <MyTile>[
  new MyTile(
    'Triar un Producte per fer la comanda', '', '','',  // 4 parámetres
    <MyTile>[
      new MyTile('Salta Bolas', 'Euro Hinchable', 'SB-015', '2500'),
      new MyTile('Rocódromo','Hinchables España', 'RT-005', '2900' ),
      new MyTile('Tobogán', 'Amazon', 'FB-055', '2500'),
      new MyTile('Fútbol burbuja', 'JB-Hinchables', 'FB-001', '360'),
      new MyTile('Turbina inflador', 'Amazon', 'TB-005', '299'),
    ],


  ),

];



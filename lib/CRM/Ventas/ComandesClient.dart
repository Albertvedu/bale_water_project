
import 'package:Balewaterproject/CRM/Facturacion/ClientsFac.dart';
import 'package:Balewaterproject/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'GraphWidget.dart';

class ComandesClient extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  bool verFactura;

  ComandesClient({Key key, this.documents, this.verFactura}):super(key: key);

  @override
  _ComandesClientState createState() => _ComandesClientState();
}

class _ComandesClientState extends State<ComandesClient> {
  @override
  Widget build(BuildContext context) {
    return Expanded(

      child: Column(
        children: <Widget>[
          _cabecera(),
          _list(widget.verFactura),
        ],
      ),
    );
  }
  Widget _cabecera(){
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
            ),
          ],
        )

    );
  }
  Widget _item( int id, String name, String productId, String value) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(id.toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0
          ),),
      ),
      title: Text(name,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0
        ),
      ),
      subtitle: Text(productId,
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
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("$value",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text("Cobrada",
                style: TextStyle(

                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _list(bool verFactura) {
    return Expanded(
      child: ListView.separated(
        itemCount: widget.documents.length,
        itemBuilder: (BuildContext context, int index) {
          var id = widget.documents[index].data['id'];
          var producte = widget.documents[index].data['productNom'];
          String  client = widget.documents[index].data['nom'] + " " + widget.documents[index].data['cognoms'];
          String dataServei = (widget.documents[index].data['data_servei']);
          if ( verFactura ) {
            return GestureDetector(
              onTap: () {
                pushPage(context, ClientsFac(texte: "Factura", id: widget.documents[index].data['id']));
              },
              child: Container(
                  child:
                  _item(id, client, producte, dataServei)
              ),
            );
          }else
            return GestureDetector(
              onTap: () {
                pushPage(context, ClientsFac(texte: "Pro-forma", id: widget.documents[index].data['id']));
              },
              child: Container(
                  child:
                  _item(id, client, producte, dataServei)
              ),
            );

        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.blueAccent.withOpacity(0.2),
            height: 6.0,
          );
        },
      ),
    );
  }
}
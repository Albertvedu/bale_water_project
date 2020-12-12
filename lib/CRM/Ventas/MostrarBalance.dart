
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'GraphWidget.dart';

class MostrarBalance extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  final double total;
  final List<double> perDay;

  // Constructor bien curioso
  // en el mismo constructor recibe el documento leido en Firebase
  // pasa a map el contenido de "importComanda"
  // y esos importe los va recorriendo con el método .fold()
  // teniendo en el map el valor anterior y el actual leido
  // y luego los suma...  Cojonudo
  // Luego hace un calculo de importe por dia,
  // Para calcular si el mes tiene 30 o 31 dias tiene el método en Utils..
  MostrarBalance({Key key, days, this.documents})
      : total = documents.map((doc) => doc['importComanda'])
            .fold(0.0, (a, b) => a + b),
        perDay = List.generate(days, (int index) {
          return documents.where((doc) => doc['dia'] == (index + 1))
              .map((doc) => doc['importComanda'])
              .fold(0.0, (a, b) => a + b);
        }),
        super(key: key);

  @override
  _MostrarBalanceState createState() => _MostrarBalanceState();
}

class _MostrarBalanceState extends State<MostrarBalance> {
  // @override
  // Widget build(BuildContext context) {
  //   return Expanded(
  //
  //     child: Column(
  //       children: <Widget>[
  //         _expenses(),
  //         _graph(),
  //         Container(
  //           color: Colors.blueAccent.withOpacity(0.15),
  //           height: 24.0,
  //         ),
  //       _list(),
  //       ],
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    print("altura.................................................................." + screenSize.height.toString()+ screenSize.width.toString());
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 290.0,
              height: screenSize.height
              ,
              child: Expanded(
                child: Column(
                  children: [
                    _expenses(),
                    _graph(),
                    screenSize.height > 600 ?
                        _list() : Container(),
                  ],
                ),
              ),
            ),
            screenSize.height < 600 ?
            Container(
              width: 300,
              height: screenSize.height,
              child:   _list(),
            ): Container(),
          ],

      ),
    );
  }
  Widget _expenses() {
    return Column(
      children: <Widget>[
        Text("€${widget.total.toStringAsFixed(2)}",// dos decimals
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        Text("Total vendes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

  Widget _graph() {
    return Container(
      height: 120.0,
      child: GraphWidget(
        data: widget.perDay,
      ),
    );
  }

  Widget _item( int id, String name, String productId, double value) {
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("€$value",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _list() {
    return Expanded(
      child: ListView.separated(
        itemCount: widget.documents.length,
        itemBuilder: (BuildContext context, int index) {
          var id = widget.documents[index].data['id'];
          var producte = widget.documents[index].data['productNom'];
           String  proId = widget.documents[index].data['product_id'];
          double preu = (widget.documents[index].data['importComanda']).toDouble();
          return _item( id, producte, proId, preu);
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
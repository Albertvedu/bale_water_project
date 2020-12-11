import 'package:Balewaterproject/CRM/Ventas/ComandesClient.dart';
import 'package:Balewaterproject/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'MostrarBalance.dart';

class Balance2 extends StatefulWidget {
  bool quieroverBalance2, verFactura;
  Balance2({
  Key key,
  this.quieroverBalance2, this.verFactura}): super(key: key);
  @override
  _Balance2State createState() => _Balance2State();
}

class _Balance2State extends State<Balance2> {
  Stream<QuerySnapshot> _query;
  PageController _controller;
  int currentPage = 3;
  @override
  void initState() {
    super.initState();

    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.3,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Scaffold(
          body:Column(
            children: <Widget>[
              _selector(),
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('comanda')
                    .where("mes", isEqualTo: currentPage + 1)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
                  if (data.hasData) {
                    if (widget.quieroverBalance2) return MostrarBalance( days: daysInMonth(currentPage + 1), documents: data.data.documents);
                    else return ComandesClient( documents: data.data.documents, verFactura: widget.verFactura,);
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Mesos del any
  Widget _pageItem(String name, int position) {
    var _alignment;
    final selected = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
    );
    final unselected = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      color: Colors.blueGrey.withOpacity(0.4),
    );
    //Aliniar el mes del any el menor a la esquerra i major a la dreta
    if (position == currentPage) {
      _alignment = Alignment.center;
    } else if (position > currentPage) {
      _alignment = Alignment.centerRight;
    } else {
      _alignment = Alignment.centerLeft;
    }

    return Align(
      alignment: _alignment,
      child: Text(
        name,
        style: position == currentPage ? selected : unselected,
      ),
    );
  }

  Widget _selector() {
    return SizedBox.fromSize(
      size: Size.fromHeight(30.0),
      child: PageView(
        onPageChanged: (newPage) {
          setState(() {
            currentPage = newPage;
            _query = Firestore.instance
                .collection('comanda')
                .where("mes", isEqualTo: currentPage + 1)
                .snapshots();
          });
        },
        controller: _controller,
        children: <Widget>[
          _pageItem("Gener", 0),
          _pageItem("Febrer", 1),
          _pageItem("Març", 2),
          _pageItem("Abril", 3),
          _pageItem("Maig", 4),
          _pageItem("Juny", 5),
          _pageItem("Juliol", 6),
          _pageItem("Agost", 7),
          _pageItem("Setembre", 8),
          _pageItem("Octubre", 9),
          _pageItem("Novembre", 10),
          _pageItem("Decembre", 11),
        ],
      ),
    );
  }
}
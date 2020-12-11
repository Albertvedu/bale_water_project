
import 'package:Balewaterproject/CRM/Compras/RegistrarComanda.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/MenuCompras.dart';
import 'package:Balewaterproject/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../BackGroundPantalla.dart';
import '../../Datos_Firebase.dart';

class GestionarComanda extends StatefulWidget {
  String productId, title,proveidor, preu;

  GestionarComanda( {Key key,  this.productId, this.title,this.proveidor, this.preu}): super(key: key);

  @override
  _GestionarComandaState createState() => _GestionarComandaState();
}

class _GestionarComandaState extends State<GestionarComanda> {
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundPantalla(
          child: Column(
            children: <Widget>[
              BannerBaleWater(texte: "Detall comanda",),
              Expanded(child:
              _ferComanda(context, widget.productId, widget.title, widget.proveidor, myController, widget.preu)
              ),
            ],
          )
      ),
    );
  }
}

Widget _ferComanda(BuildContext context, String productId, String title, String proveidor, TextEditingController myController, String preu){
  final _formKey = GlobalKey<FormState>();
  final _unitats = TextEditingController();
  return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 50.0,
                  right: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _mostrar_Producte(title),
                    _lectura_Unitats(myController),
                    _mostrar_PreuUnitat(preu),
                    _boto_EnviarComanda(_formKey, context, productId, title, proveidor, myController),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
  );
}

TextField _mostrar_Producte(String title) {
  return TextField(
      decoration: InputDecoration(
        // helperText: "Producte", hoverColor: Colors.blueAccent,
        labelText: title,

      ),
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Colors.blueAccent)
  );
}

Container _mostrar_PreuUnitat(String preu) {
  return Container(
      margin: EdgeInsets.only(top: 35.0),
      child: Text("Preu unitat: " + preu));
}

Container _lectura_Unitats(TextEditingController myController) {
  return Container(
    margin: EdgeInsets.only(top: 35.0),
    child: TextFormField(
      controller: myController, // per obtenir valor del texfield i despres pasarlo a Int
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'unitats...',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Si us plau inserta una quantitat ';
        }
        return null;
      },
    ),
  );
}

Container _boto_EnviarComanda(GlobalKey<FormState> _formKey, BuildContext context, String productId, String title, String proveidor, TextEditingController myController) {
  return Container(
    margin: EdgeInsets.only(
        top: 60.0,
        left: 30.0,
        right: 30.0
    ),
    height: 90.0,
    width: 340.0,
    child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  pushPage(context, RegistrarComanda(productId: productId, nomProducte: title, proveidor: proveidor, unitats: int.parse(myController.text)));
                }
//}
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

                padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 30.0,
                    right: 30.0,
                    bottom: 10
                ),
                child: Center(
                  child: const Text(
                      'Enviar comanda',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black)
                  ),
                ),
              )
          )
        ]
    ),
  );
}



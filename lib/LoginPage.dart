import 'package:Balewaterproject/BackGroundPantalla.dart';
import 'package:Balewaterproject/Menus/BannerBaleWater.dart';
import 'package:Balewaterproject/Menus/HomePage.dart';
import 'package:Balewaterproject/util.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';



final _auth = FirebaseAuth.instance;


class LoginPage extends StatefulWidget {
  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  build(context) {
    return Scaffold(
      body: BackGroundPantalla(
        child: Column(
          children: <Widget>[
            BannerBaleWater(texte: "Login staff"),
            Expanded(child:  Form(
              key: _formKey,
              child: ListView(
                children: [

                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email',
                        hintText: 'test@test.com'),
                    // validator: (value) {
                    //   if (value.isEmpty) return 'Please enter your email';
                    //   return null;
                    // },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password',
                    hintText: '12345678'),
                    // validator: (value) {
                    //   if (value.isEmpty) return 'Please enter your password';
                    //   return null;
                    // },
                  ),
                  RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _signInWithEmailAndPassword();
                      }
                    },
                    child: Text("Offline for testing, press login\n                      LOGIN"),
                  ),
                ],
              ),
            ),
            )
          ],
        )

      ),
    );
  }

  void _signInWithEmailAndPassword() async {
    // final user = (await _auth.signInWithEmailAndPassword(
    //   email: _emailController.text,
    //   password: _passwordController.text,
    // )).user;

   // if (user != null) {
      pushPage(context, HomePage());
   // }
  }
}
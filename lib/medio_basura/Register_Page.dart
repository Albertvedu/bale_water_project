import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Home.dart';
import '../util.dart';

final _auth = FirebaseAuth.instance;

class RegisterPage extends StatefulWidget {
  @override
  createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  build(context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Text("REGISTER"),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value.isEmpty) return 'Please enter your email';
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value.isEmpty) return 'Please enter your password';
                return null;
              },
            ),
            RaisedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _register();
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  void _register() async {
    final user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )).user;

    if (user != null) {
      pushPage(context, Home());
    }
  }
}
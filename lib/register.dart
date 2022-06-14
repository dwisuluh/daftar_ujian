// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterState');
  final _email = TextEditingController();
  final _name = TextEditingController();
  final _password = TextEditingController();
  bool? showSpinner = false;

  Widget _buildWidget() {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
          Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Container(
              width: 150,
              height: 150,
              child: Image.asset('asset/images/UTDI-logo.png'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: TextFormField(
            controller: _email,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
              hintText: "Entri user with email",
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter your emaul address to continue...';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: TextFormField(
            controller: _password,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              hintText: "Entri Password",
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter your password';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: TextFormField(
              controller: _name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                hintText: "Entri full Name",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your account name';
                }
                return null;
              }),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        Navigator.pop(context);
                      },
                      style:
                          ElevatedButton.styleFrom(primary: Colors.redAccent),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 18),
                      )),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: _email.text,
                                    password: _password.text);
                            await newUser.user!.updateDisplayName(_name.text);
                            if (newUser != null) {
                              Navigator.pushNamed(context, 'login');
                            }
                          } catch (e) {
                            print(e);
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 18),
                      )),
                ])),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Registration'),
        backgroundColor: Colors.blue[900],
        automaticallyImplyLeading: false,
      ),
      body: ModalProgressHUD(child: _buildWidget(), inAsyncCall: showSpinner!),
    );
  }
}

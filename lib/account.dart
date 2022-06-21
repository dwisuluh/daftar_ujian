import 'dart:math';

import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'editAccount.dart';

//class ketika tombol jadwal di klik
class Akun extends StatefulWidget {
  @override
  _AkunState createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        backgroundColor: Colors.blue[900],
        leading: Icon(Icons.supervised_user_circle_outlined),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Row(children: <Widget>[
            Container(
                padding: EdgeInsets.all(5.0),
                child: Card(
                    child: Image.asset(
                  'asset/images/student-icon.jpeg',
                  height: 100,
                  width: 100,
                  fit: BoxFit.fitWidth,
                ))),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Card(
                semanticContainer: true,
                child: Text(
                  'Dwi Suluh Pribadi',
                ),
                margin: EdgeInsets.all(5.0),
              ),
              constraints:
                  BoxConstraints(maxWidth: 350, minWidth: 270, minHeight: 100),
            )
          ])
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => editAccount()),
          );
        },
        child: const Icon(Icons.edit),
        backgroundColor: (Colors.green[800]),
      ),
    );
  }
}

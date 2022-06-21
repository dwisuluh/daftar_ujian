import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class editAccount extends StatefulWidget {
  @override
  _editAccount createState() => _editAccount();
}

class _editAccount extends State<editAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Data Diri"),
        backgroundColor: Colors.blue[900],
      ),
    );
  }
}

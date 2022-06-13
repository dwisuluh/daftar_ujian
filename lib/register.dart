import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Register extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? name;
  String? dateBirth;
  String? password;
  bool? showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

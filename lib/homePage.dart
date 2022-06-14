import 'package:flutter/material.dart';
import 'package:pendaftaran_ujian/main.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Home.dart';
import 'testRegistration.dart';
import 'schedule.dart';
import 'ToList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List navigasi
  final pages = [Home(), DaftarUjian(), Catatan(), Akun()];

  int selectedIndex = 0;

//method ketika tombol navigasi di klik
  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.app_registration_outlined),
              label: 'Daftar Ujian'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Catatan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.verified_user), label: 'Account'),
        ],
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.blue[900],
        onTap: onTap,
      ),
      body: pages.elementAt(selectedIndex),
    );
  }
}

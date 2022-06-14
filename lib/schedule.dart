import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

//class ketika tombol jadwal di klik
class Akun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Ujian'),
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.calendar_month_outlined),
        ),
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
      // drawer: buildDrawer(context),
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading:
                  Image(image: AssetImage('asset/images/student-icon.jpeg')),
              title: Text('Dwi Suluh Pribadi'),
              subtitle: Text('195411132'),
            ),
            const Text('saat ini jadwal ujian anda belum ada.')
          ],
        ),
      ),
    );
  }
}

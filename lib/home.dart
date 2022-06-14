import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

//Class home ketika navigasi home di klik
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.home),
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
      body: Card(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading:
                  Image(image: AssetImage('asset/images/student-icon.jpeg')),
              title: Text('Dwi Suluh Pribadi'),
              subtitle: Text('195411132'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('DETAIL'),
                  onPressed: () {
                    action(context);
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }

//alert ketika tombol detail di klik
  void action(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text('Status Pengajuan Jadwal'),
      content: Text(
          'Saudara belum mengajukan jadwal ujian, silahkan klik daftar ujian.'),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}

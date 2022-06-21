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
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.supervised_user_circle_outlined),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => editAccount()),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

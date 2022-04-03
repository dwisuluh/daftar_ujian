import 'package:flutter/material.dart';
import 'Beranda.dart'; // import file beranda.dart supaya bisa dipanggil

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pendaftaran Ujian'),
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                  child: Container(
                width: 240,
                height: 240,
                child: Image.asset('asset/images/UTDI-logo.png'),
              )),
            ),
            Padding(
              // field inputan email
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Masukan Email students'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value.toString().isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                  }),
            ),
            const Padding(
              // field inputan password
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            Container(
              // tombol login
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ketika tombol login di klik
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              Beranda())); // routing ke halaman beranda atau ke file beranda
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pendaftaran_ujian/main.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List navigasi
  final pages = [Home(), DaftarUjian(), Jadwal()];

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
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule), label: 'Jadwal Ujian'),
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

Widget buildDrawer(BuildContext context) {
  final _auth = FirebaseAuth.instance;
  Future _signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  return Drawer(
    child: ListView(
      children: <Widget>[
        ListTile(
          title: Text('Home'),
          leading: Icon(Icons.home),
          onTap: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        Divider(),
        ListTile(
          title: Text('List'),
          leading: Icon(Icons.list),
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        Divider(),
        ListTile(
          title: Text('Weather'),
          leading: Icon(Icons.sunny),
          onTap: () {
            // Navigator.pushNamed(context, Route(builder:(context)=>'Login');
          },
        ),
        Divider(),
        ListTile(
          title: Text('Logout'),
          leading: Icon(Icons.exit_to_app),
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            if (_auth == null) {
              main();
            }
            // await _signOut();
            // if (_auth.currentUser == null) {
            //   Navigator.pop(
            //       context, MaterialPageRoute(builder: (context) => Login()));
            // }
          },
        ),
        Divider(),
      ],
    ),
  );
}

// class ketika tombol daftar ujian di klik
class DaftarUjian extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String dropValue = 'Informatika';

  var items = [
    'Informatika',
    'Sistem Informasi',
    'Sistem Informasi Akuntansi',
    'Bisnis Digital',
    'Manajemen Ritel',
    'Teknik Komputer'
  ];

  void validateInput() {
    FormState? form = this.formKey.currentState;

    SnackBar message = SnackBar(
      content: Text('Proses validasi sukses...'),
    );

    if (form != null) {
      if (form.validate()) {
        // ScaffoldMessenger.of(context).showSnackBar(message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Daftar Ujian'),
          backgroundColor: Colors.blue[900],
        ),
        drawer: buildDrawer(context),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Masukkan nama',
                      labelText: 'Nama',
                      icon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (String? value) {
                      if (value.toString().isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Masukkan NIM',
                      labelText: 'NIM',
                      icon: Icon(Icons.card_membership),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (String? value) {
                      if (value.toString().isEmpty) {
                        return 'NIM tidak boleh kosong';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Masukkan Email',
                      labelText: 'Email:',
                      icon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value.toString().isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    children: [
                      DropdownButton(
                          value: dropValue,
                          icon: const Icon(Icons.school),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? value) {}),
                    ],
                  ),
                ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Masukan Judul Tugas Akhir',
                      labelText: 'Judul Tugas Akhir',
                      icon: Icon(Icons.title),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                    validator: (String? value) {
                      if (value.toString().isEmpty) {
                        return 'Judul tidak boleh kosong';
                      }
                    },
                  ),
                ),
                Container(height: 10.0),
                ElevatedButton(
                  child: Text('Validasi Data'),
                  onPressed: validateInput,
                )
              ],
            ),
          ),
        ));
  }
}

//class ketika tombol jadwal di klik
class Jadwal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Ujian'),
        backgroundColor: Colors.blue[900],
      ),
      drawer: buildDrawer(context),
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

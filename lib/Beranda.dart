// import 'dart:js';

import 'package:flutter/material.dart';

class Beranda extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Beranda> {
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

//Class home ketika navigasi home di klik
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blue[900],
      ),
      // pembuatan card view
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

// class ketika tombol daftar ujian di klik
class DaftarUjian extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Masukan Program Studi',
                      labelText: 'Program Studi',
                      icon: Icon(Icons.school),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (String? value) {
                      if (value.toString().isEmpty) {
                        return 'Program Studi Tidak Boleh Kosong';
                      }
                    },
                  ),
                ),
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

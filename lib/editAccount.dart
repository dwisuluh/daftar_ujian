import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class editAccount extends StatefulWidget {
  @override
  _editAccount createState() => _editAccount();
}

class _editAccount extends State<editAccount> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String dropValue = 'Program Studi';

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  String? _prodiController;
  final TextEditingController _ttlController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  final CollectionReference _documentation =
      FirebaseFirestore.instance.collection('biodata');

  var items = [
    'Program Studi',
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
      content: Text('Proses simpan data berhasil'),
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
          title: Text('Update Biodata'),
          backgroundColor: Colors.blue[900],
        ),
        // Membuat Form Field update biodata
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: _namaController,
                    maxLines: 1,
                    scrollPadding: EdgeInsets.symmetric(horizontal: 5.0),
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
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: _nimController,
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
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        value: dropValue,
                        icon: const Icon(Icons.school),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropValue = value!;
                            _prodiController = dropValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: _ttlController,
                    decoration: InputDecoration(
                      hintText: 'Tempat Lahir',
                      labelText: 'Tempat Lahir',
                      icon: Icon(Icons.house),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (String? value) {
                      if (value.toString().isEmpty) {
                        return 'Tempat Lahir Tidak Boleh Kosong';
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: _tanggalController,
                    decoration: InputDecoration(
                      hintText: 'DD/MM/YYYY',
                      labelText: 'Tanggal Lahir',
                      icon: Icon(Icons.calendar_month_outlined),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.datetime,
                    validator: (String? value) {
                      if (value.toString().isEmpty) {
                        return 'Tanggal Lahir Tidak Boleh Kosong';
                      }
                    },
                  ),
                ),
                Container(
                  // height: 45,
                  margin: EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: _alamatController,
                    decoration: InputDecoration(
                      hintText: 'Alamat Lengkap',
                      labelText: 'Alamat',
                      icon: Icon(Icons.add_home_outlined),
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
                  child: Text('Simpan'),
                  onPressed: validateInput,
                )
              ],
            ),
          ),
        ));
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
    }
  }
}

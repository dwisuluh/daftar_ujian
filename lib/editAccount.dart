import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class editAccount extends StatefulWidget {
  @override
  _editAccount createState() => _editAccount();
}

class _editAccount extends State<editAccount> {
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
          title: Text('Update Biodata'),
          backgroundColor: Colors.blue[900],
        ),
        // drawer: buildDrawer(context),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                // padding: const EdgeInsets.only(bottom: 5.0),
                TextFormField(
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

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class Catatan extends StatefulWidget {
  const Catatan({Key? key}) : super(key: key);

  @override
  _Tolist createState() => _Tolist();
}

class _Tolist extends State<Catatan> {
//Text Field Controller
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final String uid = FirebaseAuth.instance.currentUser!.uid;

//Mengambil data dengan tabel catatan
  final CollectionReference _documentation =
      FirebaseFirestore.instance.collection('catatan');

//fungsi ini digunakan untuk melakukan update atau membuat catatan baru
//
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _titleController.text = documentSnapshot['title'];
      _deskripsiController.text = documentSnapshot['deskripsi'];
      _dateController.text = documentSnapshot['date'];
    }
    //Menampilkan Modal untuk entri catatan
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                      labelText: 'Title', hintText: 'Masukan Judul'),
                ),
                TextField(
                  keyboardType: TextInputType.datetime,
                  controller: _dateController,
                  decoration: const InputDecoration(
                      hintText: 'Tanggal Kegiatan', labelText: 'Date'),
                ),
                TextField(
                  controller: _deskripsiController,
                  decoration: const InputDecoration(labelText: 'Deskripsi'),
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? title = _titleController.text;
                    final String? deskription = _deskripsiController.text;
                    final String? date = _dateController.text;
                    if (title != null && deskription != null) {
                      if (action == 'create') {
                        // Menyimpan catatan ke dalam database Firestore
                        await _documentation.add({
                          "title": title,
                          "date": date,
                          "deskripsi": deskription,
                          "name":
                              FirebaseAuth.instance.currentUser!.displayName,
                          "userId": FirebaseAuth.instance.currentUser!.uid,
                          "dateTime": DateTime.now().microsecondsSinceEpoch
                        });
                      }

                      if (action == 'update') {
                        // Update catatan
                        await _documentation.doc(documentSnapshot!.id).update({
                          "title": title,
                          "date": date,
                          "deskripsi": deskription,
                          "docId": documentSnapshot.id
                        });
                      }
                      // digunakan untuk membersihkan fields
                      _titleController.text = '';
                      _deskripsiController.text = '';
                      _dateController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // fungsi untuk melakukan delete data by Id
  Future<void> _deleteCatatan(String catatanId) async {
    await _documentation.doc(catatanId).delete();

    //Menampilkan Snack bar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Catatan Berhasil dihapus....')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan'),
        backgroundColor: Colors.blue[900],
        leading: Icon(Icons.list),
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
      // menggunakan StreamBuilder untuk menampilkan data secara real time
      body: StreamBuilder(
        stream: _documentation.where('userId', isEqualTo: uid).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['title'] +
                          '\n' +
                          documentSnapshot['date']),
                      subtitle: Text(documentSnapshot['deskripsi']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            // Button ini digunakan untuk melakukan edit pada catatan
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () =>
                                    _createOrUpdate(documentSnapshot)),
                            // Button ini digunakan untuk menghapus list catatan didalam database
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    _deleteCatatan(documentSnapshot.id)),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

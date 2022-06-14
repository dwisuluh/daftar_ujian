import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class Catatan extends StatefulWidget {
  @override
  _Tolist createState() => _Tolist();
}

class _Tolist extends State<Catatan> {
// text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  final CollectionReference _documentation =
      FirebaseFirestore.instance.collection('catatan');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _deskripsiController.text = documentSnapshot['deskription'];
      _dateController.text = documentSnapshot['date'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: 'Date',
                  ),
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
                    final String? name = _nameController.text;
                    final String? deskription = _deskripsiController.text;
                    final String? date = _dateController.text;
                    if (name != null && deskription != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _documentation.add({
                          "name": name,
                          "date": date,
                          "deskripsi": deskription,
                          "userId": FirebaseAuth.instance.currentUser!.uid
                        });
                      }

                      if (action == 'update') {
                        // Update the product
                        await _documentation.doc(documentSnapshot!.id).update({
                          "name": name,
                          "date": date,
                          "deskripsi": deskription,
                          // "userId": FirebaseAuth.instance.currentUser!.uid
                        });
                      }

                      // Clear the text fields
                      _nameController.text = '';
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

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await _documentation.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan'),
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.list_alt_rounded),
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
      // Using StreamBuilder to display all products from Firestore in real-time
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
                      title: Text(documentSnapshot['name'] +
                          '\n' +
                          documentSnapshot['date'].toString()),
                      subtitle: Text(documentSnapshot['deskripsi']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            // Press this button to edit a single product
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () =>
                                    _createOrUpdate(documentSnapshot)),
                            // This icon button is used to delete a single product
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    _deleteProduct(documentSnapshot.id)),
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

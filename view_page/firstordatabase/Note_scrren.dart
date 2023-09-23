import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/view_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

FirebaseAuth firebaseAuth2 = FirebaseAuth.instance;

class Note_page extends StatefulWidget {
  const Note_page({Key? key}) : super(key: key);

  @override
  State<Note_page> createState() => _Note_pageState();
}

class _Note_pageState extends State<Note_page> {
  List color = [
    Colors.blueGrey.shade100,
    Colors.deepOrange.shade300,
    Colors.amberAccent.shade100,
    Colors.purple.shade200,
    Colors.tealAccent.shade200,
    Colors.brown.shade200,
    Colors.purpleAccent.shade100,
    Colors.black12,
  ];
  TextEditingController tax1 = TextEditingController();
  TextEditingController tax2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu_outlined),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.to(Login_page);
              },
              child: Icon(Icons.logout),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Icon(Icons.share),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Container(
                    child: Column(
                      children: [
                        Text("Add Notes"),
                        TextField(
                          decoration: InputDecoration(hintText: "Tital"),
                          controller: tax1,
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: "Descriptions"),
                          controller: tax2,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('user')
                            .doc(firebaseAuth2.currentUser!.uid)
                            .collection('notes')
                            .add({
                          'createdate': '${DateTime.now()}',
                          'tital': tax1.text,
                          'dis': tax2.text,
                        });
                        tax1.clear();
                        tax2.clear();
                        Navigator.pop(context);
                      },
                      child: Text("Add"),
                      color: Colors.teal,
                    ),
                    MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancle"),
                        color: Colors.red),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(firebaseAuth2.currentUser!.uid)
              .collection('notes')
              .orderBy('createdate', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final note = snapshot.data!.docs;
              return ListView.builder(
                itemCount: note.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: color[index],
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(note[index].get('tital')),
                    ),
                    subtitle: SingleChildScrollView(
                        child: Text(note[index].get('dis'))),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            tax1 = TextEditingController(
                                text: note[index].get('tital'));
                            tax2 = TextEditingController(
                                text: note[index].get('dis'));
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Column(
                                    children: [
                                      Text("Update Notes"),
                                      TextField(
                                        decoration:
                                            InputDecoration(hintText: "Tital"),
                                        controller: tax1,
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                            hintText: "Descriptions"),
                                        controller: tax2,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    MaterialButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(firebaseAuth2.currentUser!.uid)
                                            .collection('notes')
                                            .doc(note[index].id)
                                            .update({
                                          'tital': tax1.text,
                                          'dis': tax2.text,
                                        });
                                        tax1.clear();
                                        tax2.clear();
                                        Navigator.pop(context);
                                      },
                                      child: Text("Update"),
                                      color: Colors.teal,
                                    ),
                                    MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancle"),
                                        color: Colors.red),
                                  ],
                                );
                              },
                            );
                          },
                          child: Icon(Icons.edit),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Column(
                                    children: [
                                      Text("Do you want to delete the notes?"),
                                    ],
                                  ),
                                  actions: [
                                    MaterialButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(firebaseAuth2.currentUser!.uid)
                                            .collection("notes")
                                            .doc(note[index].id)
                                            .delete();
                                        tax1.clear();
                                        tax2.clear();
                                        Navigator.pop(context);
                                      },
                                      child: Text("Yes"),
                                      color: Colors.red,
                                    ),
                                    MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("No"),
                                        color: Colors.green),
                                  ],
                                );
                              },
                            );
                          },
                          child: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

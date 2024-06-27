// ignore_for_file: file_names, unused_element, camel_case_types, must_be_immutable, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/pages/detailsPublication.dart';
import 'package:location/pages/navigationPro.dart/profileProprietaire.dart';
import 'package:location/services/services_etudiant.dart';

ServEtudiant _authServiceEtudiant = ServEtudiant();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

User user = _firebaseAuth.currentUser!;

class homePro extends StatefulWidget {
  homePro({super.key});
  User user = _firebaseAuth.currentUser!;
  @override
  State<homePro> createState() => _homeProState();
}

class _homeProState extends State<homePro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          )
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Proprietaire")
              .doc(widget.user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            var uidEtud = snapshot.data!['uid'];
            if (snapshot.hasData) {
              return Container(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 40,
                      ),
                      child: Row(
                        children: [],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 80,
                      width: 320,
                      decoration: BoxDecoration(
                          color: const Color(0xFF3C2DA5),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(164, 61, 45, 165),
                                blurRadius: 15,
                                offset: Offset(3, 3))
                          ]),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 30),
                            child: Column(
                              children: [
                                const Text(
                                  "Bienvenue !",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  snapshot.data!['nom'],
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Publication")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text("Error: ${snapshot.error}"));
                          } else if (snapshot.hasData) {
                            var docs = snapshot.data!.docs;
                            print(
                                "Number of documents fetched: ${docs.length}");
                            if (docs.isEmpty) {}
                            return ListView.builder(
                              itemCount: docs.length,
                              itemBuilder: (context, index) {
                                var doc = docs[index];
                                print("Fetched doc: ${doc.data()}");
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                detailsPublication(
                                                  adresse: doc['adresse'],
                                                  description:
                                                      doc['description'],
                                                  dateDisponible:
                                                      doc['dateDisponible'],
                                                  nomProprietaire:
                                                      doc['nomProprietaire'],
                                                  nbplace: doc['nbplace'],
                                                  imagUrl: doc['imagUrl'],
                                                  genre: doc['genre'],
                                                  prix: doc['prix'],
                                                  uidProprietaire: doc['uid'],
                                                  uidEtudiant: uidEtud,
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15,
                                        bottom: 15,
                                        left: 13,
                                        right: 13),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  95, 96, 96, 96),
                                              blurRadius: 8,
                                            )
                                          ]),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          profilePropritaire()));
                                            },
                                            child: ListTile(
                                              leading: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: const Color
                                                              .fromARGB(
                                                              83, 0, 0, 0))),
                                                  child:
                                                      const Icon(Icons.person)),
                                              title: Text(
                                                doc['nomProprietaire'],
                                                style: const TextStyle(
                                                    color: Color(0xFF3C2DA5),
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  Text(
                                                    doc['adresse'],
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 121, 121, 121),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              doc['description'],
                                              style: const TextStyle(
                                                  fontSize: 18.0),
                                            ),
                                          ),
                                          Image.network(
                                            doc['imagUrl'],
                                            width: double.infinity,
                                            height: 240,
                                            fit: BoxFit.cover,
                                          ),
                                          ExpansionTile(
                                            title: const Padding(
                                              padding: EdgeInsets.only(),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.favorite,
                                                    color: Color(0xFF3C2DA5),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            trailing: const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 220),
                                              child: Icon(
                                                Icons.comment,
                                                color: Color(0xFF3C2DA5),
                                              ),
                                            ),
                                            children: List.generate(
                                                3,
                                                (index) => ListTile(
                                                    title: Text(
                                                        'Subtile $index'))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                                child: Text("Pas de publications disponibles"));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}

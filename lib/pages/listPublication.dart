//cette page contient le code qui me permet d'afficher la liste des annonces trouvées

// ignore_for_file: must_be_immutable, unused_element, use_key_in_widget_constructors, unused_field, prefer_final_fields, sized_box_for_whitespace, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/pages/profile.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class ListPublication extends StatefulWidget {
  User user = _firebaseAuth.currentUser!;
  ListPublication();

  @override
  State<ListPublication> createState() => _ListPublicationState();
}

class _ListPublicationState extends State<ListPublication> {
  var _numberToMonthMap = {
    1: "Janvier",
    2: "Février",
    3: "Février",
    4: "Février",
    5: "Février",
    6: "Février",
    7: "Février",
    8: "Février",
    9: "Février",
    10: "Février",
    11: "Février",
    12: "Février",
  };
  String? selectedValue;
  String? selectedValue2;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFE6E4E6),
          leading: IconButton(
            icon: const Icon(Icons.turn_left),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => profile()));
            },
          ),
          actions: const [],
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
          child: Column(
            children: [
              Container(
                height: 648,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Publication')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 20, right: 20),
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 100,
                                      width: 400,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: const Color(0xFF978EFE),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    99, 38, 38, 38),
                                                blurRadius: 14,
                                                offset: Offset(8, 8))
                                          ]),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, left: 10),
                                                child: Container(
                                                  height: 70,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                  ),
                                                ),
                                              ),
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    width: 240,
                                                  ),
                                                  Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 0,
                                                      ),
                                                      const Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 10,
                                                                    right: 50),
                                                            child: Row(
                                                              children: [],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index][
                                                                  'nomProprietaire'],
                                                              style: const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                  fontSize: 17),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['adresse'],
                                                              style: const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                  fontSize: 17),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 9,
                                                                left: 10),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['prix'],
                                                              style: const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                            ),
                                                            const SizedBox(
                                                              width: 40,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            });
                      } else {
                        return Container();
                      }
                    }),
              ),
            ],
          ),
        ));
  }
}

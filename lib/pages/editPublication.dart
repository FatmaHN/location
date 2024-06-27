 // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/services/services_proprietaire.dart';


import 'package:location/utils/global.dart';

ServProprietaire _authServiceProprietaire = ServProprietaire();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

final MaisonPlaceKey = GlobalKey<FormState>();

TextEditingController prixC = TextEditingController();
User user = _firebaseAuth.currentUser!;

class editPublication extends StatefulWidget {
  editPublication(bool bool);
  User user = _firebaseAuth.currentUser!;
  @override
  State<editPublication> createState() => _editPublicationState();
}

class _editPublicationState extends State<editPublication> {
  TextEditingController dateDispo = TextEditingController();
  TextEditingController adresse = TextEditingController();
  TextEditingController nbplace = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController prixC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Publication")
              .doc(global.uidPublication)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            adresse.text = snapshot.data!['adresse'];
            dateDispo.text = snapshot.data!['dateDisponible'];
            description.text = snapshot.data!['description'];
            nbplace.text = snapshot.data!['nbplace'];
            prixC.text = snapshot.data!['prix'];

            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: MaisonPlaceKey,
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              width: 350,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data!['imagUrl']),
                                      fit: BoxFit.cover)),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 29),
                              child: Container(
                                height: 64,
                                child: TextFormField(
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 116, 116, 116),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  controller: dateDispo,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Date cannot be empty ';
                                    }
                                    if (!RegExp(r'^[0 -9]+$').hasMatch(value)) {
                                      return 'Please enter valid Date';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelStyle: const TextStyle(
                                          color: Color(0xFF3C2DA5)),
                                      hintStyle: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 126, 125, 125)),
                                      hintText: "Date disponible",
                                      labelText: "Date disponible",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD7D7D7), width: 2),
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(left: 9),
                                        child: SizedBox(
                                            width: 50,
                                            child: IconButton(
                                                onPressed: () async {
                                                  final DateTime? _date =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(2000),
                                                          lastDate: DateTime(
                                                                  2024)
                                                              .add(const Duration(
                                                                  days: 365)));
                                                  final _formatteddate =
                                                      DateFormat("dd-MM-yyyy")
                                                          .format(_date!);
                                                  setState(() {
                                                    dateDispo.text =
                                                        _formatteddate
                                                            .toString();
                                                  });
                                                },
                                                icon: const Icon(
                                                    Icons.calendar_month,
                                                    color: Color(0xFF3C2DA5)))),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFD7D7D7),
                                              width: 2)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFFF2600),
                                              width: 2)),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD7D7D7), width: 2),
                                        borderRadius: BorderRadius.circular(13),
                                      )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 29),
                              child: Container(
                                height: 64,
                                child: TextFormField(
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 116, 116, 116),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  controller: adresse,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Adresse cannot be empty ';
                                    }
                                    if (!RegExp(r'^[a-z A-Z 0-9]+$')
                                        .hasMatch(value)) {
                                      return 'Please enter valid Adresse';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelStyle: const TextStyle(
                                          color: Color(0xFF3C2DA5)),
                                      hintStyle: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 126, 125, 125)),
                                      hintText: "adresse",
                                      labelText: "Adresse",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD7D7D7), width: 2),
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      prefixIcon: const Padding(
                                        padding: EdgeInsets.only(left: 9),
                                        child: SizedBox(
                                          width: 50,
                                          child: Icon(
                                            Icons.location_city,
                                            size: 26,
                                            color: Color(0xFF3C2DA5),
                                          ),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFD7D7D7),
                                              width: 2)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFD7D7D7),
                                              width: 2)),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD7D7D7), width: 2),
                                        borderRadius: BorderRadius.circular(13),
                                      )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 29),
                              child: Container(
                                height: 64,
                                child: TextFormField(
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 116, 116, 116),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  controller: nbplace,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'nombre de place cannot be empty ';
                                    }
                                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                      return 'Please enter valid nombre de place';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelStyle: const TextStyle(
                                          color: Color(0xFF3C2DA5)),
                                      hintStyle: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 126, 125, 125)),
                                      hintText: "Nombre de place",
                                      labelText: "Nombre de place",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD7D7D7), width: 2),
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      prefixIcon: const Padding(
                                        padding: EdgeInsets.only(left: 9),
                                        child: SizedBox(
                                          width: 50,
                                          child: Icon(
                                            Icons.person,
                                            size: 26,
                                            color: Color(0xFF3C2DA5),
                                          ),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFD7D7D7),
                                              width: 2)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFD7D7D7),
                                              width: 2)),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD7D7D7), width: 2),
                                        borderRadius: BorderRadius.circular(13),
                                      )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 29),
                              child: Container(
                                height: 64,
                                child: TextFormField(
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 116, 116, 116),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  controller: prixC,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'prix  cannot be empty ';
                                    }
                                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                      return 'Please enter valid prix ';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelStyle: const TextStyle(
                                          color: Color(0xFF3C2DA5)),
                                      hintStyle: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 126, 125, 125)),
                                      hintText: "prix par place",
                                      labelText: "prix par place",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD7D7D7), width: 2),
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      prefixIcon: const Padding(
                                        padding: EdgeInsets.only(left: 9),
                                        child: SizedBox(
                                          width: 50,
                                          child: Icon(
                                            Icons.price_change,
                                            size: 26,
                                            color: Color(0xFF3C2DA5),
                                          ),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFD7D7D7),
                                              width: 2)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFD7D7D7),
                                              width: 2)),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD7D7D7), width: 2),
                                        borderRadius: BorderRadius.circular(13),
                                      )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 29),
                              child: Container(
                                height: 104,
                                child: TextFormField(
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 116, 116, 116),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  controller: description,
                                  maxLines: 90,
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return 'description cannot be empty ';
                                  //   }
                                  //   if (!RegExp(r'^[a-z A-Z 0-9]+$')
                                  //       .hasMatch(value)) {
                                  //     return 'Please enter valid description';
                                  //   }
                                  //   return null;
                                  // },
                                  decoration: InputDecoration(
                                      labelStyle: const TextStyle(
                                          color: Color(0xFF3C2DA5)),
                                      hintStyle: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 126, 125, 125)),
                                      hintText: "description",
                                      labelText: "description",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD7D7D7), width: 2),
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      prefixIcon: const Padding(
                                        padding: EdgeInsets.only(left: 9),
                                        child: SizedBox(
                                          width: 50,
                                          child: Icon(
                                            Icons.message,
                                            size: 26,
                                            color: Color(0xFF3C2DA5),
                                          ),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFD7D7D7),
                                              width: 2)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFD7D7D7),
                                              width: 2)),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD7D7D7), width: 2),
                                        borderRadius: BorderRadius.circular(13),
                                      )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 34,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 29),
                              child: Container(
                                height: 54,
                                width: 367,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: const Color(0xFF3C2DA5),
                                ),
                                child: CupertinoButton(
                                    child: const Text(
                                      "Ajouter",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    onPressed: () async {}),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}

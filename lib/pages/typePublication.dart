// ignore_for_file: file_names, unused_element, must_be_immutable, non_constant_identifier_names, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/pages/FormFoyerPriv%C3%A9.dart';
import 'package:location/pages/FormMaisonParPlace.dart';
import 'package:location/services/services_proprietaire.dart';

import 'package:location/pages/FormMaisonComplet.dart';

import 'package:location/utils/global.dart';

ServProprietaire _authServiceProprietaire = ServProprietaire();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

User user = _firebaseAuth.currentUser!;

class TypePublication extends StatefulWidget {
  User user = _firebaseAuth.currentUser!;
  TypePublication(User);

  @override
  State<TypePublication> createState() => _TypePublicationState();
  void showpostDialog(BuildContext context, ImageSource source) async {
    // ignore: no_leading_underscores_for_local_identifiers
    XFile? _pickedFile = await ImagePicker().pickImage(source: source);
    File _file = File(_pickedFile!.path);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FormMaisonParplace(User, _file);
        });
  }

  void showpostDialogMaisonComplet(
      BuildContext context, ImageSource source) async {
    // ignore: no_leading_underscores_for_local_identifiers
    XFile? _pickedFile = await ImagePicker().pickImage(source: source);
    File _file = File(_pickedFile!.path);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FormMaisonComplet(User, _file);
        });
  }

  void showpostDialogfoyer(BuildContext context, ImageSource source) async {
    // ignore: no_leading_underscores_for_local_identifiers
    XFile? _pickedFile = await ImagePicker().pickImage(source: source);
    File _file = File(_pickedFile!.path);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FormFoyerPrive(User, _file);
        });
  }
}

class _TypePublicationState extends State<TypePublication> {
  void showAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Choose option",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0C6E30),
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: InkWell(
                    onTap: () => showpostDialog2(context, user),
                    splashColor: Color(0xFF013C42),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.camera,
                          color: Color(0xFF0C6E30),
                        ),
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      )
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: InkWell(
                    onTap: () => showpostDialog1(context, user),
                    splashColor: Color(0xFF0C6E30),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.image,
                          color: Color(0xFF0C6E30),
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      )
                    ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ]),
            ),
          );
        });
  }

  void showAlert2() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Choose option",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0C6E30),
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: InkWell(
                    onTap: () => showpostDialogMaisonComplet2(context, user),
                    splashColor: Color(0xFF013C42),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.camera,
                          color: Color(0xFF0C6E30),
                        ),
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      )
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: InkWell(
                    onTap: () => showpostDialogMaisonComplet1(context, user),
                    splashColor: Color(0xFF0C6E30),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.image,
                          color: Color(0xFF0C6E30),
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      )
                    ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ]),
            ),
          );
        });
  }

  void showAlert3() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Choose option",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0C6E30),
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: InkWell(
                    onTap: () => showpostDialogfoyer2(context, user),
                    splashColor: Color(0xFF013C42),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.camera,
                          color: Color(0xFF0C6E30),
                        ),
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      )
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: InkWell(
                    onTap: () => showpostDialogfoyer1(context, user),
                    splashColor: Color(0xFF0C6E30),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.image,
                          color: Color(0xFF0C6E30),
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      )
                    ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Type Publication'),
      ),
      body: Container(
        child: Container(
            height: 900,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(19.0),
                    child: Text(
                      "Choisir votre Bien :",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showAlert();
                      global.typeLocation == "Maison par place";
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 19, right: 19, top: 1, bottom: 1),
                      child: Container(
                          height: 170,
                          width: 120,
                          decoration: BoxDecoration(
                              color: const Color(0xFF3C2DA5),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(164, 61, 45, 165),
                                    blurRadius: 15,
                                    offset: Offset(3, 3))
                              ],
                              borderRadius: BorderRadius.circular(19)),
                          child: Row(
                            children: [
                              Container(
                                height: 190,
                                width: 110,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(19),
                                        bottomLeft: Radius.circular(19))),
                              ),
                              const Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      "Maison par place",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 23),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      showAlert2();
                      global.typeLocation2 == "Maison complète";
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 19, right: 19, top: 1, bottom: 1),
                      child: Container(
                          height: 170,
                          width: 120,
                          decoration: BoxDecoration(
                              color: const Color(0xFF3C2DA5),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(164, 61, 45, 165),
                                    blurRadius: 15,
                                    offset: Offset(3, 3))
                              ],
                              borderRadius: BorderRadius.circular(19)),
                          child: Row(
                            children: [
                              Container(
                                height: 190,
                                width: 110,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(19),
                                        bottomLeft: Radius.circular(19))),
                              ),
                              Column(
                                children: const [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Maison complète",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 23),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      showAlert3();
                      global.typeLocation3 == "Foyer Privé";
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 19, right: 19, top: 1, bottom: 1),
                      child: Container(
                          height: 170,
                          width: 120,
                          decoration: BoxDecoration(
                              color: const Color(0xFF3C2DA5),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(164, 61, 45, 165),
                                    blurRadius: 15,
                                    offset: Offset(3, 3))
                              ],
                              borderRadius: BorderRadius.circular(19)),
                          child: Row(
                            children: [
                              Container(
                                height: 190,
                                width: 110,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(19),
                                        bottomLeft: Radius.circular(19))),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Foyer Privé",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 23),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void showpostDialog1(BuildContext context, user) {
    TypePublication(user).showpostDialog(context, ImageSource.gallery);
  }

  void showpostDialog2(BuildContext context, user) {
    TypePublication(user).showpostDialog(context, ImageSource.camera);
  }

  void showpostDialogMaisonComplet1(BuildContext context, user) {
    TypePublication(user)
        .showpostDialogMaisonComplet(context, ImageSource.gallery);
  }

  void showpostDialogMaisonComplet2(BuildContext context, user) {
    TypePublication(user)
        .showpostDialogMaisonComplet(context, ImageSource.camera);
  }

  void showpostDialogfoyer1(BuildContext context, user) {
    TypePublication(user).showpostDialogfoyer(context, ImageSource.gallery);
  }

  void showpostDialogfoyer2(BuildContext context, user) {
    TypePublication(user).showpostDialogfoyer(context, ImageSource.camera);
  }
}

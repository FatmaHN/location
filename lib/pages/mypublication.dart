// ignore_for_file: unused_element, must_be_immutable, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/pages/typePublication.dart';
import 'package:location/services/services_proprietaire.dart';

ServProprietaire _authServiceProprietaire = ServProprietaire();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
final MaisonPlacemodifKey = GlobalKey<FormState>();
TextEditingController dateDispo = TextEditingController();
TextEditingController adresse = TextEditingController();
TextEditingController nbplace = TextEditingController();
TextEditingController description = TextEditingController();

TextEditingController prixC = TextEditingController();
final publicationkey = GlobalKey<FormState>();
User user = _firebaseAuth.currentUser!;

class Mypublication extends StatefulWidget {
  Mypublication(user);
  User user = _firebaseAuth.currentUser!;

  @override
  State<Mypublication> createState() => _MypublicationState();
  void showpostDialog(BuildContext context, ImageSource source) async {
    // ignore: no_leading_underscores_for_local_identifiers
    XFile? _pickedFile = await ImagePicker().pickImage(source: source);
    File _file = File(_pickedFile!.path);

    Navigator.pop(context);
  }
}

class _MypublicationState extends State<Mypublication> {
  void showAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "choisir une option",
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
                    child: Row(children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.camera,
                          color: Color(0xFF0C6E30),
                        ),
                      ),
                      Text(
                        'Caméra',
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
                    child: Row(children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.image,
                          color: Color(0xFF0C6E30),
                        ),
                      ),
                      Text(
                        'Galerie',
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
        title: const Text('Mes Publications'),
      ),
      body: StreamBuilder<Object>(
          stream: FirebaseFirestore.instance
              .collection("Proprietaire")
              .doc(widget.user.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var uidProprietaire = snapshot.data!['uid'];
              return SingleChildScrollView(
                child: Container(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 690,
                            width: 470,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Publication")
                                    .where("uid", isEqualTo: uidProprietaire)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          return Stack(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15,
                                                    left: 19,
                                                    right: 19),
                                                child: Container(
                                                  width: 400,
                                                  decoration: BoxDecoration(
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    127,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            blurRadius: 12)
                                                      ],
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13)),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                          height: 160,
                                                          width: 390,
                                                          decoration:
                                                              BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                          [
                                                                          'imagUrl']),
                                                                      fit: BoxFit
                                                                          .cover),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            13),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            13),
                                                                  ))),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10,
                                                                right: 100),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            13),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .person,
                                                                      color: Color(
                                                                          0xFF3C2DA5),
                                                                      size: 18,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      snapshot
                                                                          .data!
                                                                          .docs[index]['nomProprietaire'],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              19,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  ],
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 200),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 13),
                                                              child: Row(
                                                                children: [
                                                                  Image.asset(
                                                                    "assets/pin.png",
                                                                    height: 18,
                                                                    width: 18,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  
                                                                  Text(
                                                                    snapshot.data!
                                                                            .docs[index]
                                                                        [
                                                                        'adresse'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            97,
                                                                            97,
                                                                            97),
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 100),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 15,
                                                                      top: 10),
                                                              child: Row(
                                                                children: [
                                                                  Image.asset(
                                                                    "assets/sleeping.png",
                                                                    height: 18,
                                                                    width: 18,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    snapshot.data!
                                                                            .docs[index]
                                                                        [
                                                                        'nbplace'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Text(
                                                                    "|  ${snapshot.data!.docs[index]['prix']} DT",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      ExpansionTile(
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(),
                                                          child: Row(
                                                            children: const [
                                                              Icon(
                                                                Icons.favorite,
                                                                color: Color(
                                                                    0xFF3C2DA5),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        trailing: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(),
                                                          child: Icon(
                                                            Icons.comment,
                                                            color: Color(
                                                                0xFF3C2DA5),
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
                                              Positioned(
                                                  top: 20,
                                                  left: 230,
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.edit,
                                                          color: Colors.green,
                                                        ),
                                                        onPressed: () async {
                                                          var uidPublication =
                                                              snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id;
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  content:
                                                                      Container(
                                                                    height: 800,
                                                                    width: 800,
                                                                    child: StreamBuilder(
                                                                        stream: FirebaseFirestore.instance.collection('Publication').doc(uidPublication).snapshots(),
                                                                        builder: (context, AsyncSnapshot snapshot) {
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            adresse.text =
                                                                                snapshot.data!['adresse'];
                                                                            dateDispo.text =
                                                                                snapshot.data!['dateDisponible'];
                                                                            description.text =
                                                                                snapshot.data!['description'];
                                                                            nbplace.text =
                                                                                snapshot.data!['nbplace'];
                                                                            prixC.text =
                                                                                snapshot.data!['prix'];

                                                                            return SingleChildScrollView(
                                                                              child: Container(
                                                                                child: Form(
                                                                                    key: MaisonPlacemodifKey,
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Stack(
                                                                                          children: [
                                                                                            Container(
                                                                                              height: 160,
                                                                                              width: 390,
                                                                                              decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(snapshot.data!['imagUrl']), fit: BoxFit.cover), borderRadius: BorderRadius.circular(13)),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 30,
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.symmetric(horizontal: 0),
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
                                                                                                  return 'La date ne peut être vide';
                                                                                                }
                                                                                                if (!RegExp(r'^[0 -9]+$').hasMatch(value)) {
                                                                                                  return 'Veuillez saisir une date valide';
                                                                                                }
                                                                                                return null;
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                  labelStyle: const TextStyle(color: Color(0xFF3C2DA5)),
                                                                                                  hintStyle: const TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                                                                                                  hintText: "Date disponible",
                                                                                                  labelText: "Date disponible",
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2),
                                                                                                    borderRadius: BorderRadius.circular(13),
                                                                                                  ),
                                                                                                  prefixIcon: Padding(
                                                                                                    padding: const EdgeInsets.only(left: 9),
                                                                                                    child: SizedBox(
                                                                                                        width: 50,
                                                                                                        child: IconButton(
                                                                                                            onPressed: () async {
                                                                                                              final DateTime? _date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2024).add(const Duration(days: 365)));
                                                                                                              final _formatteddate = DateFormat("dd-MM-yyyy").format(_date!);
                                                                                                              setState(() {
                                                                                                                dateDispo.text = _formatteddate.toString();
                                                                                                              });
                                                                                                            },
                                                                                                            icon: const Icon(Icons.calendar_month, color: Color(0xFF3C2DA5)))),
                                                                                                  ),
                                                                                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2)),
                                                                                                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFFF2600), width: 2)),
                                                                                                  border: OutlineInputBorder(
                                                                                                    borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2),
                                                                                                    borderRadius: BorderRadius.circular(13),
                                                                                                  )),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 20,
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.symmetric(horizontal: 0),
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
                                                                                                  return 'L\'adresse ne peut pas être vide';
                                                                                                }
                                                                                                if (!RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(value)) {
                                                                                                  return 'Please enter valid Adresse';
                                                                                                }
                                                                                                return null;
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                  labelStyle: const TextStyle(color: Color(0xFF3C2DA5)),
                                                                                                  hintStyle: const TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                                                                                                  hintText: "adresse",
                                                                                                  labelText: "Adresse",
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2),
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
                                                                                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2)),
                                                                                                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2)),
                                                                                                  border: OutlineInputBorder(
                                                                                                    borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2),
                                                                                                    borderRadius: BorderRadius.circular(13),
                                                                                                  )),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 20,
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.symmetric(horizontal: 0),
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
                                                                                                  return 'nombre de place ne peut être vide ';
                                                                                                }
                                                                                                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                                                                                  return 'Veuillez saisir un nombre de place valide';
                                                                                                }
                                                                                                return null;
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                  labelStyle: const TextStyle(color: Color(0xFF3C2DA5)),
                                                                                                  hintStyle: const TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                                                                                                  hintText: "Nombre de place",
                                                                                                  labelText: "Nombre de place",
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2),
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
                                                                                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2)),
                                                                                                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2)),
                                                                                                  border: OutlineInputBorder(
                                                                                                    borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2),
                                                                                                    borderRadius: BorderRadius.circular(13),
                                                                                                  )),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 20,
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.symmetric(horizontal: 0),
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
                                                                                                  return 'prix ne peut être vide ';
                                                                                                }
                                                                                                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                                                                                  return 'Veuillez saisir un prix valide';
                                                                                                }
                                                                                                return null;
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                  labelStyle: const TextStyle(color: Color(0xFF3C2DA5)),
                                                                                                  hintStyle: const TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                                                                                                  hintText: "prix ",
                                                                                                  labelText: "prix ",
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2),
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
                                                                                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2)),
                                                                                                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2)),
                                                                                                  border: OutlineInputBorder(
                                                                                                    borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2),
                                                                                                    borderRadius: BorderRadius.circular(13),
                                                                                                  )),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 20,
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.symmetric(horizontal: 0),
                                                                                          child: Container(
                                                                                            height: 104,
                                                                                            child: TextFormField(
                                                                                              style: const TextStyle(
                                                                                                color: Color.fromARGB(255, 116, 116, 116),
                                                                                                fontWeight: FontWeight.w500,
                                                                                              ),
                                                                                              controller: description,
                                                                                              maxLines: 90,
                                                                                              validator: (value) {
                                                                                                if (value!.isEmpty) {
                                                                                                  return 'description cannot be empty ';
                                                                                                }
                                                                                                /* if (!RegExp(r'^[a-z A-Z 0-9]+$')
                                                                                                      .hasMatch(value)) {
                                                                                                    return 'Please enter valid description';
                                                                                                  } */
                                                                                                return null;
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                  labelStyle: const TextStyle(color: Color(0xFF3C2DA5)),
                                                                                                  hintStyle: const TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                                                                                                  hintText: "description",
                                                                                                  labelText: "description",
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2),
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
                                                                                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2)),
                                                                                                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2)),
                                                                                                  border: OutlineInputBorder(
                                                                                                    borderSide: const BorderSide(color: Color(0xFFD7D7D7), width: 2),
                                                                                                    borderRadius: BorderRadius.circular(13),
                                                                                                  )),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        Row(
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            Container(
                                                                                              height: 50,
                                                                                              width: 100,
                                                                                              decoration: BoxDecoration(color: Color(0xFF0C6E30), borderRadius: BorderRadius.circular(13)),
                                                                                              child: CupertinoButton(
                                                                                                child: Text(
                                                                                                  "Modifier",
                                                                                                  style: TextStyle(color: Colors.white),
                                                                                                ),
                                                                                                onPressed: () async {if(MaisonPlacemodifKey.currentState!.validate()){
                                                                                                  snapshot.data!.reference.update({
                                                                                                    "adresse": adresse.text,
                                                                                                    "dateDisponible": dateDispo.text,
                                                                                                    "description": description.text,
                                                                                                    "nbplace": nbplace.text,
                                                                                                    "prix": prixC.text,
                                                                                                  }).whenComplete(() => Navigator.pop(context));
                                                                                                }}
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            Container(
                                                                                              height: 50,
                                                                                              width: 100,
                                                                                              decoration: BoxDecoration(color: Color.fromARGB(255, 193, 193, 193), borderRadius: BorderRadius.circular(13)),
                                                                                              child: CupertinoButton(
                                                                                                child: Text(
                                                                                                  "Annuler",
                                                                                                  style: TextStyle(color: Colors.white),
                                                                                                ),
                                                                                                onPressed: () async {
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        )
                                                                                      ],
                                                                                    )),
                                                                              ),
                                                                            );
                                                                          } else {
                                                                            return Container();
                                                                          }
                                                                        }),
                                                                  ),
                                                                );
                                                              });
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                        ),
                                                        onPressed: () async {
                                                          var uidPublication =
                                                              snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id;
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                //popup pour la validation de suppression de publication
                                                                return AlertDialog(
                                                                  content:
                                                                      Container(
                                                                        width: 300,
                                                                    height: 300,
                                                                    child: StreamBuilder(
                                                                        stream: FirebaseFirestore.instance.collection('Publication').doc(uidPublication).snapshots(),
                                                                        builder: (context, AsyncSnapshot snapshot) {
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            return Container(
                                                                              child: Form(
                                                                                  key: publicationkey,
                                                                                  child: Column(children: [
                                                                                    Column(children: [
                                                                                      SizedBox(
                                                                                        height: 30,
                                                                                      ),
                                                                                      Text(
                                                                                        "Voulez-vous supprimer cette publication",
                                                                                        style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500),
                                                                                      ),
                                                                                      SizedBox(height: 40),
                                                                                      Column(
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            width: 10,
                                                                                          ),
                                                                                          Container(
                                                                                            height: 50,
                                                                                            width: 200,
                                                                                            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(13)),
                                                                                            child: CupertinoButton(
                                                                                              child: Text(
                                                                                                "supprimer",
                                                                                                style: TextStyle(color: Colors.white),
                                                                                              ),
                                                                                              onPressed: () async {
                                                                                                snapshot.data!.reference.delete().whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context) => Mypublication(user))));
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 20,
                                                                                          ),
                                                                                          Container(
                                                                                            height: 50,
                                                                                            width: 200,
                                                                                            decoration: BoxDecoration(color: Color.fromARGB(255, 193, 193, 193), borderRadius: BorderRadius.circular(13)),
                                                                                            child: CupertinoButton(
                                                                                              child: Text(
                                                                                                "ANNULER",
                                                                                                style: TextStyle(color: Colors.white),
                                                                                              ),
                                                                                              onPressed: () async {
                                                                                                Navigator.pop(context);
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      )
                                                                                    ]),
                                                                                  ])),
                                                                            );
                                                                          } else {
                                                                            return Container();
                                                                          }
                                                                        }),
                                                                  ),
                                                                );
                                                              });
                                                        },
                                                      )
                                                    ],
                                                  ))
                                            ],
                                          );
                                        });
                                  } else {
                                    return Container();
                                  }
                                }),
                          )
                        ],
                      ),
                      Positioned(
                          top: 600,
                          left: 220,
                          child: Container(
                            height: 48,
                            width: 130,
                            decoration: BoxDecoration(
                                color: Color(0xFF3C2DA5),
                                borderRadius: BorderRadius.circular(14)),
                            child: CupertinoButton(
                              child: Text(
                                "Ajouter",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TypePublication(User)));
                              },
                            ),
                          ))
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

  void showpostDialog1(BuildContext context, user) {
    TypePublication(user).showpostDialog(context, ImageSource.gallery);
  }

  void showpostDialog2(BuildContext context, user) {
    TypePublication(user).showpostDialog(context, ImageSource.camera);
  }
}

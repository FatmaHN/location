// ignore_for_file: must_be_immutable, unused_element, non_constant_identifier_names, avoid_unnecessary_containers, sized_box_for_whitespace, avoid_types_as_parameter_names, prefer_final_fields

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/model/publication.dart';
import 'package:location/pages/navigationPro.dart/navigationPro.dart';
import 'package:location/services/services_proprietaire.dart';
import 'package:location/utils/global.dart';

ServProprietaire _authServiceProprietaire = ServProprietaire();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

final MaisonPlaceKey = GlobalKey<FormState>();
TextEditingController dateDispo = TextEditingController();
TextEditingController adresse = TextEditingController();
TextEditingController nbplace = TextEditingController();
TextEditingController description = TextEditingController();

TextEditingController prixC = TextEditingController();
User user = _firebaseAuth.currentUser!;

class FormMaisonParplace extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  FormMaisonParplace(User, this._file);
  User user = _firebaseAuth.currentUser!;
  File _file;
  @override
  State<FormMaisonParplace> createState() => _FormMaisonParplaceState();
}

class _FormMaisonParplaceState extends State<FormMaisonParplace> {
  TextEditingController typeLocation =
      TextEditingController(text: "Maison par place");
  final List<String> items2 = [
    'fille',
    'garçon',
  ];
  String? selectedValue;
  String? selectedValue2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          )
        ],
        title: const Text('Maison par place '),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Proprietaire")
              .doc(widget.user.uid)
              .snapshots(),
          builder: (context, snapshot) {
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
                                      image: FileImage(widget._file),
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
                                    if (!RegExp(r"^[a-zA-ZÀ-ÿ0-9\s,'’]+$")
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                              ),
                              child: Container(
                                height: 59,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    hint: const Row(
                                      children: [
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Icon(Icons.location_city,
                                            size: 26, color: Color(0xFF3C2DA5)),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          'Genre',
                                          style: TextStyle(
                                            color: Color(0xFF3C2DA5),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: items2
                                        .map((items2) =>
                                            DropdownMenuItem<String>(
                                              value: items2,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 45,
                                                    child: Container(),
                                                  ),
                                                  Text(
                                                    items2,
                                                    style: const TextStyle(
                                                      color: Color(0xFF3C2DA5),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                    value: selectedValue,
                                    isExpanded: false,
                                    onChanged: (value) {
                                      setState(() {
                                        global.select1 = value as String;
                                        selectedValue = value as String;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      size: 22,
                                    ),
                                    iconSize: 14,
                                    iconDisabledColor: Colors.grey,
                                    buttonHeight: 59,
                                    buttonWidth: 400,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color(0xFFD7D7D7), width: 2),
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    buttonElevation: 2,
                                    itemHeight: 40,
                                    itemPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    dropdownMaxHeight: 700,
                                    dropdownWidth: 230,
                                    dropdownPadding: null,
                                    dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    dropdownElevation: 8,
                                    scrollbarRadius: const Radius.circular(40),
                                    scrollbarThickness: 6,
                                    scrollbarAlwaysShow: true,
                                    offset: const Offset(0, -8),
                                  ),
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
                                      hintText: "prix ",
                                      labelText: "prix ",
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
                                  controller: typeLocation,
                                  decoration: InputDecoration(
                                      labelStyle: const TextStyle(
                                          color: Color(0xFF3C2DA5)),
                                      hintStyle: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 126, 125, 125)),
                                      prefixIcon: const Padding(
                                        padding: EdgeInsets.only(left: 9),
                                        child: SizedBox(
                                          width: 50,
                                          child: Icon(
                                            Icons.edit,
                                            size: 26,
                                            color: Color(0xFF3C2DA5),
                                          ),
                                        ),
                                      ),
                                      hintText: "Type location",
                                      labelText: "Type location",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD7D7D7), width: 2),
                                        borderRadius: BorderRadius.circular(13),
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
                                    onPressed: () async {
                                      void onSubmit(
                                        context,
                                        keyForm,
                                        file,
                                      ) async {
                                        if (keyForm.currentState!.validate()) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      navigationProprietaire()));
                                          String _imageUrl =
                                              await _authServiceProprietaire
                                                  .uploadImage(file);
                                          Publication publication = Publication(
                                            description: description.text,
                                            dateDisponible: dateDispo.text,
                                            nomProprietaire:
                                                snapshot.data!['nom'],
                                            prix: prixC.text,
                                            genre: global.select1,
                                            nbplace: nbplace.text,
                                            imagUrl: _imageUrl,
                                            adresse: adresse.text,
                                            typeLocation: typeLocation.text,
                                            uid: _firebaseAuth.currentUser!.uid,
                                          );
                                          _authServiceProprietaire
                                              .createOfferPublication(
                                                  _firebaseAuth
                                                      .currentUser!.uid,
                                                  publication);
                                        }
                                      }

                                      onSubmit(context, MaisonPlaceKey,
                                          widget._file);
                                    }),
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

//cette page contient le navbar de l'espace propriétaire

// ignore_for_file: must_be_immutable, camel_case_types, unused_element, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:location/pages/navigationPro.dart/chatPro.dart';
import 'package:location/pages/navigationPro.dart/homePro.dart';
import 'package:location/pages/navigationPro.dart/profileProprietaire.dart';


final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
GlobalKey navi = GlobalKey();
User user = _firebaseAuth.currentUser!;

class navigationProprietaire extends StatefulWidget {
  navigationProprietaire({Key? key}) : super(key: key);
  User user = _firebaseAuth.currentUser!;
  @override
  State<navigationProprietaire> createState() => _navigationProprietaireState();
}

class _navigationProprietaireState extends State<navigationProprietaire> {
  int indexSe = 0;
  final List<Widget> screen = [
    homePro(),
chatHomeScreen(),
    profilePropritaire()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        screen.elementAt(indexSe),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: Align(
            alignment: const Alignment(0.0, 0.97),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: Container(
                decoration: const BoxDecoration(),
                height: 53,
                width: 300,
                child: GNav(
                  key: navi,
                  rippleColor: const Color.fromARGB(255, 254, 213, 151),
                  hoverColor: const Color.fromARGB(255, 254, 213, 151),
                  gap: 0,
                  backgroundColor:
                      const Color.fromARGB(255, 25, 32, 94).withOpacity(0.5),
                  activeColor: Colors.white,
                  iconSize: 21,
                  tabBackgroundGradient: const LinearGradient(colors: [
                    Color.fromARGB(181, 126, 195, 241),
                    Color(0xFF4B2FFD),
                  ]),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  color: const Color(0xFF5DCDD7),
                  tabs:const [
                    GButton(
                      icon: Icons.home,
                      text: ' Home',
                      backgroundColor: Color(0xFF5DCDD7),
                    ),
                     GButton(
                      icon: Icons.message,
                      text: ' message',
                      backgroundColor: Color(0xFF5DCDD7),
                    ),
                    GButton(
                      icon: Icons.person,
                      text: ' Profil',
                      backgroundColor: Color(0xFF5DCDD7),
                    ),
                  ],
                  selectedIndex: indexSe,
                  onTabChange: (index) {
                    setState(() {
                      indexSe = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

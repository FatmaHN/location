//cette page contient le navbar de l'esapce etudiant

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:location/pages/listPublication.dart';
import 'package:location/pages/navigationEtudiant/chat.dart';
import 'package:location/pages/navigationEtudiant/homeEtudient.dart';
import 'package:location/pages/profile.dart';

GlobalKey navi = GlobalKey();

class navigationEtudient extends StatefulWidget {
  const navigationEtudient({Key? key}) : super(key: key);

  @override
  State<navigationEtudient> createState() => _navigationEtudientState();
}

class _navigationEtudientState extends State<navigationEtudient> {
  int indexSe = 0;
  final List<Widget> screen = [
    homeEtudiant(),
    chatHomeScreenEtudiant(),
    profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        screen.elementAt(indexSe),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: Align(
            alignment: Alignment(0.0, 0.97),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Container(
                decoration: BoxDecoration(),
                height: 53,
                width: 300,
                child: GNav(
                  key: navi,
                  rippleColor: Color.fromARGB(255, 254, 213, 151),
                  hoverColor: Color.fromARGB(255, 254, 213, 151),
                  gap: 0,
                  backgroundColor:
                      Color.fromARGB(255, 25, 32, 94).withOpacity(0.5),
                  activeColor: Colors.white,
                  iconSize: 21,
                  tabBackgroundGradient: const LinearGradient(colors: [
                    Color.fromARGB(181, 126, 195, 241),
                    Color(0xFF4B2FFD),
                  ]),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  color: Color(0xFF5DCDD7),
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: ' Accueil',
                      backgroundColor: Color(0xFF5DCDD7),
                    ),
                    GButton(
                      icon: Icons.message,
                      text: ' Message',
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

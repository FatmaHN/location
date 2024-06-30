// ignore_for_file: camel_case_types, sized_box_for_whitespace, file_names, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/pages/login.dart';
import 'package:location/pages/loginProprietaire.dart';

class welcome extends StatefulWidget {
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 412,
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Image.asset(
                  "assets/logoBlue.png",
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "KARITY",
                  style: GoogleFonts.breeSerif(
                    color: const Color(0xFF3C2DA5),
                    fontSize: 35,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 470,
            child: Container(
              height: 500,
              width: 390,
              decoration: const BoxDecoration(
                  color: Color(0xFF3C2DA5),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Bienvenue !                                        ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      "Bienvenue dans notre application de location de logements pour les étudiants ! Explorez, comparez et trouvez votre logement idéal en quelques clics.",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        height: 55,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            color: const Color.fromARGB(255, 255, 255, 255)),
                        child: CupertinoButton(
                          child: const Text(
                            "Etudiant",
                            style: TextStyle(
                                color: Color(0xFF3C2DA5),
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const loginScreen()));
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        height: 55,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        child: CupertinoButton(
                          child: const Text(
                            "Propriétaire",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const loginProprietaireScreen()));
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

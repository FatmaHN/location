// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:location/pages/welcomePage.dart';


class Onboarding extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      title: 'Bienvenue à \n KARITY  ',
      titleTextStyle: const TextStyle(
          color: Color(0xFF3C2DA5), fontSize: 20, fontWeight: FontWeight.w700),
      subTitle:
          ' vous accueillir dans notre communauté dédiée à la recherche de logements',
      subTitleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 15,
          fontWeight: FontWeight.w500),
      imageUrl: 'assets/img1.png',
    ),
    Introduction(
      title: ' gérer vos\n annonces facilement',
      titleTextStyle: const TextStyle(
          color: Color(0xFF3C2DA5), fontSize: 20, fontWeight: FontWeight.w700),
      subTitle:
          'Publiez facilement des annonces avec\n des détails complets et attrayants',
      subTitleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 4, 4, 5),
          fontSize: 15,
          fontWeight: FontWeight.w500),
      imageUrl: 'assets/img7.png',
    ),
    /* Introduction(
      title: 'Utilisation de Cartes\n Interactives ',
      titleTextStyle: const TextStyle(
          color: Color(0xFF3C2DA5), fontSize: 20, fontWeight: FontWeight.w700),
      subTitle: 'Visualiser les adresses des logements à l\'aide de cartes',
      subTitleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 4, 4, 5),
          fontSize: 15,
          fontWeight: FontWeight.w500),
      imageUrl: 'assets/img3.png',
    ), */
    Introduction(
      title: 'Découvrez et recherchez\n des logements ',
      titleTextStyle: const TextStyle(
          color: Color(0xFF3C2DA5), fontSize: 20, fontWeight: FontWeight.w700),
      subTitle: 'vous trouverez des annonces de location de logements  ',
      subTitleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 15,
          fontWeight: FontWeight.w500),
      imageUrl: 'assets/img2.png',
    ),
    Introduction(
      title: 'communication direct ',
      titleTextStyle: const TextStyle(
          color: Color(0xFF3C2DA5), fontSize: 25, fontWeight: FontWeight.w700),
      subTitle:
          'Interagissez directement avec les propriétaires des logements qui vous intéressent en envoyant des messages instantanés via\n notre application. ',
      subTitleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 4, 4, 5),
          fontSize: 13,
          fontWeight: FontWeight.w500),
      imageUrl: 'assets/img8.png',
    ),
    Introduction(
      title: 'Anotation et Consultation',
      titleTextStyle: const TextStyle(
          color: Color(0xFF3C2DA5), fontSize: 25, fontWeight: FontWeight.w700),
      subTitle:
          'Notez les foyers et les propriétaires\n et consultez les avis des autres étudiants',
      subTitleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 4, 4, 5),
          fontSize: 15,
          fontWeight: FontWeight.w500),
      imageUrl: 'assets/img6.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      backgroudColor: const Color.fromARGB(255, 255, 255, 255),
      foregroundColor: const Color(0xFF3C2DA5),
      introductionList: list,
      onTapSkipButton: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const welcome(),
          )),
      skipTextStyle: const TextStyle(
        color: Color(0xFF3C2DA5),
        fontSize: 18,
      ),
    );
  }
}

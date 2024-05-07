// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:location/pages/welcomPage.dart';

class Onboarding extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      title: 'Bienvenue à \n KARITY  ',
      titleTextStyle: const TextStyle(color: Color(0xFF3C2DA5), fontSize: 20),
      subTitle:
          'Nous sommes ravis de vous accueillir\n dans notre communauté dédiée à \nla recherche de logements pour les étudiants.',
      subTitleTextStyle:
          const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
      imageUrl: 'assets/img1.png',
    ),
    Introduction(
      title: 'Découvrez et recherchez\n des logements ',
      titleTextStyle: const TextStyle(color: Color(0xFF3C2DA5), fontSize: 20),
      subTitle:
          'Dans notre application,\n vous trouverez des annonces de location \n de logements qui répondent à vos \n besoins en tant qu\'étudiant.',
      subTitleTextStyle:
          const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
      imageUrl: 'assets/img2.png',
    ),
    Introduction(
      title: 'Anotation et Consultation',
      titleTextStyle: const TextStyle(color: Color(0xFF3C2DA5), fontSize: 20),
      subTitle:
          'Notez les foyers et les propriétaires\n et consultez les avis des autres étudiants',
      imageUrl: 'assets/img6.png',
    ),
    Introduction(
      title: 'communication direct \navec les propriétaires',
      titleTextStyle: const TextStyle(color: Color(0xFF3C2DA5), fontSize: 20),
      subTitle:
          'Interagissez directement avec les propriétaires des logements qui vous intéressent en envoyant des messages instantanés via\n notre application. ',
      subTitleTextStyle:
          const TextStyle(color: Color.fromARGB(255, 4, 4, 5), fontSize: 15),
      imageUrl: 'assets/img8.png',
    ),
    Introduction(
      title: ' ',
      titleTextStyle: const TextStyle(color: Color(0xFF3C2DA5), fontSize: 20),
      subTitle: 'Visualiser les adresses des logements à l\'aide de cartes',
      subTitleTextStyle:
          const TextStyle(color: Color.fromARGB(255, 4, 4, 5), fontSize: 15),
      imageUrl: 'assets/img3.png',
    ),
    Introduction(
      title: 'Ajouter et gérer vos\n annonces facilement',
      titleTextStyle: const TextStyle(color: Color(0xFF3C2DA5), fontSize: 20),
      subTitle:
          'Publiez facilement des annonces\n avec des détails complets\n et attrayants, gérez-les en \ntemps réel et simplifiez\n le processus de location',
      subTitleTextStyle:
          const TextStyle(color: Color.fromARGB(255, 4, 4, 5), fontSize: 15),
      imageUrl: 'assets/img7.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      backgroudColor: const Color.fromARGB(255, 255, 255, 255),
      foregroundColor: const Color(0xFF3C2DA5),
      introductionList: list,
      onTapSkipButton: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const welcom(),
          )),
      skipTextStyle: const TextStyle(
        color: Color(0xFF3C2DA5),
        fontSize: 18,
      ),
    );
  }
}

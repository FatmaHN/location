//importer la bib qui donne des fonctions pour convertir des données entre diff formats tq json, et string
import 'dart:convert';
//bib qui permet d'intéragir avec la base de données firebase firestore
import 'package:cloud_firestore/cloud_firestore.dart';

//fonction qui transforme une chaine de caractères JSON à un objet propriètaire en utilisant
//la méthode fromJson de notre classe Propriètaire
FavoritePublication FavoritePublicationFromJson(String str) =>
    FavoritePublication.fromJson(json.decode(str));

//fonction qui transforme un objet propriètaire à une chaine de caractères JSON  en utilisant
//la méthode toJson de notre classe Propriètaire
String FavoritePublicationToJson(FavoritePublication data) =>
    json.encode(data.toJson());

class FavoritePublication {
  //constructeur
  FavoritePublication({
    this.uidPublication,
    this.uidProprietaire,
    this.uidEtudient,
    this.uid,
  });

  String? uidPublication;

  String? uidProprietaire;
  String? uidEtudient;
  String? uid;

  factory FavoritePublication.fromJson(Map<String, dynamic> json) =>
      FavoritePublication(
        uidPublication: json["uidPublication"],
        uidProprietaire: json["uidProprietaire"],
        uidEtudient: json["uidEtudient"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "uidPublication": uidPublication,
        "uidProprietaire": uidProprietaire,
        "uidEtudient": uidEtudient,
        "uid": uid,
      };
  factory FavoritePublication.fromDoc(DocumentSnapshot doc) {
    return FavoritePublication(
      uidPublication: doc['uidPublication'],
      uidProprietaire: doc['uidProprietaire'],
      uidEtudient: doc['uidEtudient'],
      uid: doc.id,
    );
  }
}

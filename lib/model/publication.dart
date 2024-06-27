import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Publication publicationFromJson(String str) =>
    Publication.fromJson(json.decode(str));

String publicationToJson(Publication data) => json.encode(data.toJson());

class Publication {
  Publication({
    this.description,
    this.dateDisponible,
    this.nbplace,
    this.typeLocation,
    this.nomProprietaire,
    this.adresse,
    this.genre,
    this.imagUrl,
    this.prix,
    this.uid,
  });

  String? description;
  String? dateDisponible;
  String? nbplace;
  String? typeLocation;
  String? nomProprietaire;
  String? adresse;
  String? imagUrl;
  String? genre;

  String? prix;

  String? uid;

  factory Publication.fromJson(Map<String, dynamic> json) => Publication(
        description: json["description"],
        genre: json["genre"],
        dateDisponible: json["dateDisponible"],
        nbplace: json["nbplace"],
        typeLocation: json["typeLocation"],
        nomProprietaire: json["nomProprietaire"],
        adresse: json["adresse"],
        imagUrl: json["imagUrl"],
        prix: json["prix"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "genre": genre,
        "dateDisponible": dateDisponible,
        "nbplace": nbplace,
        "typeLocation": typeLocation,
        "nomProprietaire": nomProprietaire,
        "adresse": adresse,
        "imagUrl": imagUrl,
        "prix": prix,
        "uid": uid,
      };
  factory Publication.fromDoc(DocumentSnapshot doc) {
    return Publication(
      description: doc['description'],
      genre: doc['genre'],
      dateDisponible: doc['dateDisponible'],
      nbplace: doc['nbplace'],
      typeLocation: doc['typeLocation'],
      nomProprietaire: doc['nomProprietaire'],
      adresse: doc['adresse'],
      imagUrl: doc['imagUrl'],
      prix: doc['prix'],
      uid: doc.id,
    );
  }
}

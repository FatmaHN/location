import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Etudiant etudiantFromJson(String str) => Etudiant.fromJson(json.decode(str));

String etudiantToJson(Etudiant data) => json.encode(data.toJson());

class Etudiant {
  Etudiant({
    this.nom,
    this.email,
    this.phone,
    this.adresse,
    this.uid,
  });

  String? nom;
  String? email;
  String? phone;
  String? adresse;
  String? uid;

  factory Etudiant.fromJson(Map<String, dynamic> json) => Etudiant(
        nom: json["nom"],
        email: json["email"],
        phone: json["phone"],
        adresse: json["adresse"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "nom": nom,
        "email": email,
        "phone": phone,
        "adresse": adresse,
        "uid": uid,
      };
  factory Etudiant.fromDoc(DocumentSnapshot doc) {
    return Etudiant(
      nom: doc['nom'],
      email: doc['email'],
      phone: doc['phone'],
      adresse: doc['adresse'],
      uid: doc.id,
    );
  }
}

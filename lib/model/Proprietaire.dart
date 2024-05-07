//importer la bib qui donne des fonctions pour convertir des données entre diff formats tq json, et string
import 'dart:convert';
//bib qui permet d'intéragir avec la base de données firebase firestore
import 'package:cloud_firestore/cloud_firestore.dart';

//fonction qui transforme une chaine de caractères JSON à un objet propriètaire en utilisant 
//la méthode fromJson de notre classe Propriètaire
Proprietaire proprietaireFromJson(String str) => Proprietaire.fromJson(json.decode(str));

//fonction qui transforme un objet propriètaire à une chaine de caractères JSON  en utilisant 
//la méthode toJson de notre classe Propriètaire
String proprietaireToJson(Proprietaire data) => json.encode(data.toJson());

class Proprietaire{
  //constructeur
  Proprietaire({
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

  factory Proprietaire.fromJson(Map<String, dynamic> json) => Proprietaire(
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
   factory Proprietaire.fromDoc(DocumentSnapshot doc) {
     return Proprietaire(
       nom: doc['nom'],
       email: doc['email'],
       phone: doc['phone'],
       adresse: doc['adresse'],
       uid: doc.id,
       );
   }   
}
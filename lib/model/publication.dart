import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';


Publication publicationFromJson(String str) => Publication.fromJson(json.decode(str));

String publicationToJson(Publication data) => json.encode(data.toJson());

class Publication{
  Publication({
   
    this.description,
   
    this.nomProprietaire,
    this.adresse,
    this.imagUrl,
  
    this.prix,
  
    this.uid,
  });


  String? description;
 String? nomProprietaire;
  String? adresse;
  String? imagUrl;

 
  String? prix;

  String? uid;

  factory Publication.fromJson(Map<String, dynamic> json) => Publication(
     
        description: json["description"],
      
        nomProprietaire: json["nomProprietaire"],
        adresse:json["adresse"],
        imagUrl:json["imagUrl"],
  
       prix:json["prix"],
  
        
     
        uid: json["uid"],
      );
 
  Map<String, dynamic> toJson() => {
     
        "description": description,
      
        "nomProprietaire": nomProprietaire,
        "adresse":adresse,
        "imagUrl":imagUrl,
    
        "prix":prix,
    
        
        "uid": uid,
      };
   factory Publication.fromDoc(DocumentSnapshot doc) {
     return Publication(
     
       description: doc['description'],
     
       nomProprietaire: doc['nomProprietaire'],
       adresse:doc['adresse'],
       imagUrl:doc['imagUrl'],
   
       prix:doc['prix'],
   
      
    
       uid: doc.id,
       );
   }   
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/model/favoritePublication.dart';
import 'package:location/pages/chat/chatScreenetu.dart';
import 'package:location/services/services_etudiant.dart';

User etudiant = _firebaseAuth.currentUser!;
ServEtudiant _authServiceEtudiant = ServEtudiant();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class detailsPublication extends StatefulWidget {
  detailsPublication({
    super.key,
    required this.adresse,
    required this.dateDisponible,
    required this.description,
    required this.genre,
    required this.imagUrl,
    required this.nbplace,
    required this.nomProprietaire,
    required this.prix,
    required this.uidProprietaire,
    required this.uidEtudiant,
  });
  User etudiant = _firebaseAuth.currentUser!;
  final String adresse;
  final String dateDisponible;
  final String description;
  final String genre;
  final String imagUrl;
  final String nbplace;
  final String uidProprietaire;
  final String nomProprietaire;
  final String uidEtudiant;
  final String prix;

  @override
  State<detailsPublication> createState() => _detailsPublicationState();
}

class _detailsPublicationState extends State<detailsPublication> {
  bool isFavorite = false; // State variable to track favorite status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      image: DecorationImage(
                          image: NetworkImage(widget.imagUrl),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    height: 500,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: ListTile(
                            trailing: Text(
                              widget.genre,
                              style: const TextStyle(fontSize: 19),
                            ),
                            title: const Text(
                              "Adresse",
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: ListTile(
                            title: Text(
                              widget.adresse,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 19),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 230),
                          child: Text(
                            "Description",
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: ListTile(
                            title: Text(
                              widget.description,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 19),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            children: [
                              Text(
                                "Nombre des place",
                                style: TextStyle(fontSize: 19),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                widget.nbplace,
                                style: const TextStyle(
                                    fontSize: 19, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ListTile(
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: const Color(0xFF3C2DA5),
                                shape: BoxShape.circle),
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          title: Text(widget.nomProprietaire),
                          subtitle: Text(
                            "Proprietaire",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          /* trailing: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: const Color(0xFF3C2DA5),
                                shape: BoxShape.circle),
                            child: IconButton(
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChatScreenetudiant(
                                                  currentUser1: widget.etudiant,
                                                  friendId1:
                                                      widget.uidProprietaire,
                                                  friendName1:
                                                      widget.nomProprietaire)));
                                },
                                icon: Icon(
                                  Icons.message,
                                  color: Colors.white,
                                )),
                          ), */
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            children: [
                              Text(
                                "Commentaires",
                                style: TextStyle(fontSize: 19),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.message,
                                color: Color(0xFF3C2DA5),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              /* Positioned(
                top: 30,
                left: 296,
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      isFavorite = !isFavorite;
                      FavoritePublication favoritePublication =
                          FavoritePublication(
                              uidEtudient: widget.uidEtudiant,
                              uidProprietaire: widget.uidProprietaire,
                              uidPublication: widget.uidProprietaire,
                              uid: _firebaseAuth.currentUser!.uid);
                      _authServiceEtudiant.createFavoritePublicationDocument(
                          _firebaseAuth.currentUser!.uid, favoritePublication);
                      // Toggle favorite status
                    });
                  },
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Center(
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: 19,
                      ),
                    ),
                  ),
                ),
              ), */
              Positioned(
                  top: 260,
                  left: 100,
                  child: Text(
                    "Date disponible : ${widget.dateDisponible}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

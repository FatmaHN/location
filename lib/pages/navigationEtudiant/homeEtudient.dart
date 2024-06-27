import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/pages/detailsPublication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/pages/login.dart';
import 'package:share_plus/share_plus.dart';
import 'package:location/pages/navigationPro.dart/profileProprietaire.dart';
import 'package:path_provider/path_provider.dart';

//défiition de variable global
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
final TextEditingController commentaireController = TextEditingController();

class homeEtudiant extends StatefulWidget {
  const homeEtudiant({Key? key}) : super(key: key);

  @override
  _homeEtudiantState createState() => _homeEtudiantState();
}

class _homeEtudiantState extends State<homeEtudiant> {
  User? etudiant = _firebaseAuth.currentUser;
  List<String> myCategories = ["Maison par place", "Maison complète", "Foyer Privé"];
  String selectedCategory = "Maison par place";
  TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _sharePublication(String adresse, String description, String imageUrl) async {
    try {
      // Téléchargez l'image
      final response = await http.get(Uri.parse(imageUrl));
      final documentDirectory = (await getApplicationDocumentsDirectory()).path;
      File imgFile = new File('$documentDirectory/flutter.png');
      imgFile.writeAsBytesSync(response.bodyBytes);

      // Partagez l'image et le texte en utilisant le package share_plus
      Share.shareFiles([imgFile.path], text: 'Check out this publication: $adresse - $description');
    } catch (e) {
      print('Error downloading or sharing the image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Accueil",
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => loginScreen()),
                (route) => false,
              );
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Etudiant").doc(etudiant!.uid).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            var uidEtud = snapshot.data!['uid'];
            var nameuser = snapshot.data!['nom'];
            return Column(
              children: [
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    itemCount: myCategories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final category = myCategories[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = category;
                            });
                            print("Selected category: $selectedCategory");
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: category == selectedCategory ? Colors.blue : Colors.black12,
                            ),
                            child: Center(
                              child: Text(category),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Container(
                    height: 53,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Recherche  ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(34),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Publication")
                        .where("typeLocation", isEqualTo: selectedCategory)
                        .where("adresse", isGreaterThanOrEqualTo: _searchText)
                        .where("adresse", isLessThanOrEqualTo: _searchText + '\uf8ff')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else if (snapshot.hasData) {
                        var docs = snapshot.data!.docs;
                        print("Number of documents fetched: ${docs.length}");
                        if (docs.isEmpty) {
                          print("No documents found for category: $selectedCategory");
                        }
                        return ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            var doc = docs[index];
                            print("Fetched doc: ${doc.data()}");
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => detailsPublication(
                                      adresse: doc['adresse'],
                                      description: doc['description'],
                                      dateDisponible: doc['dateDisponible'],
                                      nomProprietaire: doc['nomProprietaire'],
                                      nbplace: doc['nbplace'],
                                      imagUrl: doc['imagUrl'],
                                      genre: doc['genre'],
                                      prix: doc['prix'],
                                      uidProprietaire: doc['uid'],
                                      uidEtudiant: uidEtud,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 13,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(13),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromARGB(95, 96, 96, 96),
                                        blurRadius: 8,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => profilePropritaire(),
                                            ),
                                          );
                                        },
                                        child: ListTile(
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(color: Color.fromARGB(83, 0, 0, 0)),
                                            ),
                                            child: Icon(Icons.person),
                                          ),
                                          title: Text(
                                            doc['nomProprietaire'],
                                            style: const TextStyle(
                                              color: Color(0xFF3C2DA5),
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          subtitle: Text(
                                            doc['adresse'],
                                            style: const TextStyle(
                                              color: Color.fromARGB(255, 121, 121, 121),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          doc['description'],
                                          style: const TextStyle(fontSize: 18.0),
                                        ),
                                      ),
                                      Image.network(
                                        doc['imagUrl'],
                                        width: double.infinity,
                                        height: 240,
                                        fit: BoxFit.cover,
                                      ),
                                      ExpansionTile(
                                        title: Row(
                                          children:  [
                                            const Icon(Icons.favorite, color: Color(0xFF3C2DA5)),
                                            const SizedBox(width: 10,),
                                            InkWell(
                                              onTap:(){
                                                _sharePublication(doc['adresse'], doc['description'], doc['imagUrl']);
                                              },
                                              child: Image.asset("assets/share.png", height: 20,))
                                          ],
                                        ),
                                        trailing: const Icon(Icons.comment, color: Color(0xFF3C2DA5)),
                                        children: [
                                          Column(
                                            children: [
                                              _buildCommentsList(doc.id),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller: commentaireController,
                                                        decoration: const InputDecoration(
                                                          focusedBorder: OutlineInputBorder(
                                                             borderSide:  BorderSide(
                                                              color: Color.fromARGB(255, 255, 255, 255),
                                                              width: 2)
                                                          ),
                                                          prefixIcon: Padding(
                                                            padding:  EdgeInsets.only(top: 8, bottom: 8, right: 8),
                                                            child: CircleAvatar(
                                                              backgroundColor: Color.fromARGB(255, 231, 231, 231),
                                                              radius: 19,
                                                              child: Icon(
                                                                Icons.person,
                                                                size: 22,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ),
                                                          hintText: "Ajouter commentaire ..",
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                    IconButton(
                                                      icon: const Icon(Icons.send,color: Color(0xFF3C2DA5)),
                                                      onPressed: () async {
                                                        void _addComment(String publicationId, String commentText) {
                                                          var user = _firebaseAuth.currentUser;
                                                          var commentData = {
                                                            'userID': user!.uid,
                                                            'nomUser': nameuser,
                                                            'content': commentText,
                                                            'timestamp': Timestamp.now(),
                                                          };

                                                          _firebaseFirestore
                                                              .collection('Publication')
                                                              .doc(publicationId)
                                                              .collection('comments')
                                                              .add(commentData)
                                                              .then((value) {
                                                            _searchController.clear(); // Clear comment input
                                                          }).catchError((error) {
                                                            print("Failed to add comment: $error");
                                                          });
                                                        }
                                                        _addComment(doc.id, commentaireController.text);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            const SizedBox(height: 20,)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: Text("No data available"));
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildCommentsList(String publicationId) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseFirestore
          .collection('Publication')
          .doc(publicationId)
          .collection('comments')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          var comments = snapshot.data!.docs;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: comments.length,
            itemBuilder: (context, index) {
              var comment = comments[index];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 231, 231, 231),
                  radius: 19,
                  child: Icon(
                    Icons.person,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  comment['nomUser'],
                  style: const TextStyle(
                      color: Color(0xFF3C2DA5),
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Text(comment['content'],
                    style: const TextStyle(color: Color.fromARGB(255, 96, 96, 96))),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

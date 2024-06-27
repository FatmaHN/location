//Code de la page de liste de discussions pour l'étudiant
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/pages/chat/chatScreenetu.dart';
import 'package:location/pages/login.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class chatHomeScreenEtudiant extends StatefulWidget {
  User etudiant = _firebaseAuth.currentUser!;

  chatHomeScreenEtudiant();
  @override
  _chatHomeScreenEtudiantState createState() => _chatHomeScreenEtudiantState();
}

class _chatHomeScreenEtudiantState extends State<chatHomeScreenEtudiant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        centerTitle: true,
        backgroundColor: const Color(0xFF3C2DA5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        /* actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => loginScreen()),
                    (route) => false);
              },
              icon: Icon(Icons.logout))
        ], */
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Etudiant')
              .doc(widget.etudiant.uid)
              .collection('messages1')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var friendId = snapshot.data.docs[index].id;
                    var lastMsg = snapshot.data.docs[index]['last_msg1'];

                    if (snapshot.data.docs.length < 1) {
                      return const Center(
                        child: Text("Pas de chat disponible !"),
                      );
                    }
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Proprietaire')
                          .doc(friendId)
                          .get()
                          .asStream(),
                      builder: (context, AsyncSnapshot asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          var friend = asyncSnapshot.data;
                          return ListTile(
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: Container(
                                    height: 42,
                                    width: 42,
                                    decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle),
                                    child: const Center(
                                        child: Icon(
                                      Icons.person,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    )))),
                            title: Text(friend['nom']),
                            subtitle: Container(
                              child: Text(
                                "$lastMsg",
                                style: TextStyle(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreenetudiant(
                                            currentUser1: widget.etudiant,
                                            friendId1: friend['uid'],
                                            friendName1: friend['nom'],
                                          )));
                            },
                          );
                        }
                        return LinearProgressIndicator();
                      },
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

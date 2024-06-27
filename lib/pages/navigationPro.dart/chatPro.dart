//Code de la page de liste de discussions pour le propriétaire
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/pages/chat/chatScreenpro.dart';
import 'package:location/pages/loginProprietaire.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class chatHomeScreen extends StatefulWidget {
  User user = _firebaseAuth.currentUser!;

  chatHomeScreen();
  @override
  _chatHomeScreenState createState() => _chatHomeScreenState();
}

class _chatHomeScreenState extends State<chatHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        centerTitle: true,
        backgroundColor: Color(0xFF3C2DA5),
        /* actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => loginProprietaireScreen()),
                    (route) => false);
              },
              icon: Icon(Icons.logout))
        ], */
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Proprietaire')
              .doc(widget.user.uid)
              .collection('messages')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var friendId = snapshot.data.docs[index].id;
                    var lastMsg = snapshot.data.docs[index]['last_msg'];

                    if (snapshot.data.docs.length < 1) {
                      return const Center(
                        child: Text("Pas de chat disponible !"),
                      );
                    }
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Etudiant')
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
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle),
                                    child: Center(
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
                                      builder: (context) =>
                                          ChatScreenproprietaire(
                                            currentUser: widget.user,
                                            friendId: friend['uid'],
                                            friendName: friend['nom'],
                                          )));
                            },
                          );
                        }
                        return LinearProgressIndicator();
                      },
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

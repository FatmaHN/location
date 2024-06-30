//chatScreen pour l'etudiant la page qui contient les messages entre l'etudaint et le propriétaire
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/pages/chat/messageetu.dart';
import 'package:location/pages/chat/oneMessageEtudiant.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class ChatScreenetudiant extends StatelessWidget {
  final User currentUser1;
  final String friendId1;
  final String friendName1;
 

  ChatScreenetudiant({
    required this.currentUser1,
    required this.friendId1,
    required this.friendName1,
   
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3C2DA5),
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child:Icon(Icons.person, color: Colors.white,)
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              friendName1,
              style: TextStyle(fontSize: 20,  color: Colors.white,),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Etudiant")
                    .doc(currentUser1.uid)
                    .collection('messages1')
                    .doc(friendId1)
                    .collection('chats')
                    .orderBy("date1", descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length < 1) {
                      return Center(
                        child: Text("Dites Bonjour"),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool isMe = snapshot.data.docs[index]['senderId1'] ==
                              currentUser1.uid;
                          return SingleMessage1(
                              message1: snapshot.data.docs[index]['message1'],
                              isMe1: isMe);
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          )),
          MessageTextField1(_firebaseAuth.currentUser!.uid, friendId1),
        ],
      ),
    );
  }
}

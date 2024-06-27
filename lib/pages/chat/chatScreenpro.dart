//l'interface dans la quelle se trouve l'envoi de messages pour le proprietaire(chatscreen pour le propriétaire)
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/pages/chat/messagepro.dart';
import 'package:location/pages/chat/oneMessageProprietaire.dart';


FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class ChatScreenproprietaire extends StatelessWidget {
  final User currentUser;
  final String friendId;
  final String friendName;
 

  ChatScreenproprietaire({
    required this.currentUser,
    required this.friendId,
    required this.friendName,
   
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
            SizedBox(
              width: 8,
            ),
            Text(
              friendName,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,),
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
                    topRight: Radius.circular(25))
                    ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Proprietaire")
                    .doc(currentUser.uid)
                    .collection('messages')
                    .doc(friendId)
                    .collection('chats')
                    .orderBy("date", descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length < 1) {
                      return const Center(
                        child: Text("Dites bonjour"),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool isMe = snapshot.data.docs[index]['senderId'] ==
                              currentUser.uid;
                          return SingleMessage(
                              message: snapshot.data.docs[index]['message'],
                              
                              isMe: isMe);
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          )),
          MessageTextField(_firebaseAuth.currentUser!.uid, friendId),
        ],
      ),
    );
  }

  
}

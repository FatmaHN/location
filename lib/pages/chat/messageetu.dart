//code pour l'espace qui permer de saisir un message et l'envoyer puis récuperer le dernier message pour l'etudiant
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class MessageTextField1 extends StatefulWidget {
  final String currentId1;
  final String friendId1;

  MessageTextField1(this.currentId1,this.friendId1);

  @override
  _MessageTextField1State createState() => _MessageTextField1State();
}

class _MessageTextField1State extends State<MessageTextField1> {
  TextEditingController _controller = TextEditingController();
  File? imageFile;

  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
       
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       color: Colors.white,
       padding: const EdgeInsetsDirectional.all(8),
       child: Row(
         children: [
           Expanded(child: TextField(
             controller: _controller,
              decoration: InputDecoration(
                 suffixIcon: IconButton(
                  onPressed: () => getImage(),
                  icon: const Icon(Icons.photo),
                  ),
                labelText:"Tapez votre message",
                fillColor: Colors.grey[100],
                filled: true,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0),
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(25)
                )
              ),
           )),
           const SizedBox(width: 20,),
           GestureDetector(
             onTap: ()async{
               String message = _controller.text;
               _controller.clear();
               await FirebaseFirestore.instance.
               collection('Etudiant').
               doc(widget.currentId1).
               collection('messages1').
               doc(widget.friendId1).
               collection('chats').
               add({
                  "senderId1":widget.currentId1,
                  "receiverId1":widget.friendId1,
                  "message1":message,
                  "type1":"text",
                  "date1":DateTime.now(),
               }).then((value) {
                 FirebaseFirestore.instance
                 .collection('Etudiant').
                 doc(widget.currentId1).
                 collection('messages1').
                 doc(widget.friendId1).set({
                     'last_msg1':message,
                 });
               });

               await FirebaseFirestore.instance
               .collection('Proprietaire').
               doc(widget.friendId1).
               collection('messages').doc(widget.currentId1).collection("chats").add({
                 "senderId":widget.currentId1,
                 "receiverId":widget.friendId1,
                 "message":message,
                 "type":"text",
                 "date":DateTime.now(),

               }).then((value){
                 FirebaseFirestore.instance.collection('Proprietaire').doc(widget.friendId1).collection('messages').doc(widget.currentId1).set({
                   "last_msg":message
                 });
               });
             },
             child: Container(
               padding: const EdgeInsets.all(8),
               decoration: const BoxDecoration(
                 shape: BoxShape.circle,
                 color: Color(0xFF3C2DA5),
               ),
               child: const Icon(Icons.send,color: Colors.white,),
             ),
           )
         ],
       ),
      
    );
  }
}
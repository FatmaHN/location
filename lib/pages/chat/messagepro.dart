//code pour récuperer le dernier message pour le propriétaire
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cross_file/src/types/base.dart';

class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendId;

  MessageTextField(this.currentId, this.friendId);

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
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
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => getImage(),
                  icon: const Icon(Icons.photo),
                ),
                labelText: "Tapez votre message",
                fillColor: Colors.grey[100],
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(25))),
          )),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () async {
              if (_controller.text.isNotEmpty) {
                String message = _controller.text;
                _controller.clear();
                await FirebaseFirestore.instance
                    .collection('Proprietaire')
                    .doc(widget.currentId)
                    .collection('messages')
                    .doc(widget.friendId)
                    .collection('chats')
                    .add({
                  "senderId": widget.currentId,
                  "receiverId": widget.friendId,
                  "message": message,
                  "type": "text",
                  "date": DateTime.now(),
                }).then((value) {
                  FirebaseFirestore.instance
                      .collection('Proprietaire')
                      .doc(widget.currentId)
                      .collection('messages')
                      .doc(widget.friendId)
                      .set({
                    'last_msg': message,
                  });
                });

                await FirebaseFirestore.instance
                    .collection('Etudiant')
                    .doc(widget.friendId)
                    .collection('messages1')
                    .doc(widget.currentId)
                    .collection("chats")
                    .add({
                  "senderId1": widget.currentId,
                  "receiverId1": widget.friendId,
                  "message1": message,
                  "type1": "text",
                  "date1": DateTime.now(),
                }).then((value) {
                  FirebaseFirestore.instance
                      .collection('Etudiant')
                      .doc(widget.friendId)
                      .collection('messages1')
                      .doc(widget.currentId)
                      .set({"last_msg1": message});
                });
              }
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF3C2DA5),
              ),
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

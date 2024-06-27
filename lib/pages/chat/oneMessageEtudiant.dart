//utiliser en chatScreen1
//cette page pour le un message 
import 'package:flutter/material.dart';


class SingleMessage1 extends StatelessWidget {
  final String message1;
  final bool isMe1;
  SingleMessage1({
    required this.message1,
    required this.isMe1
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe1 ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          constraints: BoxConstraints(maxWidth: 200),
          decoration: BoxDecoration(
            color: isMe1 ?  Color(0xFF3C2DA5) : Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(24))
          ),
          child: Text(message1,style: TextStyle(color: Colors.white,),)
        ),
      ],
      
    );
  }
}
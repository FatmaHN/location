

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;





class ListPublication extends StatefulWidget{
  User user = _firebaseAuth.currentUser!;
   ListPublication();

  @override
  State<ListPublication> createState() => _ListPublicationState();
}

class _ListPublicationState extends State<ListPublication> {
  var _numberToMonthMap = {
    1: "Janvier",
    2: "Février",
     3: "Février",
      4: "Février",
       5: "Février",
        6: "Février",
         7: "Février",
          8: "Février",
           9: "Février",
            10: "Février",
             11: "Février",
              12: "Février",
  };
    String? selectedValue;
  String? selectedValue2;
 final List<String> items2 = [
  'Travail',
  'Stage',
];
final List<String> items3 = [
  'Designe',
  'développement',
  'Business',
];
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE6E4E6),
        
       
       
                 actions: [
                 
                   
         
        ],
      ),
      body:   Container(
        
               child: Column(
                children: [
                 
                  Container(
                    height: 648,
                   
                    child: StreamBuilder<QuerySnapshot>(
                                   stream: FirebaseFirestore.instance
                                   .collection('Publication')
                                   .snapshots(),
                                   builder: (context, snapshot) {
                                    
                                     if(snapshot.hasData){
                        return  ListView.builder(
                          
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder:(context, index) {
                        
                    
                                   
                                                          return Padding(
                                                             padding: const EdgeInsets.only(top: 15,left: 20,right: 20),
                                                            child: GestureDetector(
                                                              onTap: () {
                                                               
                                  
                                                              },
                                                            child:
                                                            Container(
                      height: 100,
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Color(0xFF978EFE),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(99, 38, 38, 38),
                            blurRadius: 14,
                            offset: Offset(8, 8)

                          )
                        ]
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 10
                                ),
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                   
                                  ),
                                 ),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 240,
                                   
                                    
                                  ),
                                  Column(
                                      children: [
                                        SizedBox(height: 0,),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10,right: 50),
                                              child: Row(
                                                children: [
                                                 
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8),
                                          child: Row(
                                            children: [
                                              Text(snapshot.data!.docs[index]['nomProprietaire'],
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 255, 255, 255),
                                                fontSize: 17
                                              ),),
                                              SizedBox(width: 10,),
                                                Text(snapshot.data!.docs[index]['adresse'],
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 255, 255, 255),
                                                fontSize: 17
                                              ),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 9,left: 10),
                                          child: Row(
                                            children: [
                                              Text(snapshot.data!.docs[index]['prix'],
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 255, 255, 255)
                                              ),),
                                              SizedBox(width: 40,),
                                             
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                                                            ),
                                                          );
                                                       }
                                                  );
                                     }else{
                        return Container();
                                     }
                            }
                            ),
                    )
                ,
               
                ],
               ),
      )
          
         
                  
    );
  }
}
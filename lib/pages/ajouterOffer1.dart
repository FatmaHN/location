import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/model/publication.dart';
import 'package:location/services/services_propri%C3%A8taire.dart';

ServProprietaire _authServiceProprietaire =ServProprietaire();

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
String title="";
String description="";

final registerKey = GlobalKey<FormState>();
TextEditingController dcriptionC = TextEditingController();
TextEditingController prix = TextEditingController();


 User user = _firebaseAuth.currentUser!;
class ajouterOffer2 extends StatefulWidget {
   User user = _firebaseAuth.currentUser!;
   ajouterOffer2(User);
   
  @override
  State<ajouterOffer2> createState() => _ajouterOffer2State();
  
  void showpostDialog(BuildContext context, ImageSource source) async{
   XFile? _pickedFile = await ImagePicker().pickImage(source: source);
    File _file = File(_pickedFile!.path);
    
    showDialog(context: context, builder: (BuildContext context) {
      return SimpleDialog(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            margin:  EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0),),
              color: Colors.grey,
              image: DecorationImage(
                image: FileImage(_file),
                fit: BoxFit.cover,
                )
            ),
          ),
         
        ],
      );
    });
  }
}

class _ajouterOffer2State extends State<ajouterOffer2> {
   bool isEmailcorrect = false;
  bool isNomCorrect = false;
  bool isAgeCorrect = false;
  bool isadresseCorrect = false;
  bool isPerviousCorrect = false;
  bool istypeCorrect = false;
  bool isMotpasseCorrect = false;
  bool isNomDocteurCorrect = false;
  bool isVisible = true;
  bool isPressed = true;
  bool isEmailCorrect = false;
  bool isPasswordCorrect = false;
  bool isvisible = true;
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
    
    return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Proprietaire')
              .doc(widget.user.uid)
              .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          // var nameEntreprise = snapshot.data!["nom"];
          if(snapshot.hasData) {
            return 
    Scaffold(
     backgroundColor: Color(0xFFE6E4E6),
      body: SingleChildScrollView(
        child: Container(
          
          child: Center(
            child:  Padding(
              padding: const EdgeInsets.only(
                top: 40,
                left: 30,
                right: 30
              ),
              child: Container(
                height: 625,
                width: 500,
                decoration: BoxDecoration(
                color: Color(0xFFE6E4E6),
                borderRadius: BorderRadius.circular(13),
                
                                  boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(76, 105, 105, 105),
                                  blurRadius: 14,
                                  offset: Offset(8, 8)
                            
                                )
                              ]
                ),
                
                child: ListView(
                  children:[
                  Form(
                        key: registerKey,
                        child: Column(
                          children: [
                           
                            
                           
                            Padding(
                              padding:EdgeInsets.symmetric(horizontal: 0),
                              child: InkWell(
                                
                                child: Container(
                                  height: 180,
                                  width: 500,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(13),
                                      topRight: Radius.circular(13)
                                    ),
                                    color: Colors.green,
                                    
                   
                    
                   
                  
                                  ),
                                 
                                ),
                              ),
                            ),
                            SizedBox(height: 39,),
                             Padding(padding:EdgeInsets.symmetric(horizontal: 32),
                        child: Container(
                          height: 64,
                          child: TextFormField(
                            controller: prix,
                            style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                          
                              onChanged: (val) {
                                       setState(() {
                                        title = val;
                                          });
                                      },
                                                    validator: (val) {
                                                                if (val!.isEmpty){
                                                                  return 'Le nom offer ne peut pas être vide ';
                                                                }
                                                                    if (!RegExp(
                                         r'^[a-z- A-Z]+$')
                                                                          .hasMatch(val)) {
                                                                            return 'Veuillez entrer un nom offer valide';
                                                                          }
                                                                return null;
                                                                    },
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.black
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey)
                              ,
                              hintText: "nom d'offer",
                              labelText: "Nom d'offer",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                color: Colors.white,
                                width: 2),
                                borderRadius: BorderRadius.circular(13),
                              ), prefixIcon:  Padding(
                                   padding: const EdgeInsets.only(left: 9),
                                   child: SizedBox(
                                    width: 50,
                                    child: Icon(
                                          Icons.work_sharp,
                                           
                                           color:Colors.green,
                                         
                                       ),
                                      ),
                                      ),
                                       suffixIcon:
                                   isNomCorrect == false ?
                                   Icon(Icons.close_sharp,
                                  color: Colors.transparent,)
                                  : Icon(Icons.done,
                                  color: Colors.green,),
                               focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color:isEmailCorrect == false ?
                                Colors.white :
                                Colors.green,
                                width: 2)
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                               color: Color(0x88FF2600) ,
                                width: 2)
                            ),
                              border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2),
                                borderRadius: BorderRadius.circular(13),
                              )
                            ),
                          ),
                        ), 
                        ),
                          
                        Padding(padding:EdgeInsets.symmetric(horizontal: 32),
                        child: Container(
                          height: 110,
                          child: TextFormField(
                            controller:dcriptionC ,
                            maxLines: 20,
                            style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                            
                             onChanged: (val) {
                              setState(() {
                                                   description=val;
                                                  });
                            },
                            validator: (val) {
                                                                if (val!.isEmpty){
                                                                  return 'description ne peut pas être vide';
                                                                }
                                                                    if (!RegExp(
                                         r'^[a-zA-Z 0-9]+$')
                                                                          .hasMatch(val)) {
                                                                            return 'Veuillez saisir une adresse description valide';
                                                                          }
                                                                return null;
                                                                    }, 
                            decoration: InputDecoration(
                              
                              
                               labelStyle: TextStyle(
                                color: Colors.black
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey)
                              ,
                               prefixIcon:  Padding(
                                   padding: const EdgeInsets.only(left: 9),
                                   child: SizedBox(
                                    width: 50,
                                    child: Icon(
                                          Icons.message,
                                    
                                           color:Colors.green,
                                         
                                       ),
                                      ),
                                      ),
                              suffixIcon:
                                   isEmailCorrect == false ?
                                   Icon(Icons.close_sharp,
                                  color: Colors.transparent,)
                                  : Icon(Icons.done,
                                  color: Colors.green,),
                              hintText: "",
                              labelText: "Déscription",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                color: Colors.white,
                                width: 2),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color:isPasswordCorrect == false ?
                                Colors.white :
                                Colors.green,
                                width: 2)
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                               color: Color(0x88FF2600) ,
                                width: 2)
                            ),
                              border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2),
                                borderRadius: BorderRadius.circular(13),
                              )
                            ),
                          ),
                        ), 
                        ),
                       
                         
                       
                         
                     
                    
                      
                        Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Container(
                          height: 50,
                          width: 367,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.green,
                            boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(21, 165, 155, 255),
                                  offset: Offset(-5,-5),
                                  spreadRadius: 1,
                                  blurRadius: 15
                                ),
                                BoxShadow(
                                  color: Color.fromARGB(25, 137, 129, 231),
                                  offset: Offset(5,5),
                                  blurRadius: 15,
                                  spreadRadius: 1
                                )
                              ],
                                                         
                                                          
                                                          
                                                          ),
                              child: CupertinoButton(
                                child:Text("Register", style: TextStyle(
                                    color: Colors.white,
                                  ),) ,
                                    onPressed: () async {
                                      void onSubmit(context, keyForm,   user) async{
                    if(keyForm.currentState!.validate()) {
                      
                         
                      const snackBar = SnackBar(
                                          backgroundColor: Color(0xFF74CCFF),
                       content: Text("Ajouter offer avec succès"));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                              
                      // String _imageUrl = await _authServiceProprietaire.uploadFile(file);
                     
                        Publication publication = Publication(
                       
                       description: description,
                       nomProprietaire:snapshot.data!["nom"],
                       adresse:snapshot.data!["adresse"],
                      //  imagUrl:_imageUrl,
                       prix:prix.text,
                     
                       uid: _firebaseAuth
                        .currentUser!.uid
                      );
                      _authServiceProprietaire.createOfferPublication(
                         _firebaseAuth.currentUser!.uid, publication);
                      
                      
                               
                          
                                                  
                    }
                  }
                  onSubmit(context, registerKey,  user);
                                     }),
                                                        ),
                                                ),
                                               
                          SizedBox(height: 40,)
                          ],
                        ),
                       ),
                  ]
                ),
              ),
            )
          ),
        ),
      ),
    );
   } else {
             return Center(
                    child: SizedBox(
                      height: 43,
                      width: 43,
                      
                    ),
                  );
        }
        }
    );
  }
  
   
}
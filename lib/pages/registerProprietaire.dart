


// ignore_for_file: camel_case_types, file_names, avoid_unnecessary_containers, sized_box_for_whitespace, unused_element, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/model/Proprietaire.dart';
import 'package:location/pages/profile.dart';
import 'package:location/pages/profileProprietaire.dart';
import 'package:location/services/services_propri%C3%A8taire.dart';
ServProprietaire _authServiceProprietaire =ServProprietaire();
final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore =FirebaseFirestore.instance;
  

final registerKey = GlobalKey<FormState>();
TextEditingController emailC = TextEditingController();
TextEditingController passwordC = TextEditingController();
TextEditingController nomC = TextEditingController();
TextEditingController adresseC = TextEditingController();
TextEditingController phoneC = TextEditingController();

class registerProprietaireScreen extends StatefulWidget {
  const registerProprietaireScreen({super.key});

  @override
  State<registerProprietaireScreen> createState() => _registerProprietaireScreenState();
}

class _registerProprietaireScreenState extends State<registerProprietaireScreen> {
 
  bool isvisible = true;
 String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: [
          Expanded(
            child: ListView(
               physics:const BouncingScrollPhysics(),
              children: [
                Container(
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              
                            const  SizedBox(height: 30,),
                               
                                 
                                   Image.asset("assets/logoBlue.png", height: 90,width: 90,),
                                
                                const SizedBox(height: 20,),
                    Text("        LOCATION\n  POUR  ETUDIENT",
            style: GoogleFonts.breeSerif(
              color: const Color(0xFF3C2DA5),
              fontSize: 22,
            ),),
                            
                                        
                             const  SizedBox(height: 70,),
                         Form(
                          key: registerKey,
                          child: Column(
                            children: [
                               Padding(padding:const EdgeInsets.symmetric(horizontal: 29),
                          child: Container(
                            height: 64,
                            child: TextFormField(
                              style:const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              controller: nomC,
                              
                                                        validator: (value) {
                                                        if (value!.isEmpty){
                                                          return 'Name cannot be empty ';
                                                        }
                                                            if (!RegExp(
                                 r'^[a-z- A-Z]+$')
                                                                  .hasMatch(value)) {
                                                                    return 'Please enter valid name';
                                                                  }
                                                        return null;
                                                            },
                              decoration: InputDecoration(
                               labelStyle: const TextStyle(
                        color: Color(0xFF3C2DA5)
                      ),
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 126, 125, 125)
                      ),
                                hintText: "user name",
                                labelText: "Name",
                                enabledBorder: OutlineInputBorder(
                                  borderSide:const BorderSide(
                                  color: Color(0xFFD7D7D7),
                                  width: 2),
                                  borderRadius: BorderRadius.circular(13),
                                ), prefixIcon:const  Padding(
                                     padding:  EdgeInsets.only(left: 9),
                                     child: SizedBox(
                                      width: 50,
                                      child: Icon(
                                            Icons.person,
                                             size: 26,
                                             color:Color(0xFF3C2DA5),
                                           
                                         ),
                                        ),
                                        ),
                               focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:const BorderSide(
                                  color:Color(0xFFD7D7D7),
                                  width: 2)
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:const BorderSide(
                                 color: Color(0xFFFF2600),
                                  width: 2)
                              ),
                                border: OutlineInputBorder(
                                borderSide:const BorderSide(
                                  color: Color(0xFFD7D7D7),
                                  width: 2),
                                  borderRadius: BorderRadius.circular(13),
                                )
                              ),
                            ),
                          ), 
                          ),
                         const  SizedBox(height: 20,),
                               Padding(padding:const EdgeInsets.symmetric(horizontal: 29),
                          child: Container(
                            height: 64,
                            child: TextFormField(
                              style:const  TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              controller: emailC,
                            
                                                        validator: (value) {
                                                        if (value!.isEmpty){
                                                          return 'Mail cannot be empty ';
                                                        }
                                                            if (!RegExp(
                                                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))+$')
                                                                  .hasMatch(value)) {
                                                                    return 'Please enter valid mail';
                                                                  }
                                                        return null;
                                                            },
                              decoration: InputDecoration(
                               labelStyle: const TextStyle(
                        color: Color(0xFF3C2DA5)
                      ),
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 126, 125, 125)
                      ),
                                hintText: "username@gmail.com",
                                labelText: "Email",
                                enabledBorder: OutlineInputBorder(
                                  borderSide:const BorderSide(
                                  color: Color(0xFFD7D7D7),
                                  width: 2),
                                  borderRadius: BorderRadius.circular(13),
                                ), prefixIcon:const  Padding(
                                     padding:  EdgeInsets.only(left: 9),
                                     child: SizedBox(
                                      width: 50,
                                      child: Icon(
                                            Icons.email,
                                             size: 26,
                                             color:Color(0xFF3C2DA5),
                                           
                                         ),
                                        ),
                                        ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:const BorderSide(
                                    color:Color(0xFFD7D7D7),
                                        width: 2
                                  )
                                ),
                                errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFD7D7D7),
                                        width: 2
                                      )
                                    ),
                                border: OutlineInputBorder(
                                borderSide:const BorderSide(
                                  color: Color(0xFFD7D7D7),
                                  width: 2),
                                  borderRadius: BorderRadius.circular(13),
                                )
                              ),
                            ),
                          ), 
                          ),
                       const  SizedBox(height: 20,),
                               Padding(padding:const EdgeInsets.symmetric(horizontal: 29),
                          child: Container(
                            height: 64,
                            child: TextFormField(
                              style:const  TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              controller: adresseC,
                              
                                                        validator: (value) {
                                                        if (value!.isEmpty){
                                                          return 'adresse cannot be empty ';
                                                        }
                                                            if (!RegExp(
                                                                      r'^[a-z A-Z 0-9]+$')
                                                                  .hasMatch(value)) {
                                                                    return 'Please enter valid adresse';
                                                                  }
                                                        return null;
                                                            },
                              decoration: InputDecoration(
                               labelStyle: const TextStyle(
                        color: Color(0xFF3C2DA5)
                      ),
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 126, 125, 125)
                      ),
                                hintText: "adresse",
                                labelText: "Adresse",
                                enabledBorder: OutlineInputBorder(
                                  borderSide:const BorderSide(
                                  color: Color(0xFFD7D7D7),
                                  width: 2),
                                  borderRadius: BorderRadius.circular(13),
                                ), prefixIcon:const  Padding(
                                     padding:  EdgeInsets.only(left: 9),
                                     child: SizedBox(
                                      width: 50,
                                      child: Icon(
                                            Icons.edit_location_alt,
                                             size: 26,
                                             color:Color(0xFF3C2DA5),
                                           
                                         ),
                                        ),
                                        ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:const BorderSide(
                                    color:Color(0xFFD7D7D7),
                                        width: 2
                                  )
                                ),
                                errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFD7D7D7),
                                        width: 2
                                      )
                                    ),
                                border: OutlineInputBorder(
                                borderSide:const BorderSide(
                                  color: Color(0xFFD7D7D7),
                                  width: 2),
                                  borderRadius: BorderRadius.circular(13),
                                )
                              ),
                            ),
                          ), 
                          ),
                          const  SizedBox(height: 20,),
                               Padding(padding:const EdgeInsets.symmetric(horizontal: 29),
                          child: Container(
                            height: 64,
                            child: TextFormField(
                              style:const  TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              controller: phoneC,
                              
                                                        validator: (value) {
                                                        if (value!.isEmpty){
                                                          return 'phone cannot be empty ';
                                                        }
                                                            if (!RegExp(
                                                                    r'^-?[0-9]+$')
                                                                  .hasMatch(value)) {
                                                                    return 'Please enter valid phone';
                                                                  }
                                                        return null;
                                                            },
                              decoration: InputDecoration(
                               labelStyle: const TextStyle(
                        color: Color(0xFF3C2DA5)
                      ),
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 126, 125, 125)
                      ),
                                hintText: "phone",
                                labelText: "Phone",
                                enabledBorder: OutlineInputBorder(
                                  borderSide:const BorderSide(
                                  color: Color(0xFFD7D7D7),
                                  width: 2),
                                  borderRadius: BorderRadius.circular(13),
                                ), prefixIcon:const  Padding(
                                     padding:  EdgeInsets.only(left: 9),
                                     child: SizedBox(
                                      width: 50,
                                      child: Icon(
                                            Icons.call,
                                             size: 26,
                                             color:Color(0xFF3C2DA5),
                                           
                                         ),
                                        ),
                                        ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:const BorderSide(
                                    color:Color(0xFFD7D7D7),
                                        width: 2
                                  )
                                ),
                                errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFD7D7D7),
                                        width: 2
                                      )
                                    ),
                                border: OutlineInputBorder(
                                borderSide:const BorderSide(
                                  color: Color(0xFFD7D7D7),
                                  width: 2),
                                  borderRadius: BorderRadius.circular(13),
                                )
                              ),
                            ),
                          ), 
                          ),
                      const  SizedBox(height: 20,),
                  Padding(padding:const EdgeInsets.symmetric(horizontal: 29),
                child: Container(
                  height: 64,
                  child: TextFormField(
                    style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    controller: passwordC,
                    obscureText: isvisible,
                    obscuringCharacter: "*",
                    
                     validator: (value) {
                                                    if (value!.isEmpty){
                                                      return 'Passowrd cannot be empty ';
                                                    }
                                                    if (!RegExp(r'^[a-zA-Z0-9]+$')
                                                          .hasMatch(value)) {
                                                            return 'Please enter valid mail';
                                                          }
                                                return null;
                                                    },  
                    decoration: InputDecoration(
                      
                      suffixIcon: Padding(
                            padding: const  EdgeInsets.only(right: 10),
                            child: IconButton(
                      onPressed: () {
                        setState(() {
                          isvisible = !isvisible;
                        });
                      },
                      icon: isvisible ?const Icon(Icons.visibility,
                       color: Color(0xFF3C2DA5),
                             )  
                      :const Icon(Icons.visibility_off,
                       color: Color(0xFF3C2DA5),
                             ) 
                      
                             ,),
                          ),
                       labelStyle: const TextStyle(
                        color: Color(0xFF3C2DA5)
                      ),
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 126, 125, 125)
                      ),
                       prefixIcon: const Padding(
                        padding:   EdgeInsets.only(left: 9),
                        child: SizedBox(
                         width: 50,
                          child: Icon(
                          Icons.lock,
                            size: 26,
                            color: Color(0xFF3C2DA5),
                           
                           ),
                       ),
                     ),
                      hintText: "pssaword",
                      labelText: "Password",
                      enabledBorder: OutlineInputBorder(
                        borderSide:const BorderSide(
                        color: Color(0xFFD7D7D7),
                        width: 2),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:const BorderSide(
                        color:
                        Color(0xFFD7D7D7),
                        width: 2)
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:const BorderSide(
                       color: Color(0xFFFF2600) ,
                        width: 2)
                    ),
                      border: OutlineInputBorder(
                      borderSide:const BorderSide(
                        color: Color(0xFFD7D7D7),
                        width: 2),
                        borderRadius: BorderRadius.circular(13),
                      )
                    ),
                  ),
                ), 
                ),
                
              
                           
                         const SizedBox(height: 34,),
                          Padding(
                          padding:const EdgeInsets.symmetric(horizontal: 29),
                          child: Container(
                            height: 54,
                            width: 367,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color:const Color(0xFF3C2DA5),
                             
                                                           
                                                            
                                                            
                                                            ),
                                child: CupertinoButton(
                                  child:const Text("Register", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16),) ,
                                      onPressed: () async {
                                     if(registerKey.currentState!.validate()){
                                       dynamic credentials = await _authServiceProprietaire.registerUser(
                                                  emailC.text.trim(),
                                                  passwordC.text.trim()
                                                  );
                                                   if (credentials == null) {
                                                            const snackBar = SnackBar(
                                                                content:
                                                                    Text("Email already exist"),
                                                                    backgroundColor: Color(0xFF5DCDD7),);
                                                            ScaffoldMessenger.of(context)
                                                                .showSnackBar(snackBar);
                                                          } else {
                                                            Navigator.push(context, 
                          MaterialPageRoute(builder: (context)=> profilePropritaire()));
                                                            Proprietaire proprietaire = Proprietaire(
                                                                nom: nomC.text,
                                                                email: emailC.text,
                                                                adresse:adresseC.text,
                                                                phone: phoneC.text,
                                                                uid: _firebaseAuth
                                                                    .currentUser!.uid);
                                                            _authServiceProprietaire.createProprietaireDocument(
                                                                _firebaseAuth.currentUser!.uid,
                                                                proprietaire);
                                                          }
   } }),                               
                                                          ),
                                                  ),
                                                 
                            ],
                          ),
                         )
                            ],
                          
                          ),
                        ),
                        
                      ],
                    ),
                  
                ),
              ],
            ),
          ),
        ],
      ),
    
    );
  }
}
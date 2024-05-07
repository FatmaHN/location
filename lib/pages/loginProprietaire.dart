


// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, non_constant_identifier_names, camel_case_types, file_names, unused_element, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/pages/ForgetPassword.dart';
import 'package:location/pages/navigationPro.dart/navigationPro.dart';
import 'package:location/pages/profile.dart';
import 'package:location/pages/profileProprietaire.dart';
import 'package:location/pages/registerProprietaire.dart';
import 'package:location/pages/registre.dart';
import 'package:location/services/services_etudient.dart';


ServEtudiant _authServiceEtudiant =ServEtudiant();
final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore =FirebaseFirestore.instance;
  
final loginKey = GlobalKey<FormState>();
final IdKey = GlobalKey<FormState>();
TextEditingController emailC = TextEditingController();
TextEditingController passwordC = TextEditingController();
TextEditingController productId = TextEditingController();
class loginProprietaireScreen extends StatefulWidget {
  const loginProprietaireScreen({super.key});

  @override
  State<loginProprietaireScreen> createState() => _loginProprietaireScreenState();
}

class _loginProprietaireScreenState extends State<loginProprietaireScreen> {
    bool isPressed = true;
  bool isEmailCorrect = false;
  bool isPasswordCorrect = false;
  bool isvisible = true;

  
 
  
  
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 249, 248, 252),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                   const SizedBox(height: 100,),
                     
                         Image.asset("assets/logoBlue.png", height: 90,width: 90,),
                      
                      const SizedBox(height: 20,),
                    Text("        LOCATION\n  POUR  ETUDIANT",
            style: GoogleFonts.breeSerif(
              color: const Color(0xFF3C2DA5),
              fontSize: 22,
            ),),
                    const SizedBox(height: 60,),
               Form(
                key: loginKey,
                child: Column(
                  children: [
                     Padding(padding:const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  height: 64,
                  child: TextFormField(
                    style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    controller: emailC,
                      onChanged: (value) {
                                setState(() {
                                  isEmailCorrect = RegExp(
                                  r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$").hasMatch(value);
                                });
                              },
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
                      ), prefixIcon: const Padding(
                           padding:   EdgeInsets.only(left: 9),
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
                   
               const SizedBox(height: 20,),
                Padding(padding:const EdgeInsets.symmetric(horizontal: 40),
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
                     onChanged: (value) {
                      setState(() {
                        isPasswordCorrect = RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);
                        
                      });
                    },
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
                 const SizedBox(height: 10,),
                    Padding(
                      padding: const  EdgeInsets.only(left: 210),
                      child: TextButton(
                        onPressed: (){
                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (contex) =>const forgetPassword()));
                        }, child:const Text("Forget Password",
                        style:  TextStyle(
                          color: Color(0xFF3C2DA5),
                          fontSize: 14.6,
                        fontWeight: FontWeight.w600,
                           decoration: TextDecoration.underline,
                        ),)),
                    ),
               const SizedBox(height: 20,),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  height: 54,
                  width: 367,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color:const Color(0xFF3C2DA5),
                   ),
                      child: CupertinoButton(
                        child:const Text("Login", style:  TextStyle(
                            color: Colors.white,
                            fontSize: 18),) ,
                            onPressed: () async {
                           if(loginKey.currentState!.validate()){
                          dynamic credentials = await _authServiceEtudiant.loginUser(
                                                              emailC.text.trim(),
                                                              passwordC.text.trim());
                                                          if (credentials == null) {
                                        const snackBar = SnackBar(
                                            content: Text(
                                                "Email/Password are invalid"),
                                                 backgroundColor: Color(0xFF5DCDD7));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (contex) =>navigationProprietaire()));
                                      }
                                      print(
                                          '******* credentials= $credentials');
                                                      
                          
                                           } }),
                                                ),
                                        ),
                                        Padding(
                    padding: const  EdgeInsets.only(top: 50, left: 60),
                    child: Row(
                      children: [
                       const SizedBox(width: 48,),
                       const Text("Don't have account !",
                        style: TextStyle(
                          color: Color.fromARGB(255, 126, 125, 125),
                          fontSize: 14.6,
                          fontWeight: FontWeight.w600,
                        ), ),
                        TextButton(
                          child:const Text("Register",
                        style:  TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xFF3C2DA5),
                        fontSize: 14.6,
                        fontWeight: FontWeight.w600,
                      ),
                          ),
                          onPressed: () {
                          Navigator.push(context, 
                          MaterialPageRoute(builder: (context)=>const registerProprietaireScreen()));
                           
                          },)
                      ],
                    ),
                  )
                  ],
                ),
               )
                  ],
                
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
// ignore_for_file: file_names, camel_case_types, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';



TextEditingController emailC = TextEditingController();
class forgetPassword extends StatefulWidget {
  const forgetPassword({super.key});

  @override
  State<forgetPassword> createState() => _forgetPasswordState();
}

class _forgetPasswordState extends State<forgetPassword> {
  bool isEmailCorrect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:SingleChildScrollView(
          physics:const BouncingScrollPhysics(),

          child: Stack(
            children: [
              Column(
                children: [
                 const SizedBox(height: 180,),
                   Image.asset("assets/logoBlue.png", height: 90,width: 90,),
                  const  SizedBox(height: 20,),
                   Text("  Enter your email to reach \na link to rest your password",
                    style: GoogleFonts.ubuntu(
                color:const Color(0xFF3C2DA5),
                fontSize: 19
              )),
                    const SizedBox(height: 20,),
                    Padding(
                      padding:const  EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        height: 79,
                        
                        child: TextFormField(
                    style:const TextStyle(
                            color: Color(0xFFD7D7D7),
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
                      labelStyle:const TextStyle(
                        color: Color(0xFFFFBA5F)
                      ),
                      hintStyle:const TextStyle(
                        color: Colors.white
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
                                   color:const Color(0xFF3C2DA5),
                                 
                               ),
                              ),
                              ),
                       focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color:Color(0xFFD7D7D7),
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
                      ),),
                     const  SizedBox(height: 20,),
                      Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          height: 55.7,
                          width: 367,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                    color:const Color(0xFF3C2DA5),
                    
                          ),
                         child:CupertinoButton(
                                    child:const Text("Envoyer", style: TextStyle(color:Colors.white),), 
                                   onPressed: () async {
                                    FirebaseAuth.instance.sendPasswordResetEmail(email: emailC.text)
                                                      .then((value) => Navigator.of(context).pop());
                                                      showDialog(context: context,
                                                       builder: (context) {
                                                        return const AlertDialog(
                                                          content: Text("check your email please"),
                                                        );
                                                       });
                                                      
                                   },
                                    ),
                        ),
                      ),
                ],
              ),
            Positioned(
              top: 160,
              left: 116,
              child: Container(
                      height: 110,
                        width: 110,
                         decoration:const BoxDecoration(
                        shape: BoxShape.circle,
                      
                        
                        ),
                     
                        ),
            ),
            ],
          ),
        ) ),
    );
  }
}
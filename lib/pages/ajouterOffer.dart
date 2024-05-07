// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:location/pages/ajouterOffer1.dart';
// import 'package:quickalert/models/quickalert_type.dart';
// import 'package:quickalert/widgets/quickalert_dialog.dart';


// FirebaseAuth _firebaseAuth = FirebaseAuth.instance;



 
// class ajouterOffer extends StatefulWidget {
//    User user = _firebaseAuth.currentUser!;
//    ajouterOffer(user);
//   @override
//   State<ajouterOffer> createState() => _ajouterOfferState();
  
//   void showpostDialog(BuildContext context, ImageSource source) async{
//    XFile? _pickedFile = await ImagePicker().pickImage(source: source);
//     File _file = File(_pickedFile!.path);
     
//     showDialog(context: context, builder: (BuildContext context) {
     
 

//       return ajouterOffer2(User,_file);
          
//     } 
//     );
//   }
// }

// class _ajouterOfferState extends State<ajouterOffer> {
//  void showAlert(){
//     QuickAlert.show(
//       context: context,
//       backgroundColor: Color(0xFFE6E4E6),
//        barrierColor: Color(0xFFE6E4E6),
//       widget: Container(
//      child:  Form(
                               
//                                 child: Column(
//                                   children: [
//                                     SizedBox(height: 10,),
                                   
//                                     SizedBox(height: 25,),
//                                     Padding(
//                                       padding:EdgeInsets.symmetric(horizontal: 1),
//                                       child: InkWell(
//                                           onTap: () {
//                             showDialog(context: context, builder: (BuildContext context) {
//                 return AlertDialog(
                  
//                   title: Center(
//                     child: Text("Choose option",
//                     style: TextStyle(fontWeight: FontWeight.w600,
//                     color: Color.fromARGB(255, 95, 95, 95),
//                     ),),
//                   ),
//                   content: SingleChildScrollView(
//                   child:
//                   ListBody(children: [
//                   SizedBox(height: 20,),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         left: 50
//                       ),
//                       child: InkWell(
                       
//                          onTap: () => showpostDialog2(context, user),
                        
//                         splashColor: Color(0xFF013C42),
//                       child: Row(children: [
//                         Padding(padding: const EdgeInsets.all(8.0),
//                         child:Icon(Icons.camera,
//                         color: Color(0xFF978EFE),
//                         ),
//                         ),
//                         Text('Camera',style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                           color: Color.fromARGB(255, 95, 95, 95)
//                         ),)
//                       ]),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         left: 50
//                       ),
//                       child: InkWell(
//                         onTap: () => showpostDialog1(context, user),
                        
                        
//                         splashColor: Color(0xFF978EFE),
//                       child: Row(children: [
//                         Padding(padding: const EdgeInsets.all(8.0),
//                         child:Icon(Icons.image,
//                         color: Color(0xFF978EFE),
//                         ),
//                         ),
//                         Text('Gallery',style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                           color: Color.fromARGB(255, 95, 95, 95)
//                         ),)
//                       ]),),
//                     ),
//                     SizedBox(height: 20,),

//                   ]),
//                   ),
//                 );
//                             });
//                           },
//                                         child: Container(
//                                           height: 139,
//                                           decoration: BoxDecoration(
//                                             color: Colors.amber,
//                                             borderRadius: BorderRadius.circular(14)
//                                           ),
//                                           child: Center(child: Icon(Icons.photo_camera,color: Colors.white,size: 80,)),
//                                         ),
//                                       ),
//                                     ),
                                   
                
                
                                      
//                                   ],)),
//       ),
//       title: "Ajouter offer",
      
//       titleColor: Color(0xFF74CCFF),
//       confirmBtnTextStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),   
//       confirmBtnColor:Colors.green,   
      
      
//       cancelBtnText: "cancel",
      
//       confirmBtnText: 'Ajouter',     
//       onConfirmBtnTap: () async {
                 
//       }, 
//       type: QuickAlertType.info);
//   }
//   @override
//   Widget build(BuildContext context) {
    
//     return StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection('Entreprise')
//               .doc(widget.user.uid)
//               .snapshots(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if(snapshot.hasData) {
//             return 
//     Scaffold(
//        appBar: AppBar(
//         backgroundColor: Color(0xFF978EFE),
//         title: Row(
//           children: [
         
          
//                    SizedBox(width: 75,),
//               Text("Ajouter offer") ,   
//               SizedBox(width: 30,), 
         
//           ],
//         ),
//         automaticallyImplyLeading: false,
       
                
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Center(
            
                  
//                   child: Column(
//                     children: [
//                       SizedBox(height: 30,),
                     
//                       SizedBox(height: 170,),
//                       Padding(
//                         padding:EdgeInsets.symmetric(horizontal: 39),
//                         child: Text("1ere étape ",
//                           style: TextStyle(
                          
//                           color:Color(0xFF978EFE) ,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500
//                         ),)
                        
//                       ),
                      
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           right: 1,
//                           top: 30
//                         ),
//                         child: InkWell(
//                              onTap: () {
//                             showAlert();
//                           },
//                           child: Text("Ajouter logo d'entreprise",
//                           style: TextStyle(
//                             decoration: TextDecoration.underline,
//                             color: Color.fromARGB(255, 123, 123, 123),
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500
//                           ),),
//                         ),
//                       ),
                  
//                     ],
//                   )
                 
                 
                                         
                    
                  
//                  )
//           ),
//         ),
      
//     );
//    } else {
//              return Center(
//                     child: SizedBox(
//                       height: 43,
//                       width: 43,
                      
//                     ),
//                   );
//         }
//         }
//     );
//   }
//    void showpostDialog1(BuildContext context,  user) {
   
//   ajouterOffer( user).showpostDialog(context, ImageSource.gallery);
//   }
//    void showpostDialog2(BuildContext context,  user) {
//      ajouterOffer( user).showpostDialog(context, ImageSource.camera);
//   }
// }
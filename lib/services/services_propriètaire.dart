
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/model/Proprietaire.dart';
import 'package:location/model/publication.dart';


class ServProprietaire {
  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore =FirebaseFirestore.instance;
   final FirebaseStorage _storage = FirebaseStorage.instance;
  Proprietaire _userFirebaseProprietaire(User? firebaseUser){
    return Proprietaire(uid: firebaseUser!.uid);
  }
   Publication _userFirebasePublication(User? firebaseUser){
    return Publication(uid: firebaseUser!.uid);
  }
  Stream<Publication>? get publication {
    return _firebaseAuth.authStateChanges().map(_userFirebasePublication);
  }
   
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();



  Future registerUser(String email, String password) async{
  try{
    UserCredential endUserCredentiels = await _firebaseAuth
    .createUserWithEmailAndPassword(email: email, password: password);
    User firebaseUser = endUserCredentiels.user!;
    return _userFirebaseProprietaire(firebaseUser);
  } catch (e) {
    print("Account creation failed , reason : " + e.toString());
    return null;
  }
  }

   Future loginUser(String login, String password) async {
    try {
      UserCredential endUserCredentials = await _firebaseAuth
          .signInWithEmailAndPassword(email: login, password: password);
      User firebaseUser = endUserCredentials.user!;
      return _userFirebaseProprietaire(firebaseUser);
    } catch (e) {
      print("Account login failed, reason: " + e.toString());
      return null;
    }
  }
 Future createOfferPublication(String uid, Publication muser) async {
    try {
      await _firebaseFirestore
          .collection('Publication')
        .add(muser.toJson());
    } catch (e) {
      print(e);
    }
  }
  Future createProprietaireDocument(String uid, Proprietaire muser) async {
  try {
    await _firebaseFirestore
    .collection('Proprietaire')
    .doc(uid)
    .set(muser.toJson());
  } catch (e){
    print(e);
  }
  }
  Future<String> uploadFile(file) async {
    Reference reference =_storage.ref().child('publication/${DateTime.now()}.png');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }


  
 
   


  
  
}
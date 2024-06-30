// ignore_for_file: unused_field
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/model/Proprietaire.dart';
import 'package:location/model/publication.dart';

class ServProprietaire {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Proprietaire _userFirebaseProprietaire(User? firebaseUser) {
    return Proprietaire(uid: firebaseUser!.uid);
  }

  Publication _userFirebasePublication(User? firebaseUser) {
    return Publication(uid: firebaseUser!.uid);
  }

  Stream<Publication>? get publication {
    return _firebaseAuth.authStateChanges().map(_userFirebasePublication);
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future registerUser(String email, String password) async {
    try {
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
      await _firebaseFirestore.collection('Publication').add(muser.toJson());
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
    } catch (e) {
      print(e);
    }
  }

  Future<String> uploadImage(File file) async {
    FirebaseStorage _storage = FirebaseStorage.instance;

    // Create a reference to the location you want to upload the file to
    //Créez une référence à l'emplacement où vous souhaitez télécharger le fichier.
    Reference reference = _storage
        .ref()
        .child('publication/${DateTime.now().millisecondsSinceEpoch}.png');

    // Set the metadata for the image = " Définir les métadonnées pour l'image"
    SettableMetadata metadata = SettableMetadata(
      contentType: 'image/png',
    );

    // Télécharger le fichier avec metadata
    UploadTask uploadTask = reference.putFile(file, metadata);

    // Attendre la fin du téléchargement et obtenir l'URL de téléchargement
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }
}

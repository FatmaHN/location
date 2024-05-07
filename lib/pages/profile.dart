// ignore_for_file: camel_case_types, override_on_non_overriding_member, sized_box_for_whitespace, file_names, unused_element, must_be_immutable, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/pages/EditeProfile.dart';
import 'package:location/pages/editeProfileProprietaire.dart';
import 'package:location/services/services_etudient.dart';

ServEtudiant _authServiceEtudiant = ServEtudiant();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
User etudiant = _firebaseAuth.currentUser!;

class profile extends StatefulWidget {
  profile();
  User  etudiant = _firebaseAuth.currentUser!;
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  bool darkMode = false;
  bool emailNotifications = true;
  bool pushNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Etudiant")
              .doc(widget.etudiant.uid)
              .snapshots(),
          builder: (context, snapshot) {
            
            if (snapshot.hasData) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Section
                          Center(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // handle onTap
                                      },
                                      child: Container(
                                        height: 110,
                                        child: Stack(
                                          children: [
                                            const CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 231, 231, 231),
                                              radius: 50,
                                              child: Icon(
                                                Icons.person,
                                                size: 47,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              bottom: 3,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (contex) =>
                                                              editeProfileScreen()));
                                                },
                                                child: const CircleAvatar(
                                                  radius: 14,
                                                  backgroundColor: Colors.blue,
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      snapshot.data!["nom"],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!["adresse"],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Preferences Section
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Preferences',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(11),
                                //       color:const Color.fromARGB(255, 231, 231, 231)
                                //     ),
                                //     child: ListTile(
                                //       leading:const CircleAvatar(
                                //         backgroundColor: Colors.amber,
                                //         child: Icon(Icons.language, color: Colors.white),
                                //       ),
                                //       title:const Text('Language'),
                                //       trailing:const Icon(Icons.chevron_right),
                                //       onTap: () {
                                //         // handle onTap
                                //       },
                                //     ),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: const Color.fromARGB(
                                            255, 231, 231, 231)),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: darkMode
                                            ? Colors.grey
                                            : Colors.blue,
                                        child: const Icon(
                                            Icons.nightlight_round,
                                            color: Colors.white),
                                      ),
                                      title: const Text('Dark Mode'),
                                      trailing: Switch(
                                        value: darkMode,
                                        onChanged: (value) {
                                          setState(() {
                                            darkMode = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: const Color.fromARGB(
                                            255, 231, 231, 231)),
                                    child: ListTile(
                                      leading: const CircleAvatar(
                                        backgroundColor: Colors.green,
                                        child: Icon(Icons.location_on,
                                            color: Colors.white),
                                      ),
                                      title: const Text('Location'),
                                      trailing: const Icon(Icons.chevron_right),
                                      onTap: () {
                                        // handle onTap
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: const Color.fromARGB(
                                            255, 231, 231, 231)),
                                    child: ListTile(
                                      leading: const CircleAvatar(
                                        backgroundColor: Colors.green,
                                        child: Icon(Icons.email,
                                            color: Colors.white),
                                      ),
                                      title: const Text('Email Notifications'),
                                      trailing: Switch(
                                        value: emailNotifications,
                                        onChanged: (value) {
                                          setState(() {
                                            emailNotifications = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: const Color.fromARGB(
                                            255, 231, 231, 231)),
                                    child: ListTile(
                                      leading: const CircleAvatar(
                                        backgroundColor: Colors.green,
                                        child: Icon(Icons.notifications,
                                            color: Colors.white),
                                      ),
                                      title: const Text('Push Notifications'),
                                      trailing: Switch(
                                        value: pushNotifications,
                                        onChanged: (value) {
                                          setState(() {
                                            pushNotifications = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Resources Section
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Resources',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: const Color.fromARGB(
                                            255, 231, 231, 231)),
                                    child: ListTile(
                                      leading: const CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        child: Icon(Icons.mail,
                                            color: Colors.white),
                                      ),
                                      title: const Text('Contact Us'),
                                      trailing: const Icon(Icons.chevron_right),
                                      onTap: () {
                                        // handle onTap
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: const Color.fromARGB(
                                            255, 231, 231, 231)),
                                    child: ListTile(
                                      leading: const CircleAvatar(
                                        backgroundColor: Colors.green,
                                        child: Icon(Icons.star,
                                            color: Colors.white),
                                      ),
                                      title: const Text('Rate in App Store'),
                                      trailing: const Icon(Icons.chevron_right),
                                      onTap: () {
                                        // handle onTap
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}

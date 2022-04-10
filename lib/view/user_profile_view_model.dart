import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/provider/base_model.dart';
import 'package:weight_tracker/src/models/user_model.dart';
import 'dart:developer';

class UserProfileViewModel extends BaseModel {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late UserModel user;
  bool isLoaded = false;
  bool isDark = false;

  init(BuildContext context) async {
    String? uid = auth.currentUser?.uid;
    log('data: $uid');
    // CollectionReference _collectionRef = db.collection('users');
    // Future<void> getData() async {
    //   // Get docs from collection reference
    //   QuerySnapshot querySnapshot = await _collectionRef.get();
    //
    //   // Get data from docs and convert map to List
    //   final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //
    //   print(allData);
    // }
    // getData();
    DocumentSnapshot variable = await db.collection('users').doc(uid).get();
    var s= variable.data() as Map<String, dynamic>;
    print(s.runtimeType);
    var data = await db.collection('users').doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        user = userModelFromJson(s);
        print('Document exists on the database');
      }
    }).catchError((error) => print("Failed to add user: $error"));
  ;;


    isLoaded = true;
    final ThemeData theme = Theme.of(context);
    isDark = theme.brightness == Brightness.dark;
    notifyListeners();
  }

  void signOut() async {
    await auth.signOut();
  }

  void deleteAccount() async {
    String? uid = auth.currentUser?.uid;
    await db.collection('users').doc(uid).delete();
  }

  void changeDetails() {}

  void changeTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}

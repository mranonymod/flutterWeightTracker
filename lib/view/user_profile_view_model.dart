import 'dart:convert';

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
    var data = await db.collection('users').doc(uid).get();
    log('data: ${data.data()}');
    user = userModelFromJson(data.data());
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_conference/models/userData.dart';
import 'package:my_conference/pages/feedPage.dart';
import 'package:my_conference/pages/loginPage.dart';
import 'package:provider/provider.dart';

class AuthService {

  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;

  static void signUpUser(BuildContext context, String name, String email, String password) async{
    try{
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      
      FirebaseUser signedInUser = authResult.user;
      
      //create user in db
      if(signedInUser != null){
        _firestore.collection('/users').document(signedInUser.uid).setData({
          'name' : name,
          'email' : email,
        });
        Provider.of<UserData>(context).currentUserId = signedInUser.uid;
        Navigator.pop(context);
      }

    } catch (e){
      print(e);
    }
  }

  static void logout(){
    _auth.signOut();
  }

  static void login(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    }
    catch (e){
      print(e);
    }
    
  }

}
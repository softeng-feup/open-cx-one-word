import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String id;
  final String name;
  final String email;

  User({
    this.id,
    this.name,
    this.email
  });
  factory User.fromDoc(DocumentSnapshot document){
    return User(
      id: document.documentID,
      name: document['name'],
      email: document['email'],
    );
  }
}
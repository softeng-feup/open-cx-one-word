import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String id;
  final String name;
  final String email;
  final String bio;
  final String profileImgUrl;

  User({
    this.id,
    this.name,
    this.email,
    this.bio,
    this.profileImgUrl
  });

  factory User.fromDoc(DocumentSnapshot document){
    return User(
      id: document.documentID,
      name: document['name'],
      email: document['email'],
      bio: document['bio'] ?? '',
      profileImgUrl: document['profileImgUrl'],
    );
  }
}
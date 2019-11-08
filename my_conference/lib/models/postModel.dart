import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  final String id;
  final String imgUrl;
  final String description;
  final dynamic likes;
  final String authorId;
  final Timestamp timestamp;

  Post({
    this.id,
    this.imgUrl,
    this.description,
    this.authorId,
    this.likes,
    this.timestamp
  });

  factory Post.fromDoc(DocumentSnapshot document){
    return Post(
      id: document.documentID,
      imgUrl: document['imgUrl'],
      description: document['description'],
      likes: document['likes'],
      authorId: document['authorId'],
      timestamp: document['timestamp'],
    );
  }
}
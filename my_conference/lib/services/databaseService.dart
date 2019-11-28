import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_conference/models/postModel.dart';
import 'package:my_conference/utilities/vars.dart';

class DatabaseService{
  static void createPost(Post post) {
    postsRef.document(post.authorId).collection('usersPosts').add({
      'imgUrl': post.imgUrl,
      'description': post.description,
      'likes': post.likes,
      'authorId': post.authorId,
      'timestamp': post.timestamp,
    });
  }

  static Future<QuerySnapshot> getPostsFromUser(String uid) {
    Future<QuerySnapshot> snapshots = postsRef.document(uid).collection('usersPosts').getDocuments();
    return snapshots;
  }


  //TODO
  //Maybe we need to use Algolia here to implement user search with better results
  static Future<QuerySnapshot> searchUsers(String name) {
    Future<QuerySnapshot> snapshots = usersRef.where('name', isGreaterThanOrEqualTo: name).getDocuments();
    return snapshots;
  }
}
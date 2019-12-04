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

  static Future<QuerySnapshot> getAllPosts() {
    return postsRef.orderBy('timestamp', descending: true).getDocuments();
  }

  static Future<DocumentSnapshot> getUserDoc(String uid) async {
    return usersRef.document(uid).get();
  }

  static  Future<String> getNameOfUserId(String uid) async {
    DocumentSnapshot doc = await getUserDoc(uid);
    return doc.data['name'].toString();
  }

  static Future<List<String>> getNameOfUserFromPosts(List<DocumentSnapshot> posts) async {
    List<String> names = [];

    for(int i = 0; i < posts.length; i++) {
      String name = await getNameOfUserId(posts[i]['authorId']);
      names.add( name);
    }
    return names;
  }

  //TODO
  //Maybe we need to use Algolia here to implement user search with better results
  static Future<QuerySnapshot> searchUsers(String name) {
    Future<QuerySnapshot> snapshots = usersRef.where('name', isGreaterThanOrEqualTo: name).where('name', isLessThan: name + 'z').getDocuments();
    return snapshots;
  }
}
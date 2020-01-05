import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_conference/models/postModel.dart';
import 'package:my_conference/models/userModel.dart';
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
    Future<QuerySnapshot> snapshots = postsRef.document(uid).collection('usersPosts').orderBy('timestamp', descending: true).getDocuments();
    return snapshots;
  }

  /* static Future<QuerySnapshot> getAllPosts(String currentUserId) {
    //return postsRef.orderBy('timestamp', descending: true).getDocuments();
    Future<QuerySnapshot> snapshots = Firestore.instance.collectionGroup('usersPosts').orderBy('timestamp', descending: true).getDocuments(); //.document(uid).collection('usersPosts').orderBy('timestamp', descending: true).getDocuments();
    return snapshots;
  } */

  static Future<List<Post>> getAllPosts(String userId) async{
    QuerySnapshot activitySnap = await Firestore.instance.collectionGroup('usersPosts').orderBy('timestamp', descending: true).getDocuments();
    List<Post> posts = activitySnap.documents.map((doc) => Post.fromDoc(doc)).toList();
    return posts;
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

  static void updateUser(User user){
    usersRef.document(user.id).updateData({
      'name': user.name,
      'profileImgUrl': user.profileImgUrl,
      'bio': user.bio,
    });
  }

  //followUserById
  static void unfollowUser(String currentUserId, String userIdFollow){
    //remove from following
    followingRef.document(currentUserId).collection('userFollowing').document(userIdFollow).get().then((doc) {
      if(doc.exists){
        doc.reference.delete();
      }
    });
    //remove user from follower
    followersRef.document(userIdFollow).collection('userFollowers').document(currentUserId)..get().then((doc) {
      if(doc.exists){
        doc.reference.delete();
      }
    });
  }

  static void followUser(String currentUserId, String userIdFollow){
    //add to following
    followingRef.document(currentUserId).collection('userFollowing').document(userIdFollow).setData({});
    //add user to follower
    followersRef.document(userIdFollow).collection('userFollowers').document(currentUserId).setData({});
  }

  static Future<bool> isFollowingUser(String currentUserId, String userIdFollow) async {
    DocumentSnapshot followingDocument = await followersRef.document(userIdFollow).collection('userFollowers').document(currentUserId).get();
    //return bool if exists
    return followingDocument.exists;
  }

  static Future<int> numFollowing(String userId) async {
    QuerySnapshot followingQuery = await followingRef.document(userId).collection('userFollowing').getDocuments();
    return followingQuery.documents.length;
  }

  static Future<int> numFollowers(String userId) async{
    QuerySnapshot followersQuery = await followersRef.document(userId).collection('userFollowers').getDocuments();
    return followersQuery.documents.length;
  }

   static Future<User> getUserById(String userId) async {
    DocumentSnapshot userDocSnap = await usersRef.document(userId).get();
    if (userDocSnap.exists) {
      return User.fromDoc(userDocSnap);
    }
    return User();
  }

  static Future<List<Post>> getFeedPosts(String userId) async{
    QuerySnapshot feedSnap = await feedsRef
      .document(userId)
      .collection('userFeed')
      //order by time
      .orderBy('timestamp', descending: true)
      .getDocuments();
    List<Post> posts = feedSnap.documents.map((doc) => Post.fromDoc(doc)).toList();
    return posts;
  }
}
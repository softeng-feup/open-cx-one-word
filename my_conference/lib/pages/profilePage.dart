import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_conference/models/postModel.dart';
import 'package:my_conference/services/databaseService.dart';

class ProfilePage extends StatefulWidget {

  final String userId;
  ProfilePage({this.userId});
  

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  //Future<QuerySnapshot> posts = DatabaseService.getPostsFromUser("gg");
  List<DocumentSnapshot> posts;
  _getPosts() async{
    QuerySnapshot query = await DatabaseService.getPostsFromUser(widget.userId);
    posts = query.documents;
    

    //DEBUG PRINT POSTS imgURL
    posts.forEach((data) => print(data['imgUrl']));
  }


 /*  Widget _buildProfilePosts(){
  return ListView.builder(
    itemBuilder: (context, index){
      if(index < posts.length){
        return _buildPostItem(posts[index]);
      }
      return null;
    },
  );
}  */

Widget _buildPostItem(Post post){
  return Row(
    children: <Widget>[
      Center(
        child: CachedNetworkImage(imageUrl: post.imgUrl,),
      ),
      Text(post.description),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,

          ),
        )
      ),      
      body: Center(
        child: RaisedButton(
          child: Text("GetPostImgUrl"),
            onPressed: () {
              _getPosts();
    },
),

        ),
      
    );
  }
}
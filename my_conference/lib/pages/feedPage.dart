import 'package:flutter/material.dart';
import 'package:my_conference/services/authService.dart';
import 'package:my_conference/services/databaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FeedPage extends StatefulWidget {

  static final String id = 'feedPage';

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  Future<List<DocumentSnapshot>> _getPosts() async {
    QuerySnapshot query = await DatabaseService.getAllPosts();
    return query.documents;
  }

  Widget buildPosts(BuildContext context, AsyncSnapshot snapshot) {
    List<DocumentSnapshot> posts = snapshot.data;
    Future<List<String>> names = DatabaseService.getNameOfUserFromPosts(posts);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return new ListView.builder(
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        Future<String> name = DatabaseService.getNameOfUserId(posts[index]['authorId']);

        return Container (
          color: Color(0xFFEBE1E1),
          child: Row(children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: CachedNetworkImage(
                        height: width / 3,
                        width: width / 3,
                        fit: BoxFit.contain,
                        imageUrl: posts[index]['imgUrl'],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 3* width / 10,
                      ),
                      child: Container(
                        height: 3 * width / 10,
                        margin: EdgeInsets.only(right: 5),
                        child: SingleChildScrollView(
                          child: Text(posts[index]['description']),
                        ),
                      )
                  ),
                  Container(
                    child: Text(names[index]),
                  ),
                ],
              ),
            ),
          ]),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    var userPosts = ;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C2D19),
        centerTitle: true,
        title: Text(
          'MyConference',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,

          ),
        )
      ),
      body: userPosts
    );
  }
}
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

  Future<List<DocumentSnapshot>> _getPosts() async {
    QuerySnapshot query = await DatabaseService.getPostsFromUser(widget.userId);
    List<DocumentSnapshot> posts = query.documents;

    //DEBUG PRINT POSTS imgURL
    //posts.forEach((data) => print(data['imgUrl']));

    return posts;
  }

  Widget buildPosts(BuildContext context, AsyncSnapshot snapshot) {
    Future<String> name = DatabaseService.getNameOfUserId(widget.userId);
    List<DocumentSnapshot> posts = snapshot.data;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
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
                        maxHeight: width / 3,
                      ),
                      child: Container(
                        height: width / 3,
                        margin: EdgeInsets.only(right: 5),
                        child: SingleChildScrollView(
                          child: Text(posts[index]['description']),
                        ),
                      )),
                ],
              ),
            ),
          ]),
        );
        /* return new Column(
            children: <Widget>[
              new ListTile(
                title: new Text(posts[index]['imgUrl']),
              ),
              new Divider(height: 2.0,),
            ],
          ); */
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: _getPosts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new CircularProgressIndicator();
          default:
            if (snapshot.hasError)
              return new CircularProgressIndicator();
            else
              return buildPosts(context, snapshot);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF8C2D19),
          centerTitle: true,
          title: Text(
            'Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          )),
      body: Column(
              children: <Widget>[ 
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage('https://byuc.files.wordpress.com/2012/07/avat-2.jpg'),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: 150,
                            child: FlatButton(
                              onPressed: () => print('Edit Profile button Pressed'),
                              color: Colors.blue,
                              textColor: Colors.white,
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Username',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    Text('Bio'),
                  ],
                ),
                Expanded(child: futureBuilder),
              ],
            ),
        
    );
  }
}

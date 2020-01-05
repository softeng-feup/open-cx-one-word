import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_conference/models/postModel.dart';
import 'package:my_conference/models/userData.dart';
import 'package:my_conference/models/userModel.dart';
import 'package:my_conference/pages/editProfilePage.dart';
import 'package:my_conference/pages/homePage.dart';
import 'package:my_conference/pages/loginPage.dart';
import 'package:my_conference/services/authService.dart';
import 'package:my_conference/services/databaseService.dart';
import 'package:my_conference/utilities/vars.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  final String currentUserId;

  ProfilePage({this.currentUserId, this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  bool isFollowing = false;
  int followerCount = 0;
  int followingCount = 0;

  void initState(){
    super.initState();
    _initIsFollowing();
    _initFollowers();
    _initFollowing();
  }

  _initIsFollowing() async{
    bool isFollowingUser = await DatabaseService.isFollowingUser(widget.currentUserId, widget.userId);
    setState(() {
      isFollowing = isFollowingUser;
    });
  }

  _initFollowers() async{
    int userFollowersCount = await DatabaseService.numFollowers(widget.userId);
    setState(() {
      followerCount = userFollowersCount;
    });
  }

  _initFollowing() async{
    int userFollowingCount = await DatabaseService.numFollowing(widget.userId);
    setState(() {
      followingCount = userFollowingCount;
    });
  }

  _followOrUnfollow() {
    if(isFollowing) {
      _unfollowUser();
    }
    else{
      _followUser();
    }
  }

  _unfollowUser() {
    DatabaseService.unfollowUser(widget.currentUserId, widget.userId);
    setState(() {
      isFollowing = false;
      followerCount--;
    });
  }

  _followUser() {
    DatabaseService.followUser(widget.currentUserId, widget.userId);
    setState(() {
      isFollowing = true;
      followerCount++;
    });
  }

  _displayButton(User user){
    return user.id == Provider.of<UserData>(context).currentUserId ? Container(
                  width: 150,
                  child: FlatButton(
                    onPressed: () => Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (_) => EditProfilePage(user: user),
                      )
                    ),
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ) : 
                Container(
                  width: 150,
                  child: FlatButton(
                    onPressed: _followOrUnfollow,
                    color: isFollowing ? Colors.grey : Colors.blue,
                    textColor: isFollowing ? Colors.black : Colors.white,
                    child: Text(
                      isFollowing ? 'Unfollow' : 'Follow',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                );
  }

  _showLogoutDialog() {
    return Platform.isAndroid ? _androidDialog() : _iosDialog();
  }

  _iosDialog() {
    //TODO
    print('ios');
  }

  _androidDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Logout'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Logout'),
                onPressed: () => {
                  AuthService.logout(),
                  Navigator.pop(context, true),
                  Navigator.pushNamed(context, LoginPage.id)
                },
              ),
              SimpleDialogOption(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }
  //Future<QuerySnapshot> posts = DatabaseService.getPostsFromUser("gg");

  Future<List<DocumentSnapshot>> _getPosts() async {
    QuerySnapshot query = await DatabaseService.getPostsFromUser(widget.userId);
    List<DocumentSnapshot> posts = query.documents;

    //DEBUG PRINT POSTS imgURL
    //posts.forEach((data) => print(data['imgUrl']));

    return posts;
  }

  Future<DocumentSnapshot> _getUser() async {
    DocumentSnapshot query = await DatabaseService.getUserDoc(widget.userId);
    return query;
  }

  Widget buildUser(BuildContext context, AsyncSnapshot snapshot) {
    User user = User.fromDoc(snapshot.data);
    return new ListView(shrinkWrap: true, children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              radius: 45,
              backgroundImage: user.profileImgUrl == null ? AssetImage('assets/images/profile_placeholder.png') : CachedNetworkImageProvider(user.profileImgUrl),
            ),
            Column(
              children: <Widget>[
                _displayButton(user),
              ],
            )
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              user.name,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(user.bio?.isEmpty ? '' : user.bio),
          ],
        ),
      ),
    ]);
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
    var futureBuilderPosts = new FutureBuilder(
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

    var futureBuilderUser = new FutureBuilder(
      future: _getUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new CircularProgressIndicator();
          default:
            if (snapshot.hasError)
              return new CircularProgressIndicator();
            else
              return buildUser(context, snapshot);
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
          ),
          actions: <Widget>[
            IconButton(
              color: Colors.black,
              icon: Icon(Icons.power_settings_new),
              onPressed: () => _showLogoutDialog(),
            )
          ],
        ),
      body: Column(
        children: <Widget>[
          futureBuilderUser,
          Expanded(child: futureBuilderPosts),
        ],
      ),
    );
  }
}

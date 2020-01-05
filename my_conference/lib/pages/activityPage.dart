import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_conference/models/postModel.dart';
import 'package:my_conference/models/userModel.dart';
import 'package:my_conference/pages/profilePage.dart';
import 'package:my_conference/services/databaseService.dart';

class ActivityPage extends StatefulWidget {
  static final String id = 'feedPage';
  final String currentUserId;

  ActivityPage({this.currentUserId});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<Post> _posts = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initActivity();
  }

  _initActivity() async{
    List<Post> posts = await DatabaseService.getAllPosts(widget.currentUserId);
    if (!mounted) return;
    setState(() {
      _posts = posts;
    });
  }

  _buildPost(Post post, User author){
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                        imageUrl: post.imgUrl,
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
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProfilePage(currentUserId: widget.currentUserId, userId: post.authorId,)
                                  )
                                ),
                                child : Text(
                                  author != null ? author.name : '',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                              ),
                               //author null sometimes???? fixed?
                              Text(post.description),
                            ],
                          ),
                          
                        ),
                      )),
                ],
              ),
            ),
          ]),
        );
  }

  @override
  Widget build(BuildContext context) {

    var userPosts = 'GG';

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
      body: RefreshIndicator(
        onRefresh: () => _initActivity(),
        child: ListView.builder(
          itemCount: _posts.length,
          itemBuilder: (BuildContext context, int index){
            Post post = _posts[index];
            return FutureBuilder(
              future: DatabaseService.getUserById(post.authorId),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                User author = snapshot.data;
                return _buildPost(post, author);
              },
              );
          },
        ),
      )
    );
  }
}
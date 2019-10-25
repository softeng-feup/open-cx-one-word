import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:path/path.dart';

//import 'post.dart';

void main() => runApp(MyConference());

class MyConference extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyConference',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> posts = [];
  List<String> paths = [];

  void _addPost(Post post){
    setState(() {
      if(post.text != null) posts.add(post.text);
      if(post.path != null) paths.add(post.path); 
    });
  }

  Widget _buildPostList(){
    return ListView.builder(
      itemBuilder: (context, index){
        if(index < posts.length){
          return _buildPostItem(posts[index], paths[index]);
        }
      },
    );
  }

  Widget _buildPostItem(String post, String path){
    /* return ListTile(
      title: Text(post)
    ); */
    return Row(
      children: <Widget>[
        Center(
          child:
          Image.file(File(path))
        ),
        Text(post),
      ]

        
    );
  }

  void _awaitForPost(BuildContext context) async {
    final Post post = await Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostPageWithImage()));
    setState(() {
      _addPost(post);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("MyConference"),
      ),
      body: _buildPostList(),
      bottomNavigationBar:  Container(
        color: Colors.white,
        height: 50,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.add_photo_alternate),
                onPressed: () {
                  _awaitForPost(context);
                },
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {posts.clear(); setState(() {
                });},
              ),
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.account_box),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreatePostPageWithImage extends StatefulWidget {
  @override
  _CreatePostPageWithImageState createState() => _CreatePostPageWithImageState();
}

class _CreatePostPageWithImageState extends State<CreatePostPageWithImage> {
  
  final TextEditingController postController = TextEditingController();
  File _image;
  String path;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    // getting a directory path for saving
    Directory tempDir = await getTemporaryDirectory();
    String fileName = basename(image.path);
    File backupImage = await image.copy(path = tempDir.path + "/" + fileName);
    setState(() {
      _image = image;
      path = tempDir.path + "/" + fileName;
    });
  }


  void _sendDataBack(BuildContext context){
    String textPost = postController.text;
    Navigator.pop(context, Post(path, textPost));
  }  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("MyConference - Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            
            Center(
              child: _image == null
              ? Text('No image selected.')
              : Image.file(_image),
            ),
            TextField(
              controller: postController,
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                labelText: 'Descrição',
              ),
              maxLength: 50,
              maxLengthEnforced: true,
            ),
            RaisedButton(
              child: Text("Post"),
              onPressed: () {_sendDataBack(context);},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),

      bottomNavigationBar:  Container(
        color: Colors.white,
        height: 50,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.add_photo_alternate),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.account_box),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Post {
  final String path;
  final String text;

  Post(this.path, this.text);
}
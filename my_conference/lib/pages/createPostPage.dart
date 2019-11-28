import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_conference/models/postModel.dart';
import 'package:my_conference/models/userData.dart';
import 'package:my_conference/services/databaseService.dart';
import 'package:my_conference/services/storageService.dart';
import 'package:provider/provider.dart';

class CreatePostPage extends StatefulWidget {
  static final String id = 'createPostPage';

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  File _image;
  TextEditingController _descriptionController = TextEditingController();
  String _description = '';
  bool _isLoading = false;

  _showSelectImageDialog() {
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
            title: Text('Add Photo'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Take Photo'),
                onPressed: () => _handleImage(ImageSource.camera),
              ),
              SimpleDialogOption(
                child: Text('Gallery'),
                onPressed: () => _handleImage(ImageSource.gallery),
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

  _handleImage(ImageSource source) async {
    Navigator.pop(context);
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      image = await _cropImage(image);
      setState(() {
        _image = image;
      });
    }
  }

  _cropImage(File image) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0), //square image
    );
    return croppedImage;
  }

  _submit() async {
    print('IM IN');
    if (!_isLoading && _image != null && _description != null) {
      setState(() {
        _isLoading = true;
        print('isLoading');
      });
      //Send image to db and create post
      String imgUrl = await StorageService.uploadPost(_image);
      Post post = Post(
        imgUrl: imgUrl,
        description: _description,
        likes: {},
        authorId: Provider.of<UserData>(context).currentUserId,
        timestamp: Timestamp.fromDate(DateTime.now()),
      );

      DatabaseService.createPost(post);
      print('uploaded?');
      //Reset
      _descriptionController.clear();
      setState(() {
        _description = '';
        _image = null;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF8C2D19),
          centerTitle: true,
          title: Text(
            'Create Post',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          actions: <Widget>[
            IconButton(
              color: Colors.black,
              icon: Icon(Icons.add),
              onPressed: () => _submit(),
            )
          ],
        ),
        body: Container(
          color: Color(0xFFEBE1E1),
          child: GestureDetector(
            onTap: () => FocusScope.of(context)
                .unfocus(), //hides keyboard after touching out of it
            child: SingleChildScrollView(
              child: Container(
                height: height,
                child: Column(
                  children: <Widget>[
                    _isLoading
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.blue[200],
                              valueColor: AlwaysStoppedAnimation(Colors.blue),
                            ),
                          )
                        : SizedBox.shrink(),
                    GestureDetector(
                      onTap: _showSelectImageDialog,
                      child: Container(
                        height: width,
                        width: width,
                        color: Colors.grey[400],
                        child: _image == null
                            ? Icon(Icons.add_a_photo,
                                color: Color(0xFFEBE1E1), size: width / 3)
                            : Image(
                                image: FileImage(_image),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        controller: _descriptionController,
                        //style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(labelText: 'Description'),
                        onChanged: (input) => _description = input,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

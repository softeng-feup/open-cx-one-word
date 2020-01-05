import 'dart:core';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_conference/models/userModel.dart';
import 'package:my_conference/services/databaseService.dart';
import 'package:my_conference/services/storageService.dart';

class EditProfilePage extends StatefulWidget {

  final User user;
  EditProfilePage({this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _bio = '';
  File _profileImage;
  bool _isLoading = false;

  @override
  initState(){
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.bio;
  }

  _handleImageFromGallery() async{
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(imageFile != null){
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  _displayProfileImage(){
    if(_profileImage == null){
      if(widget.user.profileImgUrl.isEmpty){
        return AssetImage('assets/images/profile_placeholder.png');
      }
      else{
        return CachedNetworkImageProvider(widget.user.profileImgUrl);
      }
    }
    else{
      return FileImage(_profileImage);
    }
  }

  _submit() async{
    if(_formKey.currentState.validate() && !_isLoading){
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });

      String _profileImgUrl = '';

      if(_profileImage == null){
        _profileImgUrl = widget.user.profileImgUrl;
      }
      else{
        _profileImgUrl = await StorageService.uploadUserProfileImg(widget.user.profileImgUrl, _profileImage);
      }

      User user = User(
        id: widget.user.id,
        name: _name,
        profileImgUrl: _profileImgUrl,
        bio: _bio,
      );

      //DB UPDATE
      DatabaseService.updateUser(user);
      Navigator.pop(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBE1E1),
      appBar: AppBar(
        backgroundColor: Color(0xFF8C2D19),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: <Widget>[
            _isLoading 
              ? LinearProgressIndicator(
                backgroundColor: Colors.blue[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue)
                )
              : SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(radius:60,
                    backgroundImage: _displayProfileImage(),
                    ),
                    FlatButton(
                      onPressed: () => _handleImageFromGallery(),
                      child: Text('Change Profile Image', style: TextStyle(color: Colors.blue),),
                    ),
                    TextFormField(
                      initialValue: _name,
                      style: TextStyle(fontSize:  18.0),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                           size: 30
                          ),
                          labelText: 'Name'
                      ),
                      validator: (input) => input.trim().length < 1
                        ? 'Please enter a valid name'
                        : null,
                      onSaved: (input) => _name = input,
                    ),
                    TextFormField(
                      initialValue: _bio,
                      style: TextStyle(fontSize:  18.0),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.book,
                           size: 30
                          ),
                          labelText: 'Bio'
                      ),
                      validator: (input) => input.trim().length > 150
                        ? 'Please enter a bio less than 150 characters'
                        : null,
                      onSaved: (input) => _bio = input,
                    ),
                    Container(
                      margin: EdgeInsets.all(40),
                      height: 40.0,
                      width: 250,
                      child: FlatButton(
                        onPressed: _submit,
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text(
                          'Save Profile',
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                        ),
                    )
                  ],
                )
                ),
            ),
          ]
          ),
      ),
    );
  }
}
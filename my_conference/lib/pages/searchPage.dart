import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_conference/models/userData.dart';
import 'package:my_conference/models/userModel.dart';
import 'package:my_conference/pages/profilePage.dart';
import 'package:my_conference/services/databaseService.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {

  static final String id = 'searchPage';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> _userQuery; 

  _buildUser(User user){
    return ListTile(
      title: Text(user.name),
      onTap: () => Navigator.push(
        context, MaterialPageRoute(
          builder: (_) => ProfilePage(
            currentUserId: Provider.of<UserData>(context).currentUserId,
            userId: user.id,
            ),
          ),
        ),
    );
  }

  _clearSearch(){
    _searchController.clear();
    setState(() {
      _userQuery = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C2D19),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15), //align with search icon
            border: InputBorder.none, //remove line from search
            hintText: 'Search User',
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => _clearSearch(),
            ),
            filled: true,
          ),
          onSubmitted: (input) {
            if(input.isNotEmpty) {
              setState(() {
                _userQuery = DatabaseService.searchUsers(input);
              });
            }
          },
        ),
      ),
      body: Container(
        color: Color(0xFFEBE1E1),
        child: _userQuery == null 
          ? Center(
            child: Text('Search Page'),
            )
          : FutureBuilder(
          future: _userQuery,
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Container(
                color: Color(0xFFEBE1E1),
                child: Center(
                  child: CircularProgressIndicator(),
                  ),
              );
            }
            if (snapshot.data.documents.length == 0){
              return Center(
                child: Text('0 Results'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                User user = User.fromDoc(snapshot.data.documents[index]);
                return _buildUser(user);
              },
            );
        }),
      )
    );
  }
}
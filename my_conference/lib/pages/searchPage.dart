import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {

  static final String id = 'searchPage';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Search',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,

          ),
        )
      ),
      body: Center(child: Text('Search'),),
    );
  }
}
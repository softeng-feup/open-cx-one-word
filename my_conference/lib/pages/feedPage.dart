import 'package:flutter/material.dart';
import 'package:my_conference/services/authService.dart';

class FeedPage extends StatefulWidget {

  static final String id = 'feedPage';

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: FlatButton(
          onPressed: () => AuthService.logout(),
          color: Colors.blue,
          child: Text('Logout'),
        ),
      ),
    );
  }
}
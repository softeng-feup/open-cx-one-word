import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:my_conference/models/userData.dart';
import 'package:my_conference/pages/feedPage.dart';
import 'package:my_conference/pages/homePage.dart';
import 'package:my_conference/pages/loginPage.dart';
import 'package:my_conference/pages/signupPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Widget _getPageId(){
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){ //if logged in
          Provider.of<UserData>(context).currentUserId = snapshot.data.uid;
          return HomePage();
        }
        else{                 //if not logged in
          return LoginPage();
        }
      },
    );
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => UserData(),
          child: MaterialApp(
        title: 'My Conference',
        debugShowCheckedModeBanner: false,
        home: _getPageId(),
        routes: {
          LoginPage.id: (context) => LoginPage(),
          SignupPage.id: (context) => SignupPage(),
          FeedPage.id: (context) => FeedPage(),
          HomePage.id: (context) => HomePage(),
        },
      ),
    );
  }
}
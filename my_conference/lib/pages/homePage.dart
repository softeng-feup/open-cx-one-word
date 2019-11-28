import 'package:flutter/material.dart';
import 'package:my_conference/models/userData.dart';
import 'package:my_conference/pages/activityPage.dart';
import 'package:my_conference/pages/createPostPage.dart';
import 'package:my_conference/pages/feedPage.dart';
import 'package:my_conference/pages/profilePage.dart';
import 'package:my_conference/pages/searchPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  static final String id = 'homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentTab = 0;
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          FeedPage(),
          SearchPage(),
          CreatePostPage(),     
          ActivityPage(),
          ProfilePage(userId: Provider.of<UserData>(context).currentUserId),
        ],
        onPageChanged: (int index){
          setState(() {
            _currentTab = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,   
        showUnselectedLabels: false,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        backgroundColor: Colors.black,
        currentIndex: _currentTab,
        onTap: (int index){
          setState(() {
            _currentTab = index;
          });
          _pageController.animateToPage(
            index, 
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn
          );
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo),
            title: Text('Post'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Activity'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text('Account'),
          )
        ],
        
      )
    );
  }
}
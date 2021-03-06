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
    final String currentUserId = Provider.of<UserData>(context).currentUserId;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          FeedPage(currentUserId: currentUserId,),
          SearchPage(),
          CreatePostPage(),     
          ActivityPage(),
          ProfilePage(currentUserId: currentUserId, userId: currentUserId),
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
        unselectedItemColor: Color(0xFFEBE1E1),
        selectedItemColor: Colors.grey,
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
            backgroundColor: Color(0xFF8C2D19),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
            backgroundColor: Color(0xFF8C2D19),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo),
            title: Text('Post'),
            backgroundColor: Color(0xFF8C2D19),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Activity'),
            backgroundColor: Color(0xFF8C2D19),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text('Account'),
            backgroundColor: Color(0xFF8C2D19),
          )
        ],
        
      )
    );
  }
}
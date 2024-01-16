import 'createProjectPage.dart';
import 'package:flutter/material.dart';
import 'searchPage.dart'; 
import 'projectPage.dart'; 
import 'accountPage.dart'; 
import 'mongoConnect.dart';

class MainPage extends StatefulWidget {
  Map<String, dynamic> user;
  MainPage({Key? key, required this.user}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;
  late List<Widget> _widgetOptions = [
      SearchPage(user: widget.user),
      ProjectPage(user: widget.user),
      AccountPage(user: widget.user),
  ];
  

  @override
  void initState() {
    super.initState();
    _refreshUser();
  }

  void _refreshUser() async {
    try {
      String userId = widget.user['username']; // Replace with actual user id key if different
      var freshUserData = await DatabaseManager().fetchUserData(userId);
      if (freshUserData != null) {
        setState(() {
          widget.user = freshUserData; // Update the user data
          _updateWidgetOptions(); // Refresh the pages with the new user data
        });
      } else {
        // Handle the case where no user data was fetched
      }
    } catch (e) {
      // Handle the error
    }
  }
  void _updateWidgetOptions() {
    setState((){
      _widgetOptions = [
        SearchPage(user: widget.user),
        ProjectPage(user: widget.user),
        AccountPage(user: widget.user),
      ];
    });
  }

  void _onItemTapped(int index) async {
    if (_selectedIndex != index) {
       _refreshUser(); // Refresh user data when switching tabs
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DIY HUB'),
        centerTitle: true,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 1 ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateProjectPage(user: widget.user)
            )
          ).then((_) => _refreshUser());
        },
        child: const Icon(Icons.add),
      ) : null,
    );
  }
}

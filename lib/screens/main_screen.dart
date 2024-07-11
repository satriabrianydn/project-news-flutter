import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_flutter/pages/news_list.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String appBarTitle = 'Lazy Media News';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateAppBarTitle(String title) {
    setState(() {
      appBarTitle = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lazy Media News',
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        backgroundColor: Colors.blueGrey[500],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey[500],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://thelazy.media/wp-content/uploads/2017/11/logo-website.png',
                    height: 80,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Categories',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(context, 'Games News', '/api/games?page=1'),
            _buildDrawerItem(context, 'Games Console News',
                '/api/games/console-game?page=1'),
            _buildDrawerItem(
                context, 'E-Sport News', '/api/games/e-sport?page=1'),
            _buildDrawerItem(
                context, 'Update Game News', '/api/games/news?page=1'),
            _buildDrawerItem(
                context, 'Lazy Talk', '/api/games/lazy-talk?page=1'),
            _buildDrawerItem(context, 'PC Games', '/api/games/pc?page=1'),
            _buildDrawerItem(
                context, 'Game Review', '/api/games/review?page=1'),
            _buildDrawerItem(context, 'Tech News', '/api/tech?page=1'),
            _buildDrawerItem(context, 'Tech Cranky-Lounge',
                '/api/tech/cranky-lounge?page=1'),
            _buildDrawerItem(
                context, 'Tech News Update', '/api/tech/news?page=1'),
            _buildDrawerItem(context, 'Tech Setup', '/api/tech/setup?page=1'),
            _buildDrawerItem(
                context, 'Tech Recommend', '/api/tech/recommend?page=1'),
            _buildDrawerItem(context, 'Tech Review', '/api/tech/review?page=1'),
            _buildDrawerItem(context, 'Tech Tip', '/api/tech/tip?page=1'),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Selamat Datang',
          style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily, fontSize: 20),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        backgroundColor: Colors.blueGrey[500],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, String endpoint) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
      ),
      onTap: () {
        Navigator.pop(context);
        _updateAppBarTitle(title);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NewsListScreen(endpoint: endpoint, appBarTitle: title),
          ),
        );
      },
    );
  }
}
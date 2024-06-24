import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_flutter/pages/news_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String appBarTitle = 'News App';

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
          'News App',
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
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
          style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.green,
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

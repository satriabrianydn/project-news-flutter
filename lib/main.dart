import 'package:flutter/material.dart';
import 'models/news.dart';
import 'models/category.dart';
import 'services/news_services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

  static final List<Widget> _widgetOptions = <Widget>[
    CategoryListScreen(),
    Center(child: Text('Favorites')),
    Center(child: Text('Settings')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Categories'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Games News'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsListScreen(endpoint: '/api/games?page=1'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Games Console News'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsListScreen(
                        endpoint: '/api/games/console-game?page=1'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('E-Sport News'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsListScreen(endpoint: '/api/games/e-sport?page=1'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Update Game News'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsListScreen(endpoint: '/api/games/news?page=1'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Lazy Talk'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsListScreen(endpoint: '/api/games/lazy-talk?page=1'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('PC Games'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsListScreen(endpoint: '/api/games/pc?page=1'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Game Review'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsListScreen(endpoint: '/api/games/review?page=1'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Tech News'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsListScreen(endpoint: '/api/tech?page=1'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Tech Cranky-Lounge'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsListScreen(
                        endpoint: '/api/tech/cranky-lounge?page=1'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Tech News Update'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsListScreen(endpoint: '/api/tech/news?page=1'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Tech Setup'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsListScreen(endpoint: '/api/tech/setup?page=1'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Tech Recommend'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsListScreen(endpoint: '/api/tech/recommend?page=1'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Tech Review'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsListScreen(endpoint: '/api/tech/review?page=1'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Tech Tip'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsListScreen(endpoint: '/api/tech/tip?page=1'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
}

class CategoryListScreen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = NewsService().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No categories available'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Category category = snapshot.data![index];
              return ListTile(
                title: Text(category.name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewsListScreen(endpoint: category.endpoint),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}

class NewsListScreen extends StatefulWidget {
  final String endpoint;

  NewsListScreen({required this.endpoint});

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late Future<List<News>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = NewsService().fetchNews(widget.endpoint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News List'),
      ),
      body: FutureBuilder<List<News>>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No news available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                News news = snapshot.data![index];
                return ListTile(
                  leading:
                      Image.network(news.thumb, width: 100, fit: BoxFit.cover),
                  title: Text(news.title),
                  subtitle: Text(news.author),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(news: news),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class NewsDetailScreen extends StatelessWidget {
  final News news;

  NewsDetailScreen({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(news.thumb),
            SizedBox(height: 8.0),
            Text(news.title,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text('By ${news.author} | ${news.time}',
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 16.0),
            Text(news.desc),
          ],
        ),
      ),
    );
  }
}

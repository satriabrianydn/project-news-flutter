import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_flutter/models/news.dart';
import 'package:news_flutter/services/news_services.dart';
import 'package:news_flutter/pages/news_detail.dart';

class NewsListScreen extends StatefulWidget {
  final String endpoint;
  final String appBarTitle;

  NewsListScreen({required this.endpoint, required this.appBarTitle});

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
        title: Text(
          widget.appBarTitle,
          style: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.poppins().fontFamily),
        ),
        backgroundColor: Colors.grey[600],
        iconTheme: IconThemeData(color: Colors.white),
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
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    title: Text(
                      news.title,
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily),
                    ),
                    leading: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(news.thumb),
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4.0),
                        Text(
                          'Author: ${news.author}',
                          style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily),
                        ),
                        Text(
                          'Tag: ${news.tag}',
                          style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily),
                        ),
                        Text(
                          'Time: ${news.time}',
                          style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewsDetailScreen(newsKey: news.key),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
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
  List<News> newsList = [];
  bool isLoading = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    loadNews();
  }

  Future<void> loadNews() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<News> fetchedNews = await NewsService()
          .fetchNews(widget.endpoint.replaceAll('page=1', 'page=$currentPage'));
      setState(() {
        newsList.addAll(fetchedNews);
        currentPage++;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // Handle error, for example, by showing a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load news: $error')),
      );
    }
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
        backgroundColor: Colors.blueGrey[500],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    News news = newsList[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailScreen(newsKey: news.key),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            news.thumb.isNotEmpty
                                ? Container(
                                    width: double.infinity,
                                    height: 200, // Adjust the height as needed
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(8.0),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(news.thumb),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(8.0),
                                      ),
                                    ),
                                    child: Icon(Icons.image,
                                        size: 100, color: Colors.grey[600]),
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    news.title,
                                    style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Author: ${news.author}',
                                    style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily),
                                  ),
                                  Text(
                                    'Tag: ${news.tag}',
                                    style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily),
                                  ),
                                  Text(
                                    'Time: ${news.time}',
                                    style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (!isLoading)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[500],
                      padding: EdgeInsets.symmetric(
                          vertical:
                              12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8),
                      ),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                    onPressed: loadNews,
                    child: Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center,
                        children: [
                          Text(
                            'Load More',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

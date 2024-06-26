import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_flutter/models/news.dart';
import 'package:news_flutter/services/news_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailScreen extends StatelessWidget {
  final String newsKey;

  NewsDetailScreen({required this.newsKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Berita",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        backgroundColor: Colors.grey[600],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<News>(
        future: NewsService().fetchNewsDetail(newsKey),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No details available'));
          } else {
            News news = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "By ${news.author}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                        Text(
                          news.time,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8.0,
                      children: news.categories?.map((category) {
                            return Chip(
                              label: Text(category),
                              backgroundColor: Colors.grey[200],
                            );
                          }).toList() ??
                          [],
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: news.figure
                              ?.map((url) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Image.network(url),
                                  ))
                              .toList() ??
                          [],
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: news.content?.map((text) {
                            if (text.trim().isEmpty) {
                              return SizedBox.shrink();
                            } else if (text.startsWith('http') &&
                                text.contains('youtube.com/embed')) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Center(
                                  child: AspectRatio(
                                    aspectRatio: 16 /
                                        9,
                                    child: WebView(
                                      initialUrl: text,
                                      javascriptMode:
                                          JavascriptMode.unrestricted,
                                    ),
                                  ),
                                ),
                              );
                            } else if (text.startsWith('http')) {
                              // Jika teks adalah URL gambar, tampilkan gambar
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Center(child: Image.network(text)),
                              );
                            } else {
                              // Teks biasa
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  text,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              );
                            }
                          }).toList() ??
                          [],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

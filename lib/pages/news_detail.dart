import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_flutter/models/news.dart';

class NewsDetailScreen extends StatelessWidget {
  final News news;

  NewsDetailScreen({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Berita",
          style: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.poppins().fontFamily),
        ),
        backgroundColor: Colors.grey[600],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            Text(
              "Penulis: ${news.author}\nTag: ${news.tag}\nWaktu: ${news.time}",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Image.network(news.thumb),
            ),
            SizedBox(height: 20),
            // Text(
            //   "Deskripsi:",
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //     fontFamily: GoogleFonts.poppins().fontFamily,
            //   ),
            // ),
            SizedBox(height: 10),
            Text(
              news.desc,
              style: TextStyle(
                fontSize: 16,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                onPressed: () {
                  print('Test Button');
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[600],
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(0),
                  ),
                ),
                child: Text(
                  'Baca Selengkapnya',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_flutter/models/news.dart';

class FullNewsScreen extends StatelessWidget {
  final News news;

  FullNewsScreen({required this.news});

  @override
  Widget build(BuildContext context) {
    // Log the content to debug
    print('News content: ${news.content}');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Berita Lengkap",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        backgroundColor: Colors.grey[600],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Judul Berita
            Text(
              news.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            SizedBox(height: 10),

            // Informasi Penulis dan Waktu
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

            // Kategori Berita
            Wrap(
              spacing: 8.0,
              children: news.categories.map((category) {
                return Chip(
                  label: Text(category),
                  backgroundColor: Colors.grey[200],
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Gambar Berita
            Column(
              children: news.figure.map((url) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.network(url),
              )).toList(),
            ),
            SizedBox(height: 20),

            // Konten Berita
            Column(
              children: news.content.map((text) {
                if (text.trim().isEmpty) {
                  return SizedBox.shrink(); // Jika teks kosong, jangan tampilkan apa-apa
                } else if (text.startsWith('http') && text.contains('youtube.com/embed')) {
                  // Tampilkan video YouTube menggunakan WebView
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        // WebView(
                        //   initialUrl: text,
                        //   javascriptMode: JavascriptMode.unrestricted,
                        // ),
                      ),
                    ),
                  );
                } else if (text.startsWith('http')) {
                  // Tampilkan gambar jika URL dimulai dengan 'http'
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(child: Image.network(text)),
                  );
                } else {
                  // Tampilkan teks biasa
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  );
                }
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

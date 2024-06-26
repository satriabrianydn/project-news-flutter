import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_flutter/models/news.dart';
import 'package:news_flutter/models/category.dart';

class NewsService {
  final String baseUrl = "https://the-lazy-media-api.vercel.app/";

  // Fetch Categories
  Future<List<Category>> fetchCategories() async {
    List<Category> categories = [
      Category(name: "Games News", endpoint: "/api/games?page=1"),
      Category(name: "Games Console News", endpoint: "/api/games/console-game?page=1"),
      Category(name: "E-Sport News", endpoint: "/api/games/e-sport?page=1"),
      Category(name: "Update Game News", endpoint: "/api/games/news?page=1"),
      Category(name: "Lazy Talk", endpoint: "/api/games/lazy-talk?page=1"),
      Category(name: "PC Games", endpoint: "/api/games/pc?page=1"),
      Category(name: "Tech News", endpoint: "/api/tech?page=1"),
      Category(name: "Tech Cranky-Lounge", endpoint: "/api/tech/cranky-lounge?page=1"),
      Category(name: "Tech News Update", endpoint: "/api/tech/news?page=1"),
      Category(name: "Tech Setup", endpoint: "/api/tech/setup?page=1"),
      Category(name: "Tech Recommend", endpoint: "/api/tech/recommend?page=1"),
      Category(name: "Tech Review", endpoint: "/api/tech/review?page=1"),
      Category(name: "Tech Tip", endpoint: "/api/tech/tip?page=1"),
    ];
    return categories;
  }

  // Fetch News List
  Future<List<News>> fetchNews(String endpoint) async {
    final response = await http.get(Uri.parse(baseUrl + endpoint));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<News> newsList = jsonResponse.map((json) => News.fromJson(json)).toList();
      return newsList;
    } else {
      throw Exception('Failed to load news');
    }
  }

  // Fetch News Detail
  Future<News> fetchNewsDetail(String key) async {
    final response = await http.get(Uri.parse(baseUrl + 'api/detail/' + key));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('API Response: $data');  // Debugging line to print API response
      return News.fromJson(data, isDetail: true);
    } else {
      throw Exception('Failed to load news detail');
    }
  }
}

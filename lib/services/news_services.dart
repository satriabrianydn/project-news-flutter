import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_flutter/models/news.dart';
import 'package:news_flutter/models/category.dart';

class NewsService {
  final String baseUrl = "https://the-lazy-media-api.vercel.app";

  // Fetch Categories
  Future<List<Category>> fetchCategories() async {
    List<Category> categories = [
      Category(name: "Games News", endpoint: "/api/games"),
      Category(name: "Games Console News", endpoint: "/api/games/console-game"),
      Category(name: "E-Sport News", endpoint: "/api/games/e-sport"),
      Category(name: "Update Game News", endpoint: "/api/games/news"),
      Category(name: "Lazy Talk", endpoint: "/api/games/lazy-talk"),
      Category(name: "PC Games", endpoint: "/api/games/pc"),
      Category(name: "Tech News", endpoint: "/api/tech"),
      Category(name: "Tech Cranky-Lounge", endpoint: "/api/tech/cranky-lounge"),
      Category(name: "Tech News Update", endpoint: "/api/tech/news"),
      Category(name: "Tech Setup", endpoint: "/api/tech/setup"),
      Category(name: "Tech Recommend", endpoint: "/api/tech/recommend"),
      Category(name: "Tech Review", endpoint: "/api/tech/review"),
      Category(name: "Tech Tip", endpoint: "/api/tech/tip"),
    ];
    return categories;
  }

  // Fetch News List with Pagination
  Future<List<News>> fetchNews(String endpoint, {int page = 1}) async {
    final response = await http.get(Uri.parse("$baseUrl$endpoint?page=$page"));

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

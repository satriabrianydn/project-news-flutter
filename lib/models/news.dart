class News {
  final String title;
  final String thumb;
  final String author;
  final String tag;
  final String time;
  final String desc;
  final String key;
  final List<String> categories;
  final List<String> figure;
  final List<String> content;

  News({
    required this.title,
    required this.thumb,
    required this.author,
    required this.tag,
    required this.time,
    required this.desc,
    required this.key,
    required this.categories,
    required this.figure,
    required this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    List<String> categories = [];
    List<String> figure = [];
    List<String> content = [];

    if (json.containsKey('results')) {
      categories = json['results']['categories'] != null
          ? List<String>.from(json['results']['categories'])
          : [];
      figure = json['results']['figure'] != null
          ? List<String>.from(json['results']['figure'])
          : [];
      content = json['results']['content'] != null
          ? List<String>.from(json['results']['content'])
          : [];
    }

    return News(
      title: json['title'] ?? '',
      thumb: json['thumb'] ?? '',
      author: json['author'] ?? '',
      tag: json['tag'] ?? '',
      time: json['time'] ?? '',
      desc: json['desc'] ?? '',
      key: json['key'] ?? '',
      categories: categories,
      figure: figure,
      content: content,
    );
  }
  String get date => time;
}

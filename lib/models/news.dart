class News {
  final String title;
  final String thumb;
  final String author;
  final String tag;
  final String time;
  final String desc;
  final String key;
  final List<String>? categories;
  final List<String>? figure;
  final List<String>? content;

  News({
    required this.title,
    required this.thumb,
    required this.author,
    required this.tag,
    required this.time,
    required this.desc,
    required this.key,
    this.categories,
    this.figure,
    this.content,
  });

  factory News.fromJson(Map<String, dynamic> json, {bool isDetail = false}) {
    if (isDetail) {
      return News(
        title: json['results']['title'],
        thumb: '', 
        author: json['results']['author'],
        tag: '', 
        time: json['results']['date'],
        desc: '', 
        key: '', 
        categories: List<String>.from(json['results']['categories']),
        figure: List<String>.from(json['results']['figure']),
        content: List<String>.from(json['results']['content']),
      );
    } else {
      return News(
        title: json['title'],
        thumb: json['thumb'],
        author: json['author'],
        tag: json['tag'],
        time: json['time'],
        desc: json['desc'],
        key: json['key'],
      );
    }
  }
}

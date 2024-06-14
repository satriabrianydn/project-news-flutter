class News {
  final String title;
  final String thumb;
  final String author;
  final String tag;
  final String time;
  final String desc;
  final String key;

  News({
    required this.title,
    required this.thumb,
    required this.author,
    required this.tag,
    required this.time,
    required this.desc,
    required this.key,
  });

  factory News.fromJson(Map<String, dynamic> json) {
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

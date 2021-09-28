// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

List<News> newsFromJson(String str) =>
    List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

String newsToJson(List<News> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class News {
  News({
    required this.no,
    required this.q,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.ca,
  });

  String no;
  String q;
  String a;
  String b;
  String c;
  String d;
  String ca;

  factory News.fromJson(Map<String, dynamic> json) => News(
        no: json["no"],
        q: json["q"],
        a: json["a"],
        b: json["b"],
        c: json["c"],
        d: json["d"],
        ca: json["ca"],
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "q": q,
        "a": a,
        "b": b,
        "c": c,
        "d": d,
        "ca": ca,
      };
}

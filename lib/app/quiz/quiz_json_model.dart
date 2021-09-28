// To parse this JSON data, do
//
//     final quizmodel = quizmodelFromJson(jsonString);

import 'dart:convert';

List<Quizmodel> quizmodelFromJson(String str) =>
    List<Quizmodel>.from(json.decode(str).map((x) => Quizmodel.fromJson(x)));

String quizmodelToJson(List<Quizmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quizmodel {
  Quizmodel({
    required this.no,
    required this.q,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.ca,
  });

  int no;
  String q;
  String a;
  String b;
  String c;
  String d;
  String ca;

  factory Quizmodel.fromJson(Map<String, dynamic> json) => Quizmodel(
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

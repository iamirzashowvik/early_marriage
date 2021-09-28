import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:early_marriage/app/modules/mainhome/newsm.dart';
import 'package:early_marriage/app/modules/mainhome/views/mainhome_view.dart';
import 'package:early_marriage/app/quiz/quiz_json_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Newsfeed extends StatefulWidget {
  @override
  _NewsfeedState createState() => _NewsfeedState();
}

class _NewsfeedState extends State<Newsfeed> {
  bool itemX = false;
  var itemXx;
  int lengthx = 0;

  final firestoreInstance = FirebaseFirestore.instance;
  List<dynamic> posts = [];
  load() async {
    await firestoreInstance.collection("post").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        setState(() {
          posts.add(result.data());
        });
        print(result.data()['caption']);
      });
    });
    print(posts[1]['caption']);

    // firestoreInstance.collection("post").doc('jsondoc').get().then((value) {
    //   var itemy = value.data()!['json'];
    //   print(itemy);
    //   final quizmodel = newsFromJson(itemy);
    //   setState(() {
    //     itemXx = newsFromJson(itemy);
    //     lengthx = quizmodel.length;

    //     itemX = true;
    //   });

    // });
  }

  @override
  void initState() {
    load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: posts.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, i) {
                //final itemXx = quizmodelFromJson(jsonEncode(itemy.data()));

                return PostWidget(
                  caption: posts[i]["caption"],
                  no: posts[i]["no"],
                  author: posts[i]["author"],
                  link: posts[i]["link"],
                  sub: posts[i]["sub"],
                  plink: posts[i]["plink"],
                  ca_url: posts[i]["ca_url"],
                  dp_url: posts[i]["dp_url"],
                );
              },
            ),
    );
  }
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:early_marriage/app/quiz/quiz_json_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizHome extends StatefulWidget {
  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  bool itemX = false;
  var itemXx;
  int lengthx = 0;

  final firestoreInstance = FirebaseFirestore.instance;
  load() async {
    await firestoreInstance
        .collection("quiz")
        .doc('jsondoc')
        .get()
        .then((value) {
      var itemy = value.data()!['json'];
      setState(() {
        final quizmodel = quizmodelFromJson(itemy);
        itemXx = quizmodelFromJson(itemy);
        lengthx = quizmodel.length;

        itemX = true;
      });
    });
  }

  @override
  void initState() {
    load();

    super.initState();
  }

  List<dynamic> cans = [];
  List<dynamic> wans = [];
  void selectedOption(String option, String cA, int index, int no) async {
    if (option == cA) {
      cans.contains({"no": no, "ca": cA})
          ? cans.removeWhere((element) => element == {"no": no, "ca": cA})
          : cans.add({"no": no, "ca": cA});
      //  cans.add({"no": no, "ca": cA});
      // Get.snackbar(
      //   'Correct',
      //   'Your answer is write, $no',
      //   colorText: Colors.green,
      //   backgroundColor: Colors.white,
      // );
      // Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.")
      //     .show();
    } else {
      // Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.")
      //     .show();
      wans.contains({"no": no, "ca": cA})
          ? wans.removeWhere((element) => element == {"no": no, "ca": cA})
          : wans.add({"no": no, "ca": cA});
      // Get.snackbar(
      //   'Wrong',
      //   'Your answer is wrong, $no',
      //   colorText: Colors.red,
      //   backgroundColor: Colors.white,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: itemX == false
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: lengthx,
                    itemBuilder: (context, i) {
                      // final itemXx = quizmodelFromJson(jsonEncode(itemy.data()));

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 100,
                            //height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '${itemXx[i].no}. ${itemXx[i].q}',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        selectedOption(itemXx[i].a,
                                            itemXx[i].ca, i, itemXx[i].no);
                                      },
                                      child: Container(
                                          height: 35,
                                          width: 250,
                                          child: Row(
                                            children: [
                                              Icon(Icons.circle_outlined),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                itemXx[i].a,
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ))),
                                  GestureDetector(
                                      onTap: () {
                                        selectedOption(itemXx[i].b,
                                            itemXx[i].ca, i, itemXx[i].no);
                                      },
                                      child: Container(
                                          height: 35,
                                          width: 250,
                                          child: Row(
                                            children: [
                                              Icon(Icons.circle_outlined),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                itemXx[i].b,
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ))),
                                  GestureDetector(
                                      onTap: () {
                                        selectedOption(itemXx[i].c,
                                            itemXx[i].ca, i, itemXx[i].no);
                                      },
                                      child: Container(
                                          height: 35,
                                          width: 250,
                                          child: Row(
                                            children: [
                                              Icon(Icons.circle_outlined),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                itemXx[i].c,
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ))),
                                  GestureDetector(
                                      onTap: () {
                                        selectedOption(itemXx[i].d,
                                            itemXx[i].ca, i, itemXx[i].no);
                                      },
                                      child: Container(
                                          height: 35,
                                          width: 250,
                                          child: Row(
                                            children: [
                                              Icon(Icons.circle_outlined),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                itemXx[i].d,
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ))),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Get.defaultDialog(
                          title: "Right Answer:[${cans}]",
                          middleText: 'Wrong Anser:[${wans}]');
                      cans = [];
                      wans = [];
                    },
                    child: Text('Check Result'))
              ],
            ),
    );
  }
}

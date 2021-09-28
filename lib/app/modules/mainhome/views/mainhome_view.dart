import 'package:cached_network_image/cached_network_image.dart';
import 'package:early_marriage/app/model/box.dart';
import 'package:early_marriage/app/model/webview.dart';
import 'package:early_marriage/app/modules/mainhome/action.dart';
import 'package:early_marriage/app/modules/mainhome/newsfeed.dart';
import 'package:early_marriage/app/quiz/quiz.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/mainhome_controller.dart';

const kblue = Colors.blue;

class MainhomeView extends GetView<MainhomeController> {
  @override
  Widget build(BuildContext context) {
    Get.put<MainhomeController>(MainhomeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Say No To Early Marriage'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(Newsfeed());
                },
                child: CategoryXx('Knowledge-Hub',
                    'https://image.freepik.com/free-vector/education-doodle-concept_98292-6867.jpg'),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(QuizHome());
                },
                child: CategoryXx('Assess knowledge',
                    'https://image.freepik.com/free-vector/man-with-laptop-passing-online-test-checking-answers-flat-vector-illustration_128772-852.jpg'),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(ActionX());
                },
                child: CategoryXx('Take Actions',
                    'https://image.freepik.com/free-vector/youth-empowerment-abstract-concept-vector-illustration-children-young-people-take-charge-take-action-improve-life-quality-democracy-building-youth-activism-involvement-abstract-metaphor_335657-4186.jpg'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final String link;
  final String dp_url;
  final String caption;
  final String plink;
  final String author;
  final String sub;
  final String no;
  final String ca_url;
  PostWidget({
    required this.caption,
    required this.dp_url,
    required this.no,
    required this.author,
    required this.link,
    required this.sub,
    required this.plink,
    required this.ca_url,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //height: 5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(WebViewExample(plink));
                          },
                          child: CircleAvatar(
                            child: CachedNetworkImage(
                              imageUrl: dp_url,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    // colorFilter: ColorFilter.mode(
                                    //     Colors.red, BlendMode.colorBurn)
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                author,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gilroy',
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: kblue,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Text(
                                      sub,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontFamily: 'Gilroy',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    caption,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(WebViewExample(link));
                  },
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      imageUrl: ca_url,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            // colorFilter: ColorFilter.mode(
                            //     Colors.red, BlendMode.colorBurn)
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 5,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

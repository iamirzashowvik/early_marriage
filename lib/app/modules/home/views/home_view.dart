import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    controller.onInit(); // Rather Controller controller = Controller();
    return Scaffold(
      body: Center(
        child: Image.asset('assets/download.png'),
      ),
    );
  }
}

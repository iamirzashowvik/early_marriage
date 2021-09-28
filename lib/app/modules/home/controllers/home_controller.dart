import 'package:early_marriage/app/modules/mainhome/views/mainhome_view.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(MainhomeView());
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}

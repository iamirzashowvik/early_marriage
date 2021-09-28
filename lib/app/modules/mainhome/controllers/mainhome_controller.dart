import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MainhomeController extends GetxController {
  //TODO: Implement MainhomeController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loc();
  }

  loc() async {
    await Geolocator.openLocationSettings();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}

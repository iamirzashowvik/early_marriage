import 'package:get/get.dart';

import '../controllers/mainhome_controller.dart';

class MainhomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainhomeController>(
      () => MainhomeController(),
    );
  }
}

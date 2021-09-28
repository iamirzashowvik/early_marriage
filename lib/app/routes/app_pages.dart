import 'package:get/get.dart';

import 'package:early_marriage/app/modules/home/bindings/home_binding.dart';
import 'package:early_marriage/app/modules/home/views/home_view.dart';
import 'package:early_marriage/app/modules/mainhome/bindings/mainhome_binding.dart';
import 'package:early_marriage/app/modules/mainhome/views/mainhome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAINHOME,
      page: () => MainhomeView(),
      binding: MainhomeBinding(),
    ),
  ];
}

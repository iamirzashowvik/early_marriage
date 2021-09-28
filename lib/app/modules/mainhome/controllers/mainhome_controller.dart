import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MainhomeController extends GetxController {
  //TODO: Implement MainhomeController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loc();
    determinePosition();
  }

  var currentLocation;
  final lat = ''.obs;
  var lng = ''.obs;
  Future<void>? launched;
  String _phone = '999';

  Future<void> makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  bool x = false;
  Future<Position> determinePosition() async {
    //  await Geolocator.openAppSettings();

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device
    var g = await Geolocator.getCurrentPosition();

    // preferences.setDouble('lat', g.latitude);
    // preferences.setDouble('lng', g.longitude);
    print(g.latitude);
    //print(await Geolocator.requestPermission());
    print(await Geolocator.isLocationServiceEnabled());
    lat.value = g.latitude.toString();
    lng.value = g.longitude.toString();
    print(lat);

    return await Geolocator.getCurrentPosition();
  }

  loc() async {
    await Geolocator.openLocationSettings();
  }

  @override
  void onReady() {
    super.onReady();
  }

  final firestoreInstance = FirebaseFirestore.instance;
  @override
  void onClose() {}
  void increment() => count.value++;
  gg() {
    firestoreInstance
        .collection("sos")
        .add({'lat': lat.toString(), 'lng': lng.toString()}).then((value) {
      print(value.id);
      // launched =

      makePhoneCall('tel:999');
    });
  }
}

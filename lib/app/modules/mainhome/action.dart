import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class ActionX extends StatefulWidget {
  @override
  _ActionXState createState() => _ActionXState();
}

class _ActionXState extends State<ActionX> {
  final firestoreInstance = FirebaseFirestore.instance;
  String formattedDate = '';
  getDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(now);
    print(formattedDate);
  }

  @override
  void initState() {
    getDate();

    super.initState();
    determinePosition();
  }

  var currentLocation;
  var lat, lng;
  Future<void>? _launched;
  String _phone = '999';Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  bool x=false;
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
   setState(() {
     lat = g.latitude;
     lng = g.longitude;
   });
    print(lat);

    return await Geolocator.getCurrentPosition();
  }

  bool isNumeric(String s) {
//   ignore: unnecessary_null_comparison
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  bool checkplusminus(String s) {
    if (s.length == 0) {
      return false;
    }
    return s[0].startsWith(RegExp(r'[0-9]'));
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  TextEditingController nid = TextEditingController();
  TextEditingController phone = TextEditingController();
  String date = '';
  String gender = 'Gender';
  int limit = 18;
  final validatekey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:lat==null?Center(child: CircularProgressIndicator()): Form(
          key: validatekey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TFF(nid, 'National ID number', TextInputType.phone),
             //   TFFg(phone, 'Phone number', TextInputType.phone),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DateTimePicker(
                      initialValue: '',
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100),
                      dateLabelText: 'Date',
                      onChanged: (val) {
                        setState(() {
                          date = val;
                        });
                      },
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) => print(val),
                    ),
                  ),
                ),
                DropdownButton<String>(
                  hint: Text(
                    gender,
                    style: TextStyle(color: Colors.black),
                  ),
                  items: <String>['female', 'male'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                      if (gender == 'male') {
                        limit = 21;
                      } else {
                        limit = 18;
                      }
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      print('gggggggggggggg');
                      // print(nid.toString().isNum);
                      // print(nid.toString().isPhoneNumber);
                      // print(nid.toString().isNumericOnly);
                      // print(nid);
                      // print(nid.toString().isNum);

                      print(isNumeric(nid.text));
                      print('gggggggggggggg');
                      print(checkplusminus(nid.text));
                      print('gggggggggggggg');
                      if (validatekey.currentState!.validate() &&
                          isNumeric(nid.text) &&
                          checkplusminus(nid.text)) {
                        if (date == '') {
                          Get.snackbar('Insert', 'date ');
                        } else if (gender == 'Gender') {
                          Get.snackbar('Insert', ' gender');
                        } else {
                          // Get.snackbar('Insert', 'gg');
                          final difference = daysBetween(DateTime.parse(date),
                              DateTime.parse(formattedDate));
                          print(difference);

                          if (difference / 365 >= limit) {
                            Get.snackbar('congo', 'you are verified');
                            firestoreInstance.collection("users").add({
                              'nid': nid.text,
                              'dateOfBirth': date,
                              'varified': true,
                            //  'phone': phone.text,
                              'lat': lat,
                              'lng': lng
                            }).then((value) {
                              print(value.id);
                            });
                          } else {
                            firestoreInstance.collection("users").add({
                              'nid': nid.text,
                              'dateOfBirth': date,
                              'varified': false,
                            //  'phone': phone.text,
                              'lat': lat,
                              'lng': lng
                            }).then((value) {
                              print(value.id);
                            });
                            Get.snackbar('invalid', 'you are not verified');
                          }
                        }
                      } else {
                        Get.snackbar('wrong NID', 'Try Again');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Verify',
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      firestoreInstance
                          .collection("sos")

                          .add({'lat': lat, 'lng': lng}).then((value) {
                        print(value.id);
                        setState(() {
                          _launched = _makePhoneCall('tel:999');
                        });
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius:50,
                      child: Text('Send SOS'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TFF extends StatelessWidget {
  TFF(this.sname, this.name, this.textInputType);

  final TextEditingController sname;
  final String name;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold
                //letterSpacing: .5
                ),
          ),
          TextFormField(
            maxLength: 17,
            keyboardType: textInputType,
            controller: sname,
            validator: (value) {
              if (value!.isEmpty) {
                return '$name can not be empty';
              } else if (value.length != 13 && value.length != 17) {
                return '13/17 digits only';
              }
              //  else if (value.length != 13 || value.length != 17) {
              //   return '13/17 digits only';
              // }

              return null;
            },
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
                // borderRadius: BorderRadius.circular(10)
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
                // borderRadius: BorderRadius.circular(10)
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.0),
                //  borderRadius: BorderRadius.circular(10)
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.0),
                //  borderRadius: BorderRadius.circular(10)
              ),
              filled: true,
              border: InputBorder.none,
              hintText: 'Enter $name',
            ),
          ),
        ],
      ),
    );
  }
}

class TFFg extends StatelessWidget {
  TFFg(this.sname, this.name, this.textInputType);

  final TextEditingController sname;
  final String name;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold
                //letterSpacing: .5
                ),
          ),
          TextFormField(
            maxLength: 11,
            keyboardType: textInputType,
            controller: sname,
            validator: (value) {
              if (value!.isEmpty) {
                return '$name can not be empty';
              } else if (value.length != 11) {
                return '13 digits only';
              }
              //  else if (value.length != 13 || value.length != 17) {
              //   return '13/17 digits only';
              // }

              return null;
            },
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
                // borderRadius: BorderRadius.circular(10)
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
                // borderRadius: BorderRadius.circular(10)
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.0),
                //  borderRadius: BorderRadius.circular(10)
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.0),
                //  borderRadius: BorderRadius.circular(10)
              ),
              filled: true,
              border: InputBorder.none,
              hintText: 'Enter $name',
            ),
          ),
        ],
      ),
    );
  }
}

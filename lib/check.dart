import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

void checkInternet() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
    }
  } on SocketException catch (_) {
    print('not connected');
  }
}

void checkLocation() async {
  print("Location Function");
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);
  if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
    print("location is on");
    print(date);
    getLocation();
  } else {
    print("location is off");
  }
}

void getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  print(position);
}

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  checkInternet();
                },
                child: Text("Internet"),
              ),
              ElevatedButton(
                onPressed: () {
                  checkLocation();
                },
                child: Text("Location"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

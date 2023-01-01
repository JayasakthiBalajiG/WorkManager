import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workmanager/src/workmanager.dart';
import 'package:workmanager/workmanager.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

const task = 'firstTask';

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

printExample() {
  print("testing");
}

void callbackDispatcher() {
  Workmanager().executeTask((task, input) {
    checkInternet();
    getLocation();
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  runApp(const workManager());
}

class workManager extends StatefulWidget {
  const workManager({Key? key}) : super(key: key);

  @override
  State<workManager> createState() => _workManagerState();
}

class _workManagerState extends State<workManager> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WorkManager",
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                var sec = DateTime.now().second.toString();
                await Workmanager().registerOneOffTask(
                  sec,
                  task,
                  initialDelay: Duration(seconds: 5),
                  constraints: Constraints(networkType: NetworkType.connected),
                );
              },
              child: Text("Shedule task"),
            ),
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
    ));
  }
}

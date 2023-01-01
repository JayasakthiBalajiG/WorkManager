import 'dart:collection';
import 'package:flutter/material.dart';

class QueueCheeck extends StatefulWidget {
  const QueueCheeck({Key? key}) : super(key: key);

  @override
  State<QueueCheeck> createState() => _QueueCheeckState();
}

void queueStart() {
  Queue que = new Queue();
  que.add(10);
  que.add(20);
  que.add(30);
  que.add(40);

  for (var i in que) {
    print(i);
  }
}

class _QueueCheeckState extends State<QueueCheeck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              queueStart();
            },
            child: Text("Queue display"),
          ),
        ),
      ),
    );
  }
}

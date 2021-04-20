import 'dart:math';

import 'package:flutter/material.dart';
import 'package:number_slide_animation/number_slide_animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final random = Random();
  int number;

  @override
  void initState() {
    super.initState();

    generateNumber();
  }

  void generateNumber() {
    setState(() {
      number = random.nextInt(1e8.toInt());
      print(number);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Example"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => generateNumber(),
        child: Icon(Icons.refresh),
      ),
      body: Container(
        child: Center(
          child: NumberSlideAnimation(
            number: "$number".padLeft(8),
            duration: const Duration(seconds: 2),
            curve: Curves.decelerate,
            textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            animateOnUpdate: true,
          ),
        ),
      ),
    );
  }
}

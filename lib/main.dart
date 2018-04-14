import "package:flutter/material.dart";
import "choose_instance_page.dart";
import 'routes.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Youtrack Timer",
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ChooseInstancePage(),
      routes: routes,
    );
  }
}

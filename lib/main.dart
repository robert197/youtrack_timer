import "package:flutter/material.dart";
import "login_page.dart";
import "project_list_page.dart";
import "choose_ticket_page.dart";

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final routes = <String, WidgetBuilder> {
    LoginPage.tag: (context) => new LoginPage(),
    ProjectListPage.tag: (context) => new ProjectListPage(),
    ChooseTicketPage.tag: (context) => new ChooseTicketPage()
  };

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Youtrack Timer",
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoginPage(),
      routes: routes,
    );
  }
}

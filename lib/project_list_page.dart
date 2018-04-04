import "package:flutter/material.dart";
import "choose_ticket_page.dart";

class ProjectListPage extends StatefulWidget {
   static String tag = 'project-list-page';
   @override
     State<StatefulWidget> createState() => new _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  @override
    Widget build(BuildContext context) {
      final list = new ListView(
        children: <Widget>[
          new ListTile(
            onTap: () => Navigator.of(context).pushNamed(ChooseTicketPage.tag),
            title: new Text("STGAG")
          ),
        ],
      );

      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Projects"),
          centerTitle: true,
        ),
        body: new Center(
          child: list,
        )
      );
    }
}
import "package:flutter/material.dart";

class ChooseTicketPage extends StatefulWidget {
  static String tag = 'choose-ticket';
  @override
    State<StatefulWidget> createState() => new _ChooseTicketPageState();
}

class _ChooseTicketPageState extends State<ChooseTicketPage> {
  @override
    Widget build(BuildContext context) {
      final ticketNumber = new TextFormField(
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
          hintText: "Number of Ticket",
          prefixText: "STGAG-"
        ),
      );

      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Choose Ticket"),
          centerTitle: true,
        ),
        body: new Center(
          child: new ListView(
            children: <Widget>[
              new SizedBox(height: 12.0),
              ticketNumber
            ],
          ),
        ),
      );
    }
}
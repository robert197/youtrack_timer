import 'package:flutter/material.dart';
import 'login_page.dart';

class ChooseInstancePage extends StatefulWidget {
  static String tag = 'choose-instance-page';

  @override
  State<StatefulWidget> createState() => new _ChooseInstancePageState();
}

class _ChooseInstancePageState extends State<ChooseInstancePage> {
  @override
  Widget build(BuildContext context) {
    
    final text = new Center(
      child: new Text('Enter YouTrack Url',
        style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700)
      ),
    );
  
    final url = new TextFormField(
      keyboardType: TextInputType.url,
      autofocus: false,
      decoration: new InputDecoration(
        hintText: 'youtrack.example.com',
        contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(32.0)),
      ),
    );

    final chooseInstanceButton = new Padding(
      padding: new EdgeInsets.symmetric(vertical: 16.0),
      child: new Material(
        borderRadius: new BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: new MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          color: Colors.lightBlueAccent,
          child: new Text('Next', style: new TextStyle(color: Colors.white),),
          onPressed: () {
            Navigator.of(context).pushNamed(LoginPage.tag);
          }
        ),
      ),
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child: new ListView(
          children: <Widget>[
            new SizedBox(height: 12.0,),
            text,
            new SizedBox(height: 120.0,),
            url,
            new SizedBox(height: 24.0,),
            chooseInstanceButton
          ]
        ),
      ),
    );
  }
}
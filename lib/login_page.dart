import "dart:io";
import "package:flutter/material.dart";

class LoginPage extends StatefulWidget {
  
  @override
    State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
    Widget build(BuildContext context) {

      final text = new Center(
        child: new Text('YOUTRACK LOGIN',
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700)
        )
      );

      final email = new TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Email",
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(32.0)),
        ),
      );

      final password = new TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        obscureText: true,
        decoration: new InputDecoration(
          hintText: "Password",
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(32.0)),
        ),
      );

      final loginButton = new Padding(
      padding: new EdgeInsets.symmetric(vertical: 16.0),
      child: new Material(
        borderRadius: new BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: new MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            
            // Navigator.of(context).pushNamed(HomePage.tag);
          },
          color: Colors.lightBlueAccent,
          child: new Text('Log In', style: new TextStyle(color: Colors.white)),
        ),
      ),
    );

      return new Scaffold(
        backgroundColor: Colors.white,
        body: new Center(
          child: new ListView(
            children: <Widget>[
              new SizedBox(height: 12.0),
              text,
              new SizedBox(height: 120.0),
              email,
              new SizedBox(height: 24.0),
              password,
              new SizedBox(height: 24.0),
              loginButton
            ],
          ),
        ),
      );
    }
}
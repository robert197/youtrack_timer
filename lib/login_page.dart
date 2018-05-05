import 'dart:async';
import "package:flutter/material.dart";
import "project_list_page.dart";
import 'dart:convert';
import 'dart:io' as io;
import 'package:youtrack_timer/data/database_helper.dart';
import 'package:youtrack_timer/models/service_information.dart';
import 'package:youtrack_timer/models/authentication.dart';
import 'package:youtrack_timer/utils/network_util.dart';
import 'package:youtrack_timer/rest_urls.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
    State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginData {
  String username = '';
  String password = '';
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  _LoginData loginData = new _LoginData();
  DatabaseHelper _db = new DatabaseHelper();
  bool networkError = false;
  bool isLoading = false;

  @override
  void initState() {
    _db.getAuthentiction().then((Authentication auth) {
      if (auth != null) {
        Navigator.of(context).pushNamed(ProjectListPage.tag);
      }
    });
    super.initState();
  }

  Map<String, String> createBasicAuthHeader(String id, String secret) {
      Base64Encoder _base64Encoder = new Base64Encoder();
      Utf8Encoder _utf8Encoder = new Utf8Encoder();    

      return {
        'Authorization': 'Basic ' + _base64Encoder.convert(_utf8Encoder.convert(id + ':' + secret)),
        'Content-Type': 'application/x-www-form-urlencoded'
      };
  }

  Future<Authentication> _fetchAuthentication () {
     NetworkUtil networkUtil = new NetworkUtil();

      return _db.getServiceInformation()
      .then((ServiceInformation serviceInformation) {

        var response = networkUtil.post(
          serviceInformation.serviceHubUrl + URL_GET_AUTH_TOKEN, 
          headers: createBasicAuthHeader(serviceInformation.serviceId, serviceInformation.serviceSecret), 
          body: {
            'username': loginData.username, 
            'password': loginData.password, 
            'grant_type':'password',
            'scope': serviceInformation.ringServiceId
          }
        );

        return response.then((dynamic res){
          if (res is io.IOException || res is Exception) {
            return null;
          }

          return new Authentication.map({
            'tokenType': res['token_type'],
            'accessToken': res['access_token']
          });
        });
      });
  }

  void _saveAuthentication(Authentication auth) async {
    await _db.saveAuthentication(auth);
  }

  void _submitLogin() async {
    if(formKey.currentState.validate()) {
      setState(() { isLoading = true; });
      formKey.currentState.save();

      Authentication auth = await _fetchAuthentication();
      
      if (auth != null) {
        _saveAuthentication(auth);
        Navigator.of(context).pushNamed(ProjectListPage.tag);
      
      } else {
        setState(() { networkError = true; });
      }

      setState(() { isLoading = false; });
    }
  }

  @override
    Widget build(BuildContext context) {

      final text = new Center(
        child: new Text('YouTrack Login',
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700)
        )
      );

      final usernameInput = new TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Username",
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(32.0)),
        ),
        validator: (val) => val.isEmpty ? 'Username can\'t be empty.' : null,
        onSaved: (String value) {
          loginData.username = value;
        },
      );

      final passwordInput = new TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Password",
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(32.0)),
        ),
        validator: (val) => val.isEmpty ? 'Password can\'t be empty.' : null,
        onSaved: (String value) {
          loginData.password = value;
        },
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
            onPressed: _submitLogin,
            color: Colors.lightBlueAccent,
            child: new Text('Log In', style: new TextStyle(color: Colors.white)),
          ),
        ),
      );

      var errorOutputText = new SizedBox(
        height: 10.0, 
        child: new Center(
          child: new Text(
            networkError ? 'Network error. Please try again.':'', 
            style: new TextStyle(color: Colors.red),
          )
        )
      );

      return new Scaffold(
        backgroundColor: Colors.white,
        body: new Container(
          padding: new EdgeInsets.all(15.0),
          child: new Stack(
            children: <Widget>[
              new Form(
                key: formKey,
                child: new ListView(
                  children: <Widget>[
                    new SizedBox(height: 12.0),
                    new Center(
                      child: new Text('YouTrack Login',
                        style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700)
                      )
                    ),
                    new SizedBox(height: 100.0),
                    usernameInput,
                    new SizedBox(height: 12.0),
                    errorOutputText,
                    new SizedBox(height: 12.0),
                    passwordInput,
                    new SizedBox(height: 12.0),
                    loginButton
                  ],
                ),
              ),
              isLoading ? new Stack(
                children: [
                  new Opacity(
                    opacity: 0.5,
                    child: const ModalBarrier(dismissible: false, color: Colors.white70,),
                  ),
                  new Center(
                    child: new CircularProgressIndicator(),
                  ),
                ],
              ) : new Text('') 
            ],

          )
        ),
      );
    }
}
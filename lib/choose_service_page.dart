import 'package:flutter/material.dart';
import 'utils/network_util.dart';
import 'rest_urls.dart';
import 'login_page.dart';
import 'dart:async';
import 'dart:io' as io;

import 'package:youtrack_timer/models/service_information.dart';
import 'package:youtrack_timer/data/database_helper.dart';

class ChooseServicePage extends StatefulWidget {
  static String tag = 'choose-serevice-page';

  @override
  _ChooseServicePageState createState() => new _ChooseServicePageState();
}

class _ChooseServicePageState extends State<ChooseServicePage> {
  DatabaseHelper _db = new DatabaseHelper();
  bool isLoading = false;
  bool networkError = false;

  @override
    void initState() {
      _db.getServiceInformation().then((ServiceInformation serviceInformation) {
        if (serviceInformation != null) {
          Navigator.of(context).pushNamed(LoginPage.tag);
        }
      });
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = new TextEditingController();
    final formKey = new GlobalKey<FormState>();

    void _saveServiceInformation(ServiceInformation serviceInformation) async {
      await _db.saveServiceInformation(serviceInformation);
    }

    Future<ServiceInformation> _fetchServiceInformation(String serviceUrl) {
      NetworkUtil _networkUtil = new NetworkUtil();

      var response = _networkUtil.get(serviceUrl);
      return response.then((dynamic res) {

        if (res is io.IOException || res is Exception) {
          return null;
        }
        
        ServiceInformation serviceInformation = new ServiceInformation.map({
          'serviceId': res['mobile']['serviceId'],
          'serviceSecret': res['mobile']['serviceSecret'],
          'ringServiceId': res['ring']['serviceId'],
          'serviceHubUrl': res['ring']['url']
        });

        return serviceInformation;
      });
    }

    String _validateServiceUrl(String serviceUrl) {
      serviceUrl = serviceUrl.trim();
      if (serviceUrl.isEmpty) {
        return 'Please enter a YouTrack URL';
      }

      if (!serviceUrl.startsWith(new RegExp(r'(http://|https://)'))) {
        return "The YouTrack URL should start with http(s)://";
      }
    }

    String _checkServiceUrl(String serviceUrl) {
      serviceUrl = serviceUrl.trim();
      if (serviceUrl.trim().endsWith('/')) {
        serviceUrl = serviceUrl.substring(0, serviceUrl.length-1);
      }
      
      return serviceUrl;
    }

    void _handleServiceInformation() async {
      final form = formKey.currentState;
      
      if (form.validate()) {
        setState(() { isLoading = true; networkError = false; });
        var serviceUrl = _checkServiceUrl(_controller.text);

        ServiceInformation serviceInformation = await _fetchServiceInformation(serviceUrl + URL_GET_SERVICE_INFORMATION);
        if (serviceInformation != null) {
          _saveServiceInformation(serviceInformation);
          Navigator.of(context).pushNamed(LoginPage.tag);
        
        } else {
          setState(() {networkError = true;});
        }

        setState(() {isLoading = false;});
      }
    }
    final serviceUrlInput = new TextFormField(
      keyboardType: TextInputType.url,
      autofocus: false,
      validator: (val) => _validateServiceUrl(val),
      controller: _controller,
      decoration: new InputDecoration(
        hintText: 'youtrack.example.com',
        contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(10.0)),
      ),
    );

    var chooseServiceButton = new Padding(
      padding: new EdgeInsets.symmetric(vertical: 16.0),
      child: new Material(
        borderRadius: new BorderRadius.circular(10.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: new MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          color: Colors.lightBlueAccent,
          child: new Text('Next', style: new TextStyle(color: Colors.white),),
          onPressed: _handleServiceInformation,
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
                  new SizedBox(height: 32.0,),
                  new Center(
                    child: new Text('Enter YouTrack Url',
                      style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700)
                    ),
                  ),
                  new SizedBox(height: 100.0,),
                  serviceUrlInput,
                  new SizedBox(height: 12.0,),
                  errorOutputText,
                  new SizedBox(height: 12.0,),
                  chooseServiceButton,
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
        ),        
      ),
    );
  }
}
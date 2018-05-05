import 'dart:async';
import "package:flutter/material.dart";

import 'package:youtrack_timer/models/authentication.dart';
import 'package:youtrack_timer/models/service_information.dart';
import 'package:youtrack_timer/utils/network_util.dart';
import 'package:youtrack_timer/utils/rest_urls.dart';
import 'package:youtrack_timer/data/database_helper.dart';

class ProjectListPage extends StatefulWidget {
   static String tag = 'project-list-page';
   @override
     State<StatefulWidget> createState() => new _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  DatabaseHelper _db = new DatabaseHelper();
  NetworkUtil _networkUtil = new NetworkUtil();
  List projects;
  ServiceInformation serviceInformation;

  Future<ServiceInformation> getServiceInformation() async {
    return await _db.getServiceInformation();
  }

  Future<Authentication> getAuthentication() async {
    return await _db.getAuthentiction();
  }

  @override
    void initState() {
      super.initState();

      getAuthentication().then((Authentication auth){
        Map<String, String> authHeader = {
          'Accept': 'application/json',
          'Authorization' : auth.tokenType + ' ' + auth.accessToken
        };

        getServiceInformation().then((ServiceInformation serviceInformation) {
          _networkUtil.get(
            serviceInformation.serviceUrl + URL_GET_PROJECTS,
            headers: authHeader
          ).then((res) {
            setState(() { projects = res; });
          }).catchError((error){
            // TODO: Error handling for projects request
            print(error);
          });
        });
      });
    }

  @override
    Widget build(BuildContext context) {
      final list = new ListView.builder(
        itemCount: projects == null ? 0 : projects.length,
        itemBuilder: (BuildContext context, int index) {
          return new ListTile(
            title: new Text(projects[index]["name"]),
          );
        }
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
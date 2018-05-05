import 'package:flutter/material.dart';
import "package:youtrack_timer/pages/login_page.dart";
import "package:youtrack_timer/pages/project_list_page.dart";
import "package:youtrack_timer/pages/choose_ticket_page.dart";
import "package:youtrack_timer/pages/choose_service_page.dart";

final routes = <String, WidgetBuilder> {
  ChooseServicePage.tag: (context) => new ChooseServicePage(),
  LoginPage.tag: (context) => new LoginPage(),
  ProjectListPage.tag: (context) => new ProjectListPage(),
  ChooseTicketPage.tag: (context) => new ChooseTicketPage()
};
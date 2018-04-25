import 'package:flutter/material.dart';
import "login_page.dart";
import "project_list_page.dart";
import "choose_ticket_page.dart";
import "choose_service_page.dart";

final routes = <String, WidgetBuilder> {
  ChooseServicePage.tag: (context) => new ChooseServicePage(),
  LoginPage.tag: (context) => new LoginPage(),
  ProjectListPage.tag: (context) => new ProjectListPage(),
  ChooseTicketPage.tag: (context) => new ChooseTicketPage()
};
import 'package:flutter/material.dart';
import "login_page.dart";
import "project_list_page.dart";
import "choose_ticket_page.dart";
import "choose_instance_page.dart";

final routes = <String, WidgetBuilder> {
  ChooseInstancePage.tag: (context) => new ChooseInstancePage(),
  LoginPage.tag: (context) => new LoginPage(),
  ProjectListPage.tag: (context) => new ProjectListPage(),
  ChooseTicketPage.tag: (context) => new ChooseTicketPage()
};
import 'package:flutter/material.dart';
class AdminPageLoader {
  static Widget getPage(String feature) => Scaffold(body: Center(child: Text('Admin: $feature')));
}

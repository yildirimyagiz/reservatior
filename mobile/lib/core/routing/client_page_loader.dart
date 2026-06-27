import 'package:flutter/material.dart';
class ClientPageLoader {
  static Widget getPage(String feature) => Scaffold(body: Center(child: Text('Client: $feature')));
}

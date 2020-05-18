import 'package:coronatracker/pages/home.dart';
import 'package:coronatracker/pages/info.dart';
import 'package:coronatracker/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/info': (context) => Info()
    },
  ));
}

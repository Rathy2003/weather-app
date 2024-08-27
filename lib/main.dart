import 'package:flutter/material.dart';
import 'package:weather_app_by_rathy/screen/home.dart';
import 'package:weather_app_by_rathy/screen/loading.dart';

void main() {
  runApp(
  MaterialApp(
    initialRoute: "/",
    routes: {
      "/":(context) => LoadingPage(),
      "/home":(context) => HomePage(),
    },
  )
  );
}

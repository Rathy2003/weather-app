import 'dart:convert';

import 'package:http/http.dart';

class Worker{
  late double temp;
  late double tempmin;
  late double tempmax;

  String _apikey = "f920efd565b8595db6ad03e15ff99ee7";
  late String name;
  late String status;
  String? lat;
  String? lon;


  Worker({this.lat,this.lon});

  Future<void> getData() async{
    try{
      Response rp = await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${_apikey}"));
      Map weatherData = jsonDecode(rp.body);

      //Assign value to variable
      temp = weatherData["main"]["temp"];
      tempmin = weatherData["main"]["temp_min"];
      tempmax = weatherData["main"]["temp_max"];
      name = weatherData["name"];
      status = weatherData["weather"][0]["main"];

    }catch(e){
      print(e);
    }
  }
}
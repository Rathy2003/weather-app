import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_by_rathy/worker/worker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  //declare variable
  String cityname = "...", temp = "...",status = "...",temp_min = "...",temp_max="...";
  
  Future<Position> _getCurrentPos() async{
      // wk.temp -273.15).ceil()

      //Get Current Location
        bool serviceEnabled;
        LocationPermission permission;

        // Test if location services are enabled.
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          // Location services are not enabled don't continue
          // accessing the position and request users of the
          // App to enable the location services.
          return Future.error('Location services are disabled.');
        }

        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            // Permissions are denied, next time you could try
            // requesting permissions again (this is also where
            // Android's shouldShowRequestPermissionRationale
            // returned true. According to Android guidelines
            // your App should show an explanatory UI now.
            return Future.error('Location permissions are denied');
          }
        }

        if (permission == LocationPermission.deniedForever) {
          // Permissions are denied forever, handle appropriately.
          return Future.error(
              'Location permissions are permanently denied, we cannot request permissions.');
        }

        // When we reach here, permissions are granted and we can
        // continue accessing the position of the device.
        return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentPos().then((value)async{
        Worker wk = Worker(lat: value.latitude.toString(),lon: value.longitude.toString());
        await wk.getData();
        setState((){
            cityname = wk.name;
            temp = (wk.temp - 273.15).ceil().toString();
            temp_min =  (wk.tempmin - 273.15).ceil().toString();
            temp_max =  (wk.tempmax - 273.15).ceil().toString();
            status = wk.status;
      });
    });
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/${status.toLowerCase()=="rain"?'rain-clouds.jpg':'clear-cloud.jpg'}",),
            fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.2),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(cityname,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text("${temp}°",
                    style: TextStyle(
                      fontSize: 135,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text("ស្ថានភាព : ${status.toLowerCase()=="clear"?'ស្រឡះ':'ភ្លៀង'}",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontFamily: "Bayon"
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ទាបបំផុត : ${temp_min}°",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        fontFamily: "Bayon"
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 15,),
                    Text("ខ្ពស់បំផុត : ${temp_max}°",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "Bayon"
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

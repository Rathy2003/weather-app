import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../worker/worker.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  Future<void> startApp() async{
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, "/home");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Image.asset("assets/images/weather_logo.png"),
          ),
          SizedBox(height: 15,),
          Text("អាកាសធាតុ",style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontFamily: "Bayon"
          ),),
          SpinKitThreeBounce(
            color: Colors.white,
            size: 35,
          )
        ],
      ),
    );
  }
}

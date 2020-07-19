import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/Homepage.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashS();
  }
}

class SplashS extends State<SplashScreen>{

  @override
  void initState(){

    super.initState();

        Timer(Duration(seconds: 3),()
        {
          Navigator.push(context , MaterialPageRoute(builder: (context) {
            return Homepage();
          }));
        }
        );

    }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.teal),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                child: Image.asset("images/logo.jpg"),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Security Aider\n   VIT",style: TextStyle(color:Colors.white70,fontWeight: FontWeight.bold,fontSize: 35.0),textAlign: TextAlign.center,),
              ),
              Theme(
                data: Theme.of(context).copyWith(accentColor: Colors.white),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}

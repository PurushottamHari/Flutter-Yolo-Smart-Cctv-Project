import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter_app/SOS.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget
{

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  AudioPlayer advancedPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  var Security = Firestore.instance.collection("Security");
  var Logs = Firestore.instance.collection("logs");
  var flagM = new Map<String,dynamic>();
  var flagB = new Map<String,dynamic>();
  var flagR = new Map<String,dynamic>();
  String displayText = "Safe";
  String image = "images/tick.png";

  _launchURL() async {
    const url = 'http://192.168.43.224';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void showDialogBox(String t) {
    if(t=="Button") {
      showDialog(
          barrierDismissible: false ,
          context: context ,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                  "No Danger!" , textAlign: TextAlign.center) ,

            );
          }
      );
    }
    else if(t=="Report"){
      showDialog(
          barrierDismissible: false ,
          context: context ,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                  "Report Recorded!" , textAlign: TextAlign.center) ,

            );
          }
      );
    }
  }
  checkProblem(DocumentSnapshot x){

    if(x["Problem"]==true)
      {

          displayText = "Danger (A)";
          image = "images/danger.png";
          advancedPlayer.release();
          audioCache.play(
              "Censored_Beep-Mastercard-569981218.mp3" , isNotification: true);
      }

    else
      {

          displayText = "Safe";
          image = "images/tick.png";
          advancedPlayer.stop();

      }

  }

  alertButtonT(DocumentSnapshot x,BuildContext context) {
    if (x["Problem"] == true) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text("Are you sure you want to proceed?" ,
                    textAlign: TextAlign.center) ,
                content: Row(
                  children: <Widget>[
                    Container(
                      margin:EdgeInsets.only(left: 20.0),
                      child: RaisedButton(
                          color: Colors.green ,
                          child: Text("Yes") ,
                          onPressed: () {
                            setDataT(flagM);
                            Security.document(x.documentID).setData(flagM);
                            setDataLT(flagB);
                            Logs.add(flagB);
                            Navigator.of(context , rootNavigator: true).pop();
                          }
                      ),
                    ) ,
                    Container(
                      margin:EdgeInsets.only(left: 50.0),
                      child: RaisedButton(
                        padding: EdgeInsets.only(left: 10.0),
                        color: Colors.amber[100] ,
                        child: Text("No") ,
                        onPressed: () {
                          Navigator.of(context , rootNavigator: true).pop();
                        } ,
                      ),
                    ) ,
                  ] ,
                )
            );
          }
      );

    }
    else {
      showDialogBox("Button");
    }
  }


  alertButtonF(DocumentSnapshot x, BuildContext context){
if(x["Problem"]==true) {

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("Are you sure you want to proceed?" ,
                textAlign: TextAlign.center) ,
            content: Row(
              children: <Widget>[
                Container(
                  margin:EdgeInsets.only(left: 20.0),
                  child: RaisedButton(
                      color: Colors.green ,
                      child: Text("Yes") ,
                      onPressed: () {
                        setDataT(flagM);
                        Security.document(x.documentID).setData(flagM);
                        setDataLF(flagB);
                        Logs.add(flagB);
                        Navigator.of(context , rootNavigator: true).pop();
                      }
                  ),
                ) ,
                Container(
                  margin:EdgeInsets.only(left: 50.0),
                  child: RaisedButton(
                    padding: EdgeInsets.only(left: 10.0),
                    color: Colors.amber[100] ,
                    child: Text("No") ,
                    onPressed: () {
                      Navigator.of(context , rootNavigator: true).pop();
                    } ,
                  ),
                ) ,
              ] ,
            )
        );
      }
  );
}
else
  {
    showDialogBox("Button");
  }
  }

  setReport(Map<String, dynamic> x){
    x["Report"] = "App Failed";

  }


  setDataT(Map<String,dynamic> x){
    x["Problem"] = false;
  }

  setDataLT(Map<String,dynamic> x){
    x["alert"] = true;
  }


  setDataLF(Map<String,dynamic> x){
    x["alert"] = false;
  }

  Widget myWidget(BuildContext context, DocumentSnapshot document){

    checkProblem(document);
    return Container(
      child: Column(
      children: <Widget>[
      Container(
      width: 410.0 ,

      decoration: BoxDecoration(
      color: Colors.yellow[100] ,
      ) ,
      child: Column(
      children: <Widget>[
      Text(displayText , textAlign: TextAlign.center ,
      textScaleFactor: 4.0 ,
      style: TextStyle(
      decoration: TextDecoration.underline,
      color: Colors.black ,

      ) ,) ,
      Image.asset(image , scale: 0.25 ,
      width: 200.0 ,
      height: 200.0 ,) ,
      ] ,
      ) ,
      ) ,
      Container(
        color: Colors.black,
        height: 105.0,
        child: Row(
        children: <Widget>[
        Container(
        margin: EdgeInsets.only(top: 20.0 , left: 40.0) ,
        padding: EdgeInsets.only(bottom:10.0),
        child: ButtonTheme(
        height: 80.0 ,
        minWidth: 150 ,
        buttonColor: Colors.white ,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.green,width: 5.0),
          ),
        child: Text("True Alert" , textScaleFactor: 1.5 ,style: TextStyle(color: Colors.green),) ,
        onPressed: () {
         alertButtonT(document,context);
        } ,
        ) ,
        ) ,
        ) ,
        Container(
        margin: EdgeInsets.only(top: 20.0 , left: 40.0) ,
          padding: EdgeInsets.only(bottom:10.0),
        child: ButtonTheme(
        height: 80.0 ,
        minWidth: 150 ,
        buttonColor: Colors.white ,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.red,width: 5.0)
          ),
        child: Text("False Alert" , textScaleFactor: 1.5,style: TextStyle(color: Colors.red),) ,
        onPressed: () {
            alertButtonF(document,context);
        } ,
        ) ,
        ) ,
        ) ,
        ] ,
        ),
      ) ,
      Row(
      children: <Widget>[
      Container(
      margin: EdgeInsets.only(top: 40.0 , left: 95.0) ,
      child: ButtonTheme(
      height: 95.0 ,
      minWidth: 200 ,
      buttonColor: Colors.orange ,
      child: RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      child: Text("SOS" , textScaleFactor: 1.5) ,
      onPressed: () {
        Navigator.push(
            context , MaterialPageRoute(builder: (context) {
          return SOS();
        }));
      } ,
      ) ,
      ) ,
      ) ,

      ] ,
      ) ,
        Container(
          margin: EdgeInsets.only(top: 40.0 , right: 20.0) ,
          child: ButtonTheme(
            height: 95.0 ,
            minWidth: 200 ,
            buttonColor: Colors.lightBlueAccent ,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              child: Text("Check Video" , textScaleFactor: 1.5) ,
              onPressed: () {
                _launchURL();
              } ,
            ) ,
          ) ,
        ) ,
      Container(
      margin: EdgeInsets.only(top: 60.0 , right: 0.0) ,
      child: ButtonTheme(
      height: 50.0 ,
      minWidth: 380 ,
      buttonColor: Colors.amber[300] ,
      child: RaisedButton(
      shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(18.0),
      ),
      child: Text("Report!" , textScaleFactor: 1.5) ,
      onPressed: () {
            setReport(flagR);
            Logs.add(flagR);
            showDialogBox("Report");
      } ,
      ) ,
      ) ,
      ) ,
      ] ,
      ),
    );

  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return WillPopScope(
      onWillPop: () {

      } ,
      child: Scaffold(
        appBar: AppBar(title: Text("Security Aider") ,
            leading: Icon(Icons.security)) ,
        backgroundColor: Colors.blue[100] ,
        body: StreamBuilder(
            stream: Security.snapshots() ,
            builder: (context , snapshot) {
    if (!snapshot.hasData) return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    AlertDialog(
    title: Text("Loading..",textAlign: TextAlign.center),
    ),
    ],
    );

   return myWidget(context, snapshot.data.documents[0]);

    }
      ) ,
    ),
    );
    }
  }
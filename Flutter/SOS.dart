import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;


class SOS extends StatefulWidget
{

  @override
  _SOSState createState() => _SOSState();
}

class _SOSState extends State<SOS> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    {
      return Scaffold(
        appBar: AppBar(title: Text("Security Aider") ,
            leading: Icon(Icons.security)) ,
        body: ListView(
            children: <Widget>[
              ListTile(leading: Icon(Icons.local_hospital) ,
                  title: Text("Call Hospital") ,
                  onTap: () {
                    UrlLauncher.launch("tel:112");
                  }) ,
              ListTile(leading: Icon(Icons.local_hospital) ,
                  title: Text("Call Police") ,
                  onTap: () {
                    UrlLauncher.launch("tel:100");
                  }) ,
              ListTile(leading: Icon(Icons.local_hospital) ,
                  title: Text("Local Security") ,
                  onTap: () {
                    UrlLauncher.launch("tel:10021");
                  }) ,
            ]
        ) ,
      );
    }
  }
}


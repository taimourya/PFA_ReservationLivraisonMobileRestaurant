

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilState();
  }

}

class _ProfilState extends State<Profil>{


  dynamic data;

  @override
  void initState() {
    super.initState();

    _getProfil();
  }

  void _getProfil() {
    var url = Uri.parse("http://192.168.8.111:8080/user?id=${5}");
    http.get(url)
    .then((response) {
      print(response.body);
      setState(() {
        data = json.decode(response.body);
      });
    })
    .catchError((err) {
      print(err);

    });

  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 35,),
        Text(
            "Your Profil",
            style: Theme.of(context).textTheme.headline4
        ),
        SizedBox(height: 40,),
        Card(
          child: ListTile(
            title: Text('Nom : ' + (data != null?data['name'] : "")),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Adresse : ' +  (data != null?data['adresse'] : "")),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Numéro de telephone : ' + (data != null?data['phone'] : "")),
          ),
        )
      ],
    );
  }
}
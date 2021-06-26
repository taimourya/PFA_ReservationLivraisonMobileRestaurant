

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  String restaurantName = "";
  String restaurantAdresse = "";
  String restaurantPhone = "";

  Profil(this.restaurantName, this.restaurantAdresse, this.restaurantPhone);

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
            title: Text('Nom : ' + this.restaurantName),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Adresse : ' +  this.restaurantAdresse),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Numéro de telephone : ' + this.restaurantPhone),
          ),
        )
      ],
    );
  }
}
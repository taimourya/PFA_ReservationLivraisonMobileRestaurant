


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/widgets/GestionRestaurant.dart';
import 'package:restaurant/widgets/Home.dart';
import 'package:restaurant/widgets/Localisation.dart';
import 'package:restaurant/widgets/Reclamation.dart';
import 'package:restaurant/widgets/Settings.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Restaurant Application'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Gerer mon restaurant'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GestionRestaurant()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text('Réclamation'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Reclamation()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Localisation'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Localisation()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
          ),
        ],
      ),
    );
  }

}
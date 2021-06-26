

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/widgets/DrawerMenu.dart';
import 'package:restaurant/widgets/Historique.dart';
import 'package:restaurant/widgets/Profil.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StatSettings();
  }
}

class StatSettings extends State<Settings> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Settings"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.supervised_user_circle)),
              Tab(icon: Icon(Icons.bar_chart)),
            ],
          ),
        ),
        drawer: DrawerMenu(),
        body: TabBarView(
          children: <Widget>[

            Profil("MCDO", "Maarif boulvard zerktoni", "+212643334135"),

            Historique(),
          ],
        ),
      )
    );
  }


}
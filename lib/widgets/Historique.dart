

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Historique extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HistoriqueStat();
  }
}

class HistoriqueStat extends State<Historique> {


  late int userId;

  @override
  void initState() {
    super.initState();
    getSharedUserId();
  }

  Future<void> getSharedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');

    setState(() {
      userId = id == null? 0 : id;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(userId);
    return Column(
      children: <Widget>[
        SizedBox(height: 35,),
        Text(
          "Historique",
          style: Theme.of(context).textTheme.headline4
        ),
      ],
    );
  }


}
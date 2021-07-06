


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:restaurant/API/Host.dart';

class LivraisonEnCours extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateLivraisonEnCours();
  }

}

class _StateLivraisonEnCours extends State<LivraisonEnCours>{

  dynamic data;

  @override
  void initState() {
    super.initState();
    _initItems();
  }



  _initItems() {
    var url = Uri.parse(
        "${Host.url}/restaurant/reservationEnCours?restaurant_id=${5}"
    );
    http.get(url).then((response) {
      print(response.body);
      setState(() {
        data = json.decode(response.body);
      });
    }).catchError((err) {
      print(err);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
          SizedBox(height: 35,),
          Text(
              "Livraison en cours",
              style: Theme.of(context).textTheme.headline4
          ),
          SizedBox(height: 40,),

          data!=null?(data.length == 0? Text("Aucun element trouver"): Text("")): Text(""),

          Expanded(
            child: ListView.builder(

              itemCount: data!=null? data.length: 0,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Icon(CupertinoIcons.eye),
                    title: Text("le ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(data[index]['dateReservation']))}"),
                    subtitle: Text("reserver par "
                        "${data[index]['client']['firstname']} "
                        "${data[index]['client']['lastname']}"
                    ),
                    onTap: () {

                    },
                  ),
                );
              },
            ),
          )
       ]
    ,);
  }


}
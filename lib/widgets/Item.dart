



import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/API/Host.dart';
import 'package:restaurant/widgets/DrawerMenu.dart';
import 'package:restaurant/widgets/FormItem.dart';
import 'package:http/http.dart' as http;


class Item extends StatefulWidget {

  int itemId;

  Item(this.itemId);

  @override
  State<StatefulWidget> createState() {
    return StatItem();
  }
}

class StatItem extends State<Item> {


  dynamic data;

  @override
  void initState() {
    super.initState();
    _initItem();
  }

  _initItem() {
    var url = Uri.parse(
        "http://${Host.url}:8080/buyable?id=${widget.itemId}"
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Item info"),
        backgroundColor: Colors.green,
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Text(
                "${data != null ? data['name']: '...'}",
                style: Theme.of(context).textTheme.headline4
            ),
            SizedBox(height: 35,),

            data['category'] != null?
              Text(
                  "Categorie : ${data != null ? data['category']['name']: "..."}",
                  style: Theme.of(context).textTheme.headline5
              )
            :
                Text(""),

            SizedBox(height: 35,),
            Text(
                "Prix : ${data != null ? data['price']: "..."} DH",
                style: Theme.of(context).textTheme.headline5
            ),
            SizedBox(height: 35,),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text("Supprimer"),
                    onPressed: () {

                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 20,),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text("Modifier"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FormItem("Food", widget.itemId)),
                      );
                    },
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
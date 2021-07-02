



import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/API/Host.dart';
import 'package:restaurant/widgets/Item.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ItemsList extends StatefulWidget {

  String title = "";

  ItemsList(this.title);

  @override
  State<StatefulWidget> createState() {
    return StatItemList();
  }
}

class StatItemList extends State<ItemsList> {

  String searchText = "";
  final _formKey = GlobalKey<FormState>();

  Duration get loginTime => Duration(milliseconds: 100);
  late int userId;
  dynamic data;

  @override
  void initState() {
    super.initState();
    getSharedUserId();
    Future.delayed(loginTime).then((_) {
      _initItems();
    });

  }

  Future<void> getSharedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');

    setState(() {
      userId = id == null? 0 : id;
    });
  }


  _initItems() {
    var url = Uri.parse(
        "http://${Host.url}:8080/restaurant/buyables?"
        "restaurant_id=$userId"
        "&type=${widget.title}"
        "&mc=${this.searchText}"
    );
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
        SizedBox(height: 10,),
        Form(
          child: Row(
            children: [
              SizedBox(width: 10,),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    hintText: "Rechercher",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'saisisez quelque chose';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    this.setState(() {
                      this.searchText = value;
                      _initItems();
                    });
                  },
                ),
              ),
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {

                  },
              )
            ],
          ),
        ),
        SizedBox(height: 35,),
        Text(
          widget.title,
          style: TextStyle(
              fontSize: 20,
              color: Colors.black54
          ),
        ),
        SizedBox(height: 40,),

        data != null? (data.length == 0? Text("Aucun element trouver"):Text("")):Text(""),
        Expanded(
          child: ListView.builder(

            itemCount: data!=null? data.length: 0,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(CupertinoIcons.eye),
                  title: Text(data[index]['name']),
                  trailing: Text("${data[index]['price']} DH"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Item(data[index]['id'])),
                    );
                  },
                ),
              );
            },
          ),
        )

      ],
    );
  }
}
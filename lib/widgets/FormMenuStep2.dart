

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/API/Host.dart';
import 'package:restaurant/widgets/DrawerMenu.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant/widgets/GestionRestaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormMenuStep2 extends StatefulWidget {

  String nomMenu;
  double prixMenu;
  int idToEdit;


  FormMenuStep2(this.nomMenu, this.prixMenu, this.idToEdit);

  @override
  State<StatefulWidget> createState() {
    return _StateFormMenuStep2();
  }

}

class _StateFormMenuStep2 extends State<FormMenuStep2>{


  String searchText = "";
  List<int> selectedItems = [];
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
            "&type=All"
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


  addMenu() {
    http.post(
      Uri.parse('http://${Host.url}:8080/save/menu'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        'restaurant_id': this.userId,
        "name": widget.nomMenu,
        "price": widget.prixMenu,
        "items": selectedItems
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Step 2"),
        backgroundColor: Colors.green,
      ),
      drawer: DrawerMenu(),
      body: Column(
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
            "Items",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black54
            ),
          ),
          SizedBox(height: 40,),
          Expanded(
            child: ListView.builder(

              itemCount: data!=null?data.length: 0,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Icon(CupertinoIcons.eye),
                    title: Text("${data[index]['name']}", style: TextStyle(
                        color: selectedItems.contains(data[index]['id'])? Colors.red: Colors.black
                      ),
                    ),
                    trailing: Text("${data[index]['price']} DH"),
                    onTap: () {
                      setState(() {
                        if(selectedItems.contains(data[index]['id'])) {
                          selectedItems.remove(data[index]['id']);
                        }
                        else {
                          selectedItems.add(data[index]['id']);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  child: Text("Valider"),
                  onPressed: () {
                    if(widget.nomMenu.length != 0 && widget.prixMenu != 0 && selectedItems.length != 0) {
                      addMenu();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GestionRestaurant()),
                      );
                    }
                    else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Erreur de saisie')));
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


}
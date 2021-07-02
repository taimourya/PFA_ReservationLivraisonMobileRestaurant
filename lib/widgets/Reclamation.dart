

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/widgets/DrawerMenu.dart';
import 'package:http/http.dart' as http;

class Reclamation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StatReclamation();
  }
}

class StatReclamation extends State<Reclamation> {

  String message = "";
  final _formKey = GlobalKey<FormState>();


  addReclamation() {
    http.post(
      Uri.parse('http://192.168.8.111:8080/create/reclamation'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        'user_id': 5,
        'message': this.message,
      }),
    ).then((response) {
      print(response.body);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reclamation"),
        backgroundColor: Colors.green,
      ),
      drawer: DrawerMenu(),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 100,),
            Text(
                "avez vous rencontré des problèmes ?",
                style: Theme.of(context).textTheme.headline6
            ),
            SizedBox(height: 50,),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "decrivez nous votre problème !",
                      prefixIcon: Icon(Icons.mail),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vous devez saisire le message';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    this.setState(() {
                      this.message = value;
                    });
                  },
                ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addReclamation();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Votre message a bien été envoyer')));
                    _formKey.currentState!.reset();
                  }
                },
                child: Text('Envoyer'),
              ),
            ),
          ],
        ),
      )
    );
  }


}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/widgets/DrawerMenu.dart';
import 'package:restaurant/widgets/FormMenuStep2.dart';

class FormMenuStep1 extends StatefulWidget {


  int idToEdit;


  FormMenuStep1(this.idToEdit);

  @override
  State<StatefulWidget> createState() {
    return _StateFormMenuStep1();
  }

}

class _StateFormMenuStep1 extends State<FormMenuStep1> {

  String nom = "";
  double prix = 0.0 ;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Step 1"),
        backgroundColor: Colors.green,
      ),
      drawer: DrawerMenu(),
      body: Form(
        child: Column(
          children: [
            SizedBox(height: 35,),
            Center(
              child: Text(
                  widget.idToEdit == 0? "Ajouter un  menu": "Modification d'un menu",
                  style: Theme.of(context).textTheme.headline4
              ),
            ),
            SizedBox(height: 40,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Nom du menu",
                  prefixIcon: Icon(Icons.dynamic_feed),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ne doit pas etre vide';
                  }
                  return null;
                },
                onChanged: (value) {
                  this.setState(() {
                    this.nom = value;
                  });
                },
              ),
            ),

            SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Prix",
                  prefixIcon: Icon(Icons.money),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ne doit pas etre vide';
                  }
                  return null;
                },
                onChanged: (value) {
                  this.setState(() {
                    this.prix = double.parse(value);
                  });
                },
              ),
            ),

            SizedBox(height: 50,),

            Row(
              children: [
                SizedBox(width: 20,),
                Expanded(
                  child: ElevatedButton(
                    child: Text("Suivant"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FormMenuStep2(nom, prix, widget.idToEdit)),
                      );
                    },
                  ),
                ),
                SizedBox(width: 20,),
              ],
            ),
          ],
        ),
      ),

    );

  }

}
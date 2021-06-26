


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/widgets/DrawerMenu.dart';

class FormItem extends StatefulWidget {

  String typeItem;
  int idToEdit;


  FormItem(this.typeItem, this.idToEdit);


  @override
  State<StatefulWidget> createState() {
    return _StateFormItem();
  }

}

class _StateFormItem extends State<FormItem>{

  String nom = "";
  double prix = 0.0 ;
  String categorie = "cat 1";
  List<String> listCategories = ["cat 1", "cat 2", "cat 3", "cat 4", "cat 5"];

  bool addNewCategorie = false;


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("nom : ${nom}");
    print("prix : ${prix}");
    print("categorie : ${categorie}");
    print("addNewCategorie : ${addNewCategorie}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.green,
      ),
      drawer: DrawerMenu(),
      body: Form(
        child: Column(
          children: [
            SizedBox(height: 35,),
            Center(
              child: Text(
                  widget.idToEdit == 0? "Ajouter un  ${widget.typeItem}": "Modification du ${widget.typeItem}",
                  style: Theme.of(context).textTheme.headline4
              ),
            ),
            SizedBox(height: 40,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Nom de l'item",
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

            SizedBox(height: 25,),
            Row(
                children: [

                  !addNewCategorie? SizedBox(width: 100,) : SizedBox(width: 20,),

                  !addNewCategorie? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, ),
                    child: DropdownButton<String>(
                      value: categorie,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 20,
                      elevation: 16,
                      style: const TextStyle(
                          color: Colors.black87,
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.redAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          categorie = newValue!;
                        });
                      },
                      items: listCategories
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                          .toList(),
                    ),
                  )
                  :
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Categorie",
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
                          this.categorie = value;
                        });
                      },
                    ),
                  ),

                  IconButton(
                    icon: Icon(
                        addNewCategorie?
                            CupertinoIcons.minus
                            :
                            CupertinoIcons.plus
                    ),
                    onPressed: () {
                      this.setState(() {
                        addNewCategorie = !addNewCategorie;
                        categorie = addNewCategorie? "" : listCategories[0];
                      });
                    },
                  ),
                ],
              ),


            SizedBox(height: 50,),

            Row(
              children: [
                SizedBox(width: 20,),
                Expanded(
                  child: ElevatedButton(
                    child: Text("Valider"),
                    onPressed: () {
                      if(widget.idToEdit == 0) {
                        if(addNewCategorie) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Ajout item + category')));
                        }
                        else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Ajout item seule')));
                        }
                      }
                      else {
                        if(addNewCategorie) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('edit item + add category')));
                        }
                        else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('edit item seule')));
                        }
                      }
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
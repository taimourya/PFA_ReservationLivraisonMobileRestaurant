

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/widgets/DrawerMenu.dart';

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

              itemCount: 15,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Icon(CupertinoIcons.eye),
                    title: Text("Item ${index}", style: TextStyle(
                        color: selectedItems.contains(index)? Colors.red: Colors.black
                      ),
                    ),
                    trailing: Text("${"35"} DH"),
                    onTap: () {
                      setState(() {
                        if(selectedItems.contains(index)) {
                          selectedItems.remove(index);
                        }
                        else {
                          selectedItems.add(index);
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
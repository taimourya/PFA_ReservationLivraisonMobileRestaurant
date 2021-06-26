



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/widgets/DrawerMenu.dart';
import 'package:restaurant/widgets/FormItem.dart';


class ChoixTypeItem extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _StatChoixTypeItem();
  }
}

class _StatChoixTypeItem extends State<ChoixTypeItem>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choix Type"),
        backgroundColor: Colors.green,
      ),
      drawer: DrawerMenu(),
      body: Column(
        children: <Widget>[
          SizedBox(height: 35,),
          Text(
              "Choix type item",
              style: Theme.of(context).textTheme.headline4
          ),
          SizedBox(height: 40,),
          Card(
            child: ListTile(
              leading: Icon(Icons.food_bank_outlined),
              title: Text("Food"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormItem("Food", 0)),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.fastfood),
              title: Text("Menu"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormItem("Menu", 0)),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.emoji_food_beverage),
              title: Text("Boisson"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormItem("Boisson", 0)),
                );
              },
            ),
          )
        ],
      )
    );
  }


}


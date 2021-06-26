

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/widgets/ChoixTypeItem.dart';
import 'package:restaurant/widgets/DrawerMenu.dart';
import 'package:restaurant/widgets/ItemsList.dart';

class GestionRestaurant extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateGestionRestaurant();
  }
}

class StateGestionRestaurant extends State<GestionRestaurant> {



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Gerer votre restaurant"),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.food_bank_outlined)),
                Tab(icon: Icon(Icons.fastfood)),
                Tab(icon: Icon(Icons.emoji_food_beverage_rounded)),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(CupertinoIcons.plus),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChoixTypeItem()),
              );
            },
          ),
          drawer: DrawerMenu(),
          body: TabBarView(
            children: <Widget>[
              ItemsList("Food"),
              ItemsList("Menu"),
              ItemsList("Boisson"),
            ],
          ),
        )
    );
  }

  
}
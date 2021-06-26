



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/widgets/DrawerMenu.dart';
import 'package:restaurant/widgets/FormItem.dart';


class Item extends StatefulWidget {

  int itemId;

  Item(this.itemId);

  @override
  State<StatefulWidget> createState() {
    return StatItem();
  }
}

class StatItem extends State<Item> {

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
                "Nom de l'item ID ${widget.itemId}",
                style: Theme.of(context).textTheme.headline4
            ),
            SizedBox(height: 35,),
            Text(
                "Categorie : ${"Food"}",
                style: Theme.of(context).textTheme.headline5
            ),
            SizedBox(height: 35,),
            Text(
                "Prix : ${"35"} DH",
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
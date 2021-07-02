


import 'dart:async';
import 'dart:ffi';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant/widgets/DrawerMenu.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant/widgets/GestionRestaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Localisation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateLocalisation();
  }

}

class _StateLocalisation extends State<Localisation>{

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(33.5761412, -7.5427257);

  late int userId;

  late Marker source = Marker(
      markerId: MarkerId('home'),
      position: LatLng(0, 0),
  );

  @override
  void initState() {
    super.initState();
    getSharedUserId();
  }
  Future<void> getSharedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');

    setState(() {
      userId = id == null? 0 : id;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  _saveLocalisation() {
    var url = Uri.parse(
        "http://192.168.8.111:8080/restaurant/localisation"
            "?restaurant_id=$userId"
            "&latitude=${source.position.latitude}"
            "&longitude=${source.position.longitude}"
    );
    http.get(url).then((response) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GestionRestaurant()),
      );

    }).catchError((err) {
      print(err);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Probleme au niveau du serveur')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Localisez votre restaurant'),
        backgroundColor: Colors.green,
        actions: [
          TextButton(
              child: Text("Envoyer", style: TextStyle(color: Colors.cyan, fontSize: 15),),
              onPressed: () {
                if(source.position.latitude != 0 || source.position.longitude != 0) {
                  _saveLocalisation();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('localisation sauvegarder')));
                }
                else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('vous devez choisir votre localisation')));
                }
              }
          )
        ],
      ),
      drawer: DrawerMenu(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
        onPressed: () {

        },
      ),
      body: GoogleMap(
        markers: {source},
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0
        ),
        onTap: (pos) {
          setState(() {
            source =Marker(
                markerId: MarkerId('home'),
                position: pos,
                icon: BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(title: 'Current Location')
            );
          });
        },
      ),
    );
  }

}
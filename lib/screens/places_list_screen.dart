import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';

import '../screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
          )
        ],
      ),
      body: Consumer<GreatPlaces>(
        builder: (context, placesData, child) => placesData.items.length <= 0
            ? child
            : ListView.builder(
                itemCount: placesData.items.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(placesData.items[index].image),
                  ),
                  title: Text(placesData.items[index].title),
                ),
              ),
        child: Center(child: Text('Got no places yet, start adding some!')),
      ),
    );
  }
}

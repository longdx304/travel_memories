import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';

import '../screens/add_place_screen.dart';

class PlacesListScreen extends StatefulWidget {
  @override
  _PlacesListScreenState createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  Future _placesFuture;
  Future _obtainPlacesFuture() {
    return Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces();
  }

  @override
  void initState() {
    _placesFuture = _obtainPlacesFuture();
    super.initState();
  }

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
      body: FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                builder: (context, placesData, child) =>
                    placesData.items.length <= 0
                        ? child
                        : ListView.builder(
                            itemCount: placesData.items.length,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(placesData.items[index].image),
                              ),
                              title: Text(placesData.items[index].title),
                            ),
                          ),
                child: Center(
                    child: Text('Got no places yet, start adding some!')),
              ),
      ),
    );
  }
}

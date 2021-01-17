import 'dart:io';

import 'package:flutter/material.dart';

import '../helpers/db_helpers.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DbHelper.getData();
    final loadedPlaces = data
        .map((place) => Place(
              id: place['id'],
              title: place['title'],
              location: null,
              image: File(place['image']),
            ))
        .toList();
    _items = loadedPlaces;
  }

  void addPlace({String title, File image}) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: null,
      image: image,
    );

    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert(newPlace);
  }
}

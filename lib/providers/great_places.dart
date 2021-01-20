import 'dart:io';

import 'package:flutter/material.dart';

import '../helpers/location_helpers.dart';
import '../helpers/db_helper.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DbHelper.getData();
    final loadedPlaces = data
        .map((place) => Place(
              id: place['id'],
              title: place['title'],
              location: PlaceLocation(
                latitude: place['loc_lat'],
                longitude: place['loc_lng'],
                address: place['addr'],
              ),
              image: File(place['image']),
            ))
        .toList();
    _items = loadedPlaces;
  }

  Future<void> addPlace(
      {String title, File image, PlaceLocation location}) async {
    final address = await LocationHelpers.getPlaceAddress(
      latitude: location.latitude,
      longitude: location.longitude,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: PlaceLocation(
        latitude: location.latitude,
        longitude: location.longitude,
        address: address,
      ),
      image: image,
    );

    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert(newPlace);
  }
}

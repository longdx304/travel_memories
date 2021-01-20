import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../screens/map_screen.dart';

import '../providers/great_places.dart';

class PlaceDetail extends StatelessWidget {
  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context).settings.arguments;
    final place =
        Provider.of<GreatPlaces>(context, listen: false).findById(placeId);

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            place.location.address,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              final initialPosition = LatLng(
                place.location.latitude,
                place.location.longitude,
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MapScreen(
                    initialPosition: initialPosition,
                    isSelecting: false,
                  ),
                ),
              );
            },
            child: Text('View On Map'),
          ),
        ],
      ),
    );
  }
}

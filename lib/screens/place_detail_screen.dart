import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    );
  }
}

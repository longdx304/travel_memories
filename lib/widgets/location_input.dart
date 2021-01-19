import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../screens/map_screen.dart';

import '../helpers/location_helpers.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectLoc;

  const LocationInput({this.onSelectLoc});

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _showPreview({longitude, latitude}) {
    final staticMapImageUrl = LocationHelpers.generateLocationPreviewImage(
      longitude: longitude,
      latitude: latitude,
    );
    setState(() => _previewImageUrl = staticMapImageUrl);
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MapScreen(),
        fullscreenDialog: true,
      ),
    );
    _showPreview(
      latitude: selectedLocation.latitude,
      longitude: selectedLocation.longitude,
    );
    widget.onSelectLoc(
      longitude: selectedLocation.longitude,
      latitude: selectedLocation.latitude,
    );
  }

  Future<void> _getUserLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locData = await location.getLocation();
    _showPreview(
      latitude: _locData.latitude,
      longitude: _locData.longitude,
    );
    widget.onSelectLoc(
      longitude: _locData.longitude,
      latitude: _locData.latitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: _previewImageUrl != null
              ? Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
            ),
          ],
        ),
      ],
    );
  }
}

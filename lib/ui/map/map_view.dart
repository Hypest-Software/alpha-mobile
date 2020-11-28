import 'package:alpha_mobile/core/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  MapView({Key key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final LatLng defaultPos = LatLng(51.9189, 19.1344);

  GoogleMapController mapController;
  MapType _currentMapType;
  LocationProvider _locationProvider;
  LocationData _currentLocation;

  @override
  void initState() {
    super.initState();
    _currentMapType = MapType.normal;
    _locationProvider = new LocationProvider();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    _currentLocation = await _locationProvider.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        mapType: _currentMapType,
        initialCameraPosition: CameraPosition(
          target: _currentLocation == null 
            ? defaultPos 
            : LatLng(_currentLocation.latitude, _currentLocation.longitude),
          zoom: 6.0,
        ),
      ),
      Container(
        alignment: Alignment.topRight,
        padding: EdgeInsets.all(10),
        child: FloatingActionButton(
          onPressed: _changeMapType,
          child: Icon(Icons.layers),
        ),
      ),
    ]);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // in case initialCameraPosition was set before location was fetched
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
        zoom: 16.0)));
  }

  void _changeMapType() {
    setState(() {
      _currentMapType =
          _currentMapType == MapType.normal ? MapType.hybrid : MapType.normal;
    });
  }
}

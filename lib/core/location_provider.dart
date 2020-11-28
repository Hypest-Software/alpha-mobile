import 'dart:core';

import 'package:location/location.dart';

class LocationProvider {
  Location _location;
  bool _serviceEnabled;
  PermissionStatus _permissionStatus;

  static final LocationProvider _instance = LocationProvider._initialize();
  factory LocationProvider() => _instance;

  Stream<LocationData> getCurrentLocationStream() => _location.onLocationChanged;
  Future<LocationData> getCurrentLocation() => _location.getLocation();

  bool isLocationAllowed() => _serviceEnabled && _isLocationPermissionGranted();

  Future<void> requestLocationAccess() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
  }

  LocationProvider._initialize() {
    _location = new Location();
    requestLocationAccess();
  }

  bool _isLocationPermissionGranted() =>
      _permissionStatus == PermissionStatus.granted ||
      _permissionStatus == PermissionStatus.grantedLimited;
}

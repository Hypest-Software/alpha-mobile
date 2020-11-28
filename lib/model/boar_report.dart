import 'dart:io';

import 'package:alpha_mobile/model/boar_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BoarReport {
  BoarType boarType;
  LatLng coordinates;
  String description;
  DateTime timestamp;
  File imageFile;
}

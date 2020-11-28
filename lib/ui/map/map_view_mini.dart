import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewMini extends StatefulWidget {
  final LatLng desiredLocation;
  MapViewMini({Key key, @required this.desiredLocation}) : super(key: key);

  @override
  _MapViewMiniState createState() => _MapViewMiniState();
}

class _MapViewMiniState extends State<MapViewMini> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: widget.desiredLocation,
        zoom: 15.0,
      ),
      markers: Set<Marker>.of([
        Marker(
          markerId: MarkerId('currLoc'),
          position: widget.desiredLocation
        )
      ]),
    );
  }
}

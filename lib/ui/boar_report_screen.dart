import 'package:alpha_mobile/core/location_provider.dart';
import 'package:alpha_mobile/model/boar_report.dart';
import 'package:alpha_mobile/model/boar_type.dart';
import 'package:alpha_mobile/ui/map/map_view_mini.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BoarReportScreen extends StatefulWidget {
  final BoarType chosenBoarType;
  BoarReportScreen({Key key, @required this.chosenBoarType}) : super(key: key);

  @override
  _BoarReportScreenState createState() => _BoarReportScreenState();
}

class _BoarReportScreenState extends State<BoarReportScreen> {
  final _formKey = GlobalKey<FormState>();
  BoarReport _report;
  LocationProvider _locationProvider;
  LatLng _currentLocation;

  @override
  void initState() {
    super.initState();
    _locationProvider = LocationProvider();
    _report = BoarReport();
    _report.boarType = widget.chosenBoarType;
    _getLocation();
  }

  void _getLocation() async {
    var locationData = await _locationProvider.getCurrentLocation();
    setState(() {
      _currentLocation = LatLng(locationData.latitude, locationData.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Report details'),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _locationSection(),
                      _boarTypeSection(),
                    ],
                  ),
                ),
              )
            ]),
          )
        ],
      )),
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Container(
      child: Text(title, style: Theme.of(context).textTheme.headline5),
    );
  }

  Widget _sectionCard(List<Widget> children, {bool horizontal = false}) {
    return Card(
        child: Container(
            padding: EdgeInsets.all(15),
            child: horizontal
                ? Row(children: children, mainAxisAlignment: MainAxisAlignment.spaceBetween)
                : Column(children: children)));
  }

  Widget _locationSection() {
    return _sectionCard([
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _sectionHeader(context, 'Location'),
          RaisedButton(
            child: Text('refresh'),
            onPressed: () => _getLocation(),
          )
        ],
      ),
      Container(height: 10),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
            height: 200,
            width: double.infinity,
            child: _currentLocation != null
                ? MapViewMini(desiredLocation: _currentLocation)
                : Container()),
      ),
      Container(height: 15),
      _currentLocation != null
          ? Text(
              'Coordinates: ${_currentLocation.latitude}, ${_currentLocation.longitude}')
          : Container()
    ]);
  }

  Widget _boarTypeSection() {
    return _sectionCard([
      _sectionHeader(context, 'Boar type'),
      Container(
        width: 120,
        child: DropdownButton(
          isExpanded: true,
          value: _report.boarType,
          onChanged: (value) {
            setState(() => _report.boarType = value);
          },
          items: BoarType.values
              .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.toString().replaceAll('BoarType.', ''))))
              .toList(),
        ),
      )
    ], horizontal: true);
  }
}

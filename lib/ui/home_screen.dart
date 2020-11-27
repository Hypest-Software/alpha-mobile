import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'map/map_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MapView(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {},
        tooltip: 'Report',
        label: Text('Report'),
        icon: Icon(Icons.report),
        backgroundColor: Colors.red,
      ),
    );
  }
}

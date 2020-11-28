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
      floatingActionButton: FractionallySizedBox(
        widthFactor: 0.8,
        heightFactor: 0.1,
        child: FloatingActionButton.extended(
          onPressed: () => {},
          tooltip: 'Report',
          label: Text('REPORT', 
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
          ),
          icon: Icon(Icons.report, size: 40),
          backgroundColor: Colors.red,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

import 'package:alpha_mobile/model/boar_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BoarReportScreen extends StatefulWidget {
  final BoarType boarType;
  BoarReportScreen({Key key, @required this.boarType}) : super(key: key);

  @override
  _BoarReportScreenState createState() => _BoarReportScreenState();
}

class _BoarReportScreenState extends State<BoarReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report sighting'),
      ),
      body: Container(
        child: Text('report screen'),
      ),
    );
  }
}

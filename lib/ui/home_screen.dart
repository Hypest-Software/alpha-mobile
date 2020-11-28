import 'package:alpha_mobile/ui/basic_modal_sheet.dart';
import 'package:alpha_mobile/ui/report_sheet_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
          onPressed: () => showMaterialModalBottomSheet(
              expand: false,
              context: context,
              builder: (context) => _reportBottomSheet(context)),
          tooltip: 'Report',
          label: Text(
            'REPORT',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
          ),
          icon: Icon(Icons.report_outlined, size: 40),
          backgroundColor: Colors.red,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _reportBottomSheet(BuildContext context) {
    return BasicModalSheet(
        header: Column(
          children: [
            Icon(Icons.pets, size: 48),
            Container(height: 10),
            Text('The boar being reported is:', style: TextStyle(fontSize: 20)),
            Container(height: 10),
          ],
        ),
        content: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ReportSheetButton(
                  icon: Icons.check, title: 'Alive', onTap: () => {}),
              ReportSheetButton(
                  icon: Icons.close, title: 'Dead', onTap: () => {})
            ],
          )
    );
  }
}

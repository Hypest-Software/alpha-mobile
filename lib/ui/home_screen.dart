import 'package:alpha_mobile/model/boar_type.dart';
import 'package:alpha_mobile/ui/basic_modal_sheet.dart';
import 'package:alpha_mobile/ui/boar_report_screen.dart';
import 'package:alpha_mobile/ui/modal_sheet_header.dart';
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
        child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent],
            ).createShader(Rect.fromLTRB(0, rect.height * 0.8, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: MapView()
        ),
      ),
      floatingActionButton: FractionallySizedBox(
        widthFactor: 0.8,
        heightFactor: 0.1,
        child: FloatingActionButton.extended(
          onPressed: () => _handleReportClick(context),
          tooltip: 'Report',
          label: Text(
            'REPORT',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
          icon: Icon(Icons.report_outlined, size: 36),
          backgroundColor: Colors.red,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _handleReportClick(BuildContext context) async {
    await showMaterialModalBottomSheet(
            expand: false,
            context: context,
            builder: (context) => _reportBottomSheet(context))
        .then((boarType) async {
      if (boarType == null) {
        return;
      } else if (boarType == BoarType.Alive) {
        bool result = await showMaterialModalBottomSheet(
          context: context,
          builder: (context) => _aliveWarningBottomSheet(context),
          enableDrag: false,
        );

        if (result == null) return;
      }

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BoarReportScreen(boarType: boarType)));
    });
  }

  Widget _reportBottomSheet(BuildContext context) {
    return BasicModalSheet(
      header: ModalSheetHeader(
        icon: Icons.pets,
        text: 'The boar being reported is:',
      ),
      content: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ReportSheetButton(
            icon: Icons.check,
            title: 'Alive',
            onTap: () => Navigator.pop(context, BoarType.Alive),
          ),
          ReportSheetButton(
            icon: Icons.close,
            title: 'Dead',
            onTap: () => Navigator.pop(context, BoarType.Dead),
          ),
        ],
      ),
    );
  }

  Widget _aliveWarningBottomSheet(BuildContext context) {
    return BasicModalSheet(
        header:
            ModalSheetHeader(icon: Icons.warning_rounded, text: 'Stay calm.'),
        content: Column(
          children: [
            Text(
              'Wild boars don\'t attack unless frightened.\nIf you\'re still close to it, calmly and silently withdraw.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            Container(height: 15),
            Text('Make sure you\'re safe before proceeding.',
                style: TextStyle(fontSize: 16)),
            Container(height: 45),
            RaisedButton(
              padding: EdgeInsets.all(20),
              child: Text('I am safe, proceed'.toUpperCase(), style: TextStyle(fontSize: 16),),
              onPressed: () => Navigator.of(context).pop(true),
            )
          ],
        ));
  }
}

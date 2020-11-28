import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReportSheetButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const ReportSheetButton(
      {Key key,
      @required this.icon,
      @required this.title,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(150, 150),
      child: Container(
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFF191919),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, color: Colors.white, size: 48),
                Container(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

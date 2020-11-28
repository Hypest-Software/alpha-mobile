import 'package:flutter/widgets.dart';

class ModalSheetHeader extends StatelessWidget {
  final IconData icon;
  final String text;
  const ModalSheetHeader({Key key, @required this.icon, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 48),
        Container(height: 10),
        Text(text, style: TextStyle(fontSize: 20)),
        Container(height: 10),
      ],
    );
  }
}

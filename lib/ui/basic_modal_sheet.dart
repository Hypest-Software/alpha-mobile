import 'package:flutter/widgets.dart';

class BasicModalSheet extends StatelessWidget {
  final Widget header;
  final Widget content;
  const BasicModalSheet({Key key, @required this.header, @required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 30,
        bottom: 20
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              bottom: 20
            ),
            child: header
          ),
          content
        ],
      ),
    );
  }
}
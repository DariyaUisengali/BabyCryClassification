import 'package:flutter/material.dart';
import 'account_upper.dart';
import 'account_lower.dart';

class SplitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: AccountUpper(),
        ),
        Expanded(
          child: AccountLower(),
        ),
      ],
    );
  }
}



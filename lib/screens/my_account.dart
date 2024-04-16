import 'package:flutter/material.dart';
import 'account_upper.dart';
import 'account_lower.dart';
import 'package:record_with_play/bottom_menu.dart';

class SplitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: AccountUpper(),
          ),
          Expanded(
            child: AccountLower(),
          ),
        ],
      ),
      bottomNavigationBar: BottomMenu(activePage: 'account'),
    );
  }
}

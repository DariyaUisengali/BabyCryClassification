import 'package:flutter/material.dart';
import 'package:record_with_play/bottom_menu.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      bottomNavigationBar:
          BottomMenu(activePage: 'account'), // Add the BottomMenu
      body: Center(
        child: Text('This is the Account page.'),
      ),
    );
  }
}

import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'record_and_play_audio.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountUpper extends StatefulWidget {
  @override
  State<AccountUpper> createState() => _AccountUpperState();
}

class _AccountUpperState extends State<AccountUpper> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  /*
  void _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()), // Assuming you have a LoginScreen to navigate to after logout
    );
  }
  */
  String _getDisplayName() {
    if (_auth.currentUser != null) {
      // If there is a current user and displayName is not null return the displayName, otherwise return "Guest".
      return _auth.currentUser!.displayName ?? "Guest";
    } else {
      // If there is no current user return "Guest".
      return "Guest";
    }
  }

  @override
  Widget build(BuildContext context) {
    String displayName = _getDisplayName();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'My account',
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF494E64),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(
              73, 78, 100, 1.0), // Set background color of the body container
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 80, // Increased size of the avatar
                backgroundImage: NetworkImage(
                    'https://w7.pngwing.com/pngs/811/219/png-transparent-dog-cartoon-cuteness-kitten-avatar-mammal-face-heroes.png'),
              ),
              SizedBox(height: 20),
              Text(
                displayName, // Use the _getDisplayName function to determine the name to display
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              /*
              SizedBox(height: 20),
              // Logout button
              ElevatedButton(
                child: Text('Logout'),
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(50, 52, 62, 1.0), // Set the button color to red
                  onPrimary: Colors.white, // Set the text color to white
                ),


              ),

               */
            ],
          ),
        ),
      ),
    );
  }
}

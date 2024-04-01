import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AccountUpper extends StatefulWidget {
  @override
  State<AccountUpper> createState() => _AccountUpperState();
}

class _AccountUpperState extends State<AccountUpper> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(
            73, 78, 100, 1.0), // Set background color of the app bar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Baby's World",
          style: TextStyle(
            color: Colors.white, // Set text color to white for visibility
          ),
        ),
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
                _auth.currentUser!.displayName.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color set to white for visibility
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

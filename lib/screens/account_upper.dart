import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

class AccountUpper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(73, 78, 100, 1.0), // Set background color of the app bar
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
          color: Color.fromRGBO(73, 78, 100, 1.0), // Set background color of the body container
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 80, // Increased size of the avatar
                backgroundImage: NetworkImage('https://w7.pngwing.com/pngs/811/219/png-transparent-dog-cartoon-cuteness-kitten-avatar-mammal-face-heroes.png'),
              ),
              SizedBox(height: 20),
              Text(
                'Dimash Sagatbekov',
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


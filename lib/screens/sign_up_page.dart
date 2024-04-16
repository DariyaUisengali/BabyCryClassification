import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:record_with_play/screens/record_and_play_audio.dart';
import 'package:record_with_play/screens/sign_in_page.dart';
import 'package:record_with_play/services/toast_services.dart';

import '../authentication/firebase_auth_services.dart';
import '../authentication/form_container_widget.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF32343E),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100), // Adjust vertical spacing as needed
              Image.asset(
                'lib/assets/welcome_screen/BabysWorld.png',
                width: 180.97,
                height: 41.89,
              ),
              SizedBox(height: 30), // Adjust vertical spacing as needed
              FormContainerWidget(
                controller: _usernameController,
                hintText: "Name",
                isPasswordField: false,
              ),
              SizedBox(height: 20), // Adjust vertical spacing as needed
              FormContainerWidget(

                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              SizedBox(height: 20), // Adjust vertical spacing as needed
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              SizedBox(height: 30), // Adjust vertical spacing as needed
              _buildSignUpButton(context),
              SizedBox(height: 20), // Adjust vertical spacing as needed
              Divider(
                color: Colors.white,
                thickness: 1,
              ),

              SizedBox(height: 20), // Adjust vertical spacing as needed
              Text(
                'Already have an account?',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 5), // Adjust vertical spacing as needed
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
                child: Text(
                  'Log in',
                  style: TextStyle(color: Color(0xFF98FB98)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String hintText) {
    return Container(
      width: 300,
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF98FB98)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 55,
      child: ElevatedButton(
        onPressed: _signUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF98FB98),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: Color(0xFF32343E),
            fontSize: 20,
          ),
        ),
      ),
    );
  }
  void _signUp() async{
    String username = _usernameController.text;
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if(user != null){
      final firestore = FirebaseFirestore.instance;
      await firestore.collection("users").doc(user.uid).set(
        {
          "username": username,
          "email": email,
        }
      );
      user.updateDisplayName(username);
      showToast("User is succsessfully created");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => RecordAndPlayScreen()),
              (route) => false);
    }else{
      showToast("Error");
    }
  }
}

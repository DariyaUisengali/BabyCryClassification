import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:record_with_play/screens/record_and_play_audio.dart';
import 'package:record_with_play/screens/sign_up_page.dart';
import 'package:record_with_play/screens/welcome_screen.dart';

import '../authentication/firebase_auth_services.dart';
import '../authentication/form_container_widget.dart';
import '../services/toast_services.dart'; // Import the WelcomeScreen

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
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
              _buildSignInButton(context),
              SizedBox(height: 20), // Adjust vertical spacing as needed
              Divider(
                color: Colors.white,
                thickness: 1,
              ),
              SizedBox(height: 20), // Adjust vertical spacing as needed
              SizedBox(
                width: 300,
                height: 55,
                child: ElevatedButton(
                  onPressed: _signinWithGoogle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF98FB98),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.google,color: Color(0xFF32343E)),
                      SizedBox(width: 10,),
                      Text(
                        'Sign in with Google',
                        style: TextStyle(
                          color: Color(0xFF32343E),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20), // Adjust vertical spacing as needed
              Text(
                'Don\'t have an account?',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 5), // Adjust vertical spacing as needed
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Color(0xFF98FB98)),
                ),
              ),





            ],
          ),
        ),
      ),
    );
  }

  /*Widget _buildInputField(String hintText) {
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
  }*/

  Widget _buildSignInButton(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 55,
      child: ElevatedButton(
        onPressed: _signIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF98FB98),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: Text(
          'Log in',
          style: TextStyle(
            color: Color(0xFF32343E),
            fontSize: 20,
          ),
        ),
      ),
    );
  }
  void _signIn() async{

    String email = _emailController.text.trim();
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if(user != null){
      showToast("Signed In");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => RecordAndPlayScreen()),
              (route) => false);
    }else{
      showToast("Error");
    }
  }

  _signinWithGoogle() async{
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try{
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if(googleSignInAccount != null){
        final GoogleSignInAuthentication googleSignInAuthentication = await
            googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);

        showToast("Signed In");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => RecordAndPlayScreen()),
                (route) => false);
      }
    }catch(e) {
      showToast("Some error occurred: $e");
    }
  }
}

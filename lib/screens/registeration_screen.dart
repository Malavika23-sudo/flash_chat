import 'package:flash_chat/components/button.dart';
import 'package:flash_chat/components/textfileld.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = '/reg_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
              SizedBox(
                height: 48.0,
              ),
              CustomTextField(
                hintText: 'Enter your email',
                onChnaged: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              CustomTextField(
                hintText: 'Enter your password',
                onChnaged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              CustomButton(
                  title: 'Register',
                  onPressed: () async {
                    if (email != null && password != null) {
                      final user = await _auth.createUserWithEmailAndPassword(
                          email: email.toString(),
                          password: password.toString());
                      print(
                          'User at registration screen =========================> $user');
                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

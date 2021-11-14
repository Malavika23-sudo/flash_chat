import 'package:flash_chat/components/button.dart';
import 'package:flash_chat/components/textfileld.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const id = '/login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'a',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
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
              title: 'Login',
              onPressed: () async {
                if (email != null && password != null) {
                  final newuser = await _auth.signInWithEmailAndPassword(
                      email: email.toString(), password: password.toString());
                  print(
                      'NewUser at loginScreen===========================$newuser====================================');
                  if (newuser != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  } else {
                    Text('Unable to login');
                  }
                } else {
                  Text('Unable to login, Fill the fields correctly.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

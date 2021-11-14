import 'package:flash_chat/components/strambuilder.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const id = '/chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _firebasecore = FirebaseFirestore.instance;
  final textEditingController = TextEditingController();
  String? text;
  User? loggedinuser;
  var currentuser;
  @override
  void initState() {
    getCurrentUSer();
  }

  void getCurrentUSer() async {
    try {
      final loggedinuser = await _auth.currentUser;
      if (loggedinuser != null) {
        setState(() {
          currentuser = loggedinuser.email;
        });
      }
    } catch (e) {
      throw 'No user,Unknown error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: Text(
            '⚡️Chat',
            style: TextStyle(fontSize: 16),
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              }),
        ],
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilderWidget(currentuser: currentuser),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      onChanged: (value) {
                        text = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      textEditingController.clear();
                      _firebasecore
                          .collection('message')
                          .add({'sender': currentuser, 'text': text, 'timestamp':FieldValue.serverTimestamp()});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  MessageBubble({required this.text, required this.sender, this.currentuser});

  final text;
  final sender;
  var currentuser;
  @override
  Widget build(BuildContext context) {
    print('Sender:==> $sender currentUser:=> $currentuser');
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: currentuser == sender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text('$sender',
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.white54,
              )),
          Material(
            elevation: 5.0,
            color: currentuser == sender ? Colors.blue : Colors.white,
            borderRadius: currentuser == sender
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 17.0,
                    color: currentuser == sender ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

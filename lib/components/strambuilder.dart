import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/messagebubble.dart';
import 'package:flutter/material.dart';

class StreamBuilderWidget extends StatelessWidget {
  final _firebasecore = FirebaseFirestore.instance;
  var currentuser;
  StreamBuilderWidget({this.currentuser});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebasecore
          .collection('message')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        final messages = snapshot.data!.docs;
        if (!snapshot.hasData) {
          return Container();
        }
        List<MessageBubble> messageboxes = [];
        for (var message in messages) {
          final sender = message['sender'];
          final text = message.get('text');
          print('Sender=================================== $sender');
          print('CurrentUser=================================== $currentuser');
          print('Text=================================== $text');
          final messageWidget = MessageBubble(
            text: text,
            sender: sender,
            currentuser: currentuser,
          );
          messageboxes.add(messageWidget);
        }
        return Expanded(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(reverse: true, children: messageboxes),
        ));
      },
    );
  }
}

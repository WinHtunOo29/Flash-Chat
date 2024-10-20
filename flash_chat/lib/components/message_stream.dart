import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/message_bubble.dart';
import 'package:flutter/material.dart';

class MessageStream extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;

  MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('messages').snapshots(), 
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        } else {
          final messages = snapshot.data?.docs;
          List<MessageBubble> messageBubbles = [];
          if (messages != null) {
            for (var message in messages) {
              final messageText = message['text'];
              final messageSender = message['sender'];
              if (messageText != null) {
                final messageBubble = MessageBubble(messageText: messageText, messageSender: messageSender);
                messageBubbles.add(messageBubble);
              }
            }
          }

          return Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              children: messageBubbles,
            ),
          );
        }
      }
    );
  }
}
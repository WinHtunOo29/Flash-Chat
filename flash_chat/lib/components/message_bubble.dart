import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String messageText;
  final String messageSender;

  const MessageBubble({super.key, required this.messageText, required this.messageSender});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlueAccent,
      child: Text(
        '$messageText from $messageSender'
      )
    );
  }
}
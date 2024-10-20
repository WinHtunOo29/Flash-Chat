import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String messageText;
  final String messageSender;
  final bool isCurrentUser;

  const MessageBubble({super.key, required this.messageText, required this.messageSender, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            messageSender,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12.0,
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              topRight: isCurrentUser ? const Radius.circular(0.0) : const Radius.circular(30.0),
              topLeft: isCurrentUser ? const  Radius.circular(30.0) : const Radius.circular(0.0), 
              bottomLeft: const Radius.circular(30.0),
              bottomRight: const Radius.circular(30.0)  
            ),
            elevation: 5.0,
            color: isCurrentUser ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                messageText,
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}
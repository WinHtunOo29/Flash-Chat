import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/message_bubble.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const String id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User? user;
  String? messageText;
  bool isSendBtnDisabled = true;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        this.user = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void sendMessage() {
    _firestore.collection('messages').add({
      'text': messageText,
      'sender': user?.email,
    });
  }

  void getMessages() async {
    final messages = await _firestore.collection('messages').get();
    for (var message in messages.docs) {
      print(message.data());
    }
  }

  void streamMessages() async {
    await for(var snapshot in _firestore.collection('messages').snapshots()) {
      for(var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  void handleSignOut() {
    _auth.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
              onPressed: () {
                // handleSignOut();
                streamMessages();
              },
              icon: const Icon(Icons.close)
          ),
        ],
        title: const Text(
            'Chat'
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder(
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
                  List<Widget> messageWidgets = [];
                  for (var message in messages!) {
                    final messageText = message['text'];
                    final messageSender = message['sender'];
                    final messageBubble = MessageBubble(messageText: messageText, messageSender: messageSender);
                    messageWidgets.add(messageBubble);
                  }
                  return Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      children: messageWidgets,
                    ),
                  );
                }
              }
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                        setState(() {
                          if (messageText!.isEmpty) {
                          isSendBtnDisabled = true;
                        } else {
                          isSendBtnDisabled = false;
                        }
                        });     
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      isSendBtnDisabled? null : sendMessage();
                    },
                    child: Text(
                      'Send',
                      style: isSendBtnDisabled ? kSendButtonDisabledTextStyle : kSendButtonTextStyle,
                    )
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
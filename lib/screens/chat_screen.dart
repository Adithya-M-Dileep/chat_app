import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../chats/messages.dart';
import '../chats/new_message.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = "/chat-room";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    //CollectionReference collectionRef = FirebaseFirestore.instance.collection(".chats/Yd7MBgjaotBAwikF1eRZ/messages");
    return Scaffold(
      appBar: AppBar(
        title: Text("FutterChat"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          DropdownButton(
              underline: Container(),
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text("Logout")
                      ],
                    ),
                  ),
                  value: "logout",
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == "logout") {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}

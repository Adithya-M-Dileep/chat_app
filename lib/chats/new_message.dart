import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String newMessage = "";
  final _controller = new TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    final userId = await FirebaseAuth.instance.currentUser.uid;
    final user =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    FirebaseFirestore.instance
        .collection("/chats/A9KDWshmhxc3FDzFWeh2/messages")
        .add(
      {
        "text": newMessage,
        "createdAt": Timestamp.now(),
        "userId": userId,
        "username": user["username"],
        "userImage": user["imageUrl"],
      },
    );
    setState(() {
      _controller.clear();
      newMessage = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Send a message"),
              onChanged: (value) {
                setState(() {
                  newMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: newMessage.trim().isEmpty ? null : sendMessage,
            icon: Icon(
              Icons.send,
              color: newMessage.trim().isEmpty
                  ? Colors.grey
                  : Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

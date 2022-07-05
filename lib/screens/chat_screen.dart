import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = "/chat-room";

  @override
  Widget build(BuildContext context) {
    //CollectionReference collectionRef = FirebaseFirestore.instance.collection(".chats/Yd7MBgjaotBAwikF1eRZ/messages");
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("/chats/A9KDWshmhxc3FDzFWeh2/messages")
            .snapshots(),
        builder: (
          ctx,
          AsyncSnapshot<QuerySnapshot> streamSnapshot,
        ) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = streamSnapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (c, i) => Container(
              child: Text(documents[i]["text"]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection("/chats/A9KDWshmhxc3FDzFWeh2/messages")
              .add(
            {
              "text": "Addded my button click",
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: FirebaseAuth.instance.currentUser.,
    //     builder: (ctx,futureSnapshot) {
    //       if (futureSnapshot.connectionState == ConnectionState.waiting) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("/chats/A9KDWshmhxc3FDzFWeh2/messages")
          .orderBy(
            "createdAt",
            descending: true,
          )
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

        final documents = streamSnapshot.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: documents.length,
          itemBuilder: (c, i) => Container(
            child: MessageBubble(
              documents[i]["text"],
              documents[i]["username"],
              documents[i]["userId"] == FirebaseAuth.instance.currentUser.uid,
            ),
          ),
        );
      },
    );
    // });
  }
}

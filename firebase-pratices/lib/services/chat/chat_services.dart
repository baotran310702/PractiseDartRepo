import 'package:advancedlessons/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatServices extends ChangeNotifier {
  //get instance of auth and firebase

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String messageSending) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        timestamp: timestamp,
        message: messageSending);

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("-");

    await _firestore
        .collection('chat-rooms')
        .doc(chatRoomId)
        .collection('message')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userId, otherUserId) {
    //construct chatroom id from ids (sorted to ensure it matches the id used when sending)
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("-");

    return _firestore
        .collection('chat-rooms')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}

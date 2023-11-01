import 'package:advancedlessons/components/chat_box.dart';
import 'package:advancedlessons/components/my_text_fields.dart';
import 'package:advancedlessons/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String userEmail;
  final String receiverUserId;
  const ChatPage(
      {super.key, required this.userEmail, required this.receiverUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatServices _chatServices = ChatServices();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    //message must be not empty to be send, if empty can't send.
    if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(
          widget.receiverUserId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            Text(widget.userEmail),
          ],
        ),
      ),
      body: Column(children: [
        //message
        Expanded(child: _buildMessageList()),
        _buildMessageInput(),
      ]),
    );
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatServices.getMessage(
            widget.receiverUserId, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading message...");
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  //buid message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alighment = data['senderId'] == _firebaseAuth.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft;
    var alighmentMessage = data['senderId'] == _firebaseAuth.currentUser!.uid
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    final dateTime = DateTime.fromMillisecondsSinceEpoch(
        data['timestamp'].seconds * 1000 +
            data['timestamp'].nanoseconds ~/ 1000000);

    final formattedDateTime = dateTime.toLocal().toString();

    return Container(
      alignment: alighment,
      child: Column(
        crossAxisAlignment: alighmentMessage,
        children: [
          Text(
            formattedDateTime,
            style: const TextStyle(fontSize: 10),
          ),
          ChatBox(
            content: data['message'],
          ),
        ],
      ),
    );
  }

  //build message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: MyTextFields(
            controller: _messageController,
            hintText: "Send message here",
            obscureText: false,
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.arrow_upward,
            size: 36,
          ),
        ),
      ],
    );
  }
}

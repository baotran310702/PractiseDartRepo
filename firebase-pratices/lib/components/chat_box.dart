import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget {
  final String content;
  const ChatBox({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        child: Text(
          content,
          overflow: TextOverflow.clip,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}

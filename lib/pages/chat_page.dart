import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Column(
          children: [
            CircleAvatar(
              maxRadius: 14,
              child: Text(
                'Fr',
                style: TextStyle(fontSize: 12, color: Colors.indigoAccent),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Franco Roldán',
              style: TextStyle(color: Colors.black87, fontSize: 12),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Flexible(
              child: ListView.builder(
                  reverse: true, itemBuilder: (_, i) => Text(i.toString()))),
          const Divider(
            height: 1,
          ),
          Container(
            color: Colors.white,
            height: 100,
          )
        ],
      ),
    );
  }
}

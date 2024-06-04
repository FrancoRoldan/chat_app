import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _mensajeController = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool _estaEscribiendo = false;
  final List<ChatMessage> _messagges = [];

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
                  itemCount: _messagges.length,
                  reverse: true,
                  itemBuilder: (_, i) => _messagges[i])),
          const Divider(
            height: 1,
          ),
          Container(
            color: Colors.white,
            child: _inputChat(),
          )
        ],
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
                child: TextField(
              controller: _mensajeController,
              onSubmitted: _handleSumbit,
              onChanged: (String text) {
                setState(() {
                  if (text.trim().isNotEmpty) {
                    _estaEscribiendo = true;
                  } else {
                    _estaEscribiendo = false;
                  }
                });
              },
              decoration:
                  const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
              focusNode: _focus,
            )),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: defaultTargetPlatform == TargetPlatform.iOS
                    ? CupertinoButton(
                        onPressed: _estaEscribiendo
                            ? () => _handleSumbit(_mensajeController.text)
                            : null,
                        child: const Text('Enviar'))
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: IconButton(
                          color: Colors.indigo,
                          onPressed: _estaEscribiendo
                              ? () => _handleSumbit(_mensajeController.text)
                              : null,
                          icon: const Icon(Icons.send),
                        ),
                      ))
          ],
        ),
      ),
    );
  }

  _handleSumbit(String text) {
    _focus.requestFocus();
    text = text.trim();
    if (text.trim().isEmpty) return;

    _mensajeController.clear();

    final message = ChatMessage(
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
      uid: '123',
      text: text,
    );

    _messagges.insert(0, message);

    message.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }
}

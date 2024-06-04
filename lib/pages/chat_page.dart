import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _mensajeController = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool _estaEscribiendo = false;

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
    print(text);
    _mensajeController.clear();
    _focus.requestFocus();
    setState(() {
      _estaEscribiendo = false;
    });
  }
}

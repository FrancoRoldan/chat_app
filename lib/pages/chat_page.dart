import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void dispose() {
    _mensajeController.dispose();
    _focus.dispose();
    for (ChatMessage message in _messagges) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              maxRadius: 14,
              child: Text(
                chatService.usuarioPara.nombre.substring(0, 2),
                style:
                    const TextStyle(fontSize: 12, color: Colors.indigoAccent),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              chatService.usuarioPara.nombre,
              style: const TextStyle(color: Colors.black87, fontSize: 12),
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

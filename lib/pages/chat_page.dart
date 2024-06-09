import 'package:chat_app/models/mensajes_response.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_services.dart';
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
  late ChatService chatService;
  late SocketService socketService;
  late AuthServices authService;
  final List<ChatMessage> _messagges = [];

  @override
  void initState() {
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthServices>(context, listen: false);

    socketService.socket.on('mensaje-personal', _escucharMensaje);
    _cargarMensajes(chatService.usuarioPara.uid);
    super.initState();
  }

  _cargarMensajes(String usuarioID) async {
    List<Mensaje> chat = await chatService.getChat(usuarioID);

    final history = chat.map((m) => ChatMessage(
        text: m.mensaje,
        uid: m.de,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 0))
          ..forward()));

    setState(() {
      _messagges.insertAll(0, history);
    });
  }

  _escucharMensaje(dynamic payload) {
    ChatMessage message = ChatMessage(
        text: payload['mensaje'],
        uid: payload['de'],
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 400)));

    setState(() {
      _messagges.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  void dispose() {
    _mensajeController.dispose();
    _focus.dispose();
    for (ChatMessage message in _messagges) {
      message.animationController.dispose();
    }

    socketService.socket.off('mensaje-personal');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      uid: authService.usuario!.uid,
      text: text,
    );

    _messagges.insert(0, message);

    message.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });

    socketService.emit('mensaje-personal', {
      'de': authService.usuario!.uid,
      'para': chatService.usuarioPara.uid,
      'mensaje': text
    });
  }
}

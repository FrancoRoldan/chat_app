import 'package:chat_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {super.key,
      required this.text,
      required this.uid,
      required this.animationController});
  final String text;
  final String uid;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context, listen: false);
    return FadeTransition(
        opacity: animationController,
        child: SizeTransition(
            sizeFactor: CurvedAnimation(
                parent: animationController, curve: Curves.easeOut),
            child: Container(
                child: uid == authService.usuario!.uid
                    ? _myWidget()
                    : _notMyWidget())));
  }

  Widget _myWidget() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(right: 5, bottom: 5, left: 50),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20.0)),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _notMyWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(right: 50, bottom: 5, left: 5),
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(20.0)),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

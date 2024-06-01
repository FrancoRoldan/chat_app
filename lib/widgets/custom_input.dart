import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {super.key,
      required this.textController,
      required this.hintText,
      required this.icon,
      this.obscure = false,
      this.inputType = TextInputType.text});

  final String hintText;
  final IconData icon;
  final bool obscure;
  final TextInputType inputType;
  final TextEditingController textController;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextField(
        controller: textController,
        autocorrect: false,
        keyboardType: inputType,
        obscureText: obscure,
        decoration: InputDecoration(
            prefix: Icon(icon),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: hintText),
      ),
    );
  }
}

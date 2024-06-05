import 'package:flutter/material.dart';

mostrarAlerta(BuildContext context, String titulo, String subtitulo) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(titulo),
            content: Text(subtitulo),
            actions: [
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                elevation: 5,
                color: Colors.indigo,
                child: const Text('Ok'),
              )
            ],
          ));
}

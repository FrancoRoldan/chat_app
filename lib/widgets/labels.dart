import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({super.key, required this.ruta});
  final String ruta;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          (ruta == 'register')
              ? '¿No tienes una cuenta?'
              : 'Ya tienes una cuenta?',
          style: const TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, ruta);
          },
          child: Text(
            (ruta == 'register') ? 'Crea una ahora!' : 'Ingresa ahora!',
            style: TextStyle(
                color: Colors.blue[300],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

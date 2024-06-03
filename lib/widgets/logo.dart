import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, required this.tittle});
  final String tittle;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 170),
          child: Column(
            children: [
              const Image(image: AssetImage('assets/tag-logo.png')),
              const SizedBox(
                height: 20,
              ),
              Text(
                tittle,
                style: const TextStyle(fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}

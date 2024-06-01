import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 170),
          child: const Column(
            children: [
              Image(image: AssetImage('assets/tag-logo.png')),
              SizedBox(
                height: 20,
              ),
              Text(
                'Messenger',
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}

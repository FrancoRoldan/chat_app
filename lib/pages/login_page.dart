import 'package:chat_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _Logo(),
            _Form(),
            _Labels(),
            const Text(
              'Términos y condiciones de uso',
              style: TextStyle(fontWeight: FontWeight.w200),
            )
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

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

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const CustomInput(
              hintText: 'Email',
              icon: Icons.email_outlined,
              inputType: TextInputType.emailAddress),
          const CustomInput(
            hintText: 'Password',
            icon: Icons.lock_outline,
            inputType: TextInputType.emailAddress,
            obscure: true,
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Ingresar'))
        ],
      ),
    );
  }
}

class _Labels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '¿No tienes una cuenta?',
          style: TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Crea una ahora!',
          style: TextStyle(
              color: Colors.blue[300],
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

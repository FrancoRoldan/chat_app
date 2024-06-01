import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 700, maxWidth: 500),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Logo(),
                  _Form(),
                  const Labels(),
                  const Text(
                    'Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
              textController: emailController,
              hintText: 'Email',
              icon: Icons.email_outlined,
              inputType: TextInputType.emailAddress),
          CustomInput(
            textController: passwordController,
            hintText: 'Password',
            icon: Icons.lock_outline,
            inputType: TextInputType.emailAddress,
            obscure: true,
          ),
          ElevatedButton(
              onPressed: () {},
              child: const SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(child: Text('Ingresar'))))
        ],
      ),
    );
  }
}

import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 700, maxWidth: 500),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.95,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Logo(
                      tittle: 'Register',
                    ),
                    _Form(),
                    const Labels(
                      ruta: 'login',
                    ),
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
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  TextEditingController nombreController = TextEditingController();
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
              textController: nombreController,
              hintText: 'Nombre',
              icon: Icons.perm_identity,
              inputType: TextInputType.emailAddress),
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

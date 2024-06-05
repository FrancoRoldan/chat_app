import 'package:chat_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthServices>(context, listen: false);
    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, 'usuarios');
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}

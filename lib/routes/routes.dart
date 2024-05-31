import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/usuarios_page.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'usuarios': (BuildContext context) => const UsuariosPage(),
  'chat': (BuildContext context) => const ChatPage(),
  'login': (BuildContext context) => const LoginPage(),
  'register': (BuildContext context) => const RegisterPage(),
  'loading': (BuildContext context) => const LoadingPage(),
};

import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/mensajes_response.dart';
import 'package:chat_app/models/usuarios.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioId) async {
    try {
      final resp = await http
          .get(Uri.parse('${Enviroment.apiUrl}/mensajes/$usuarioId'), headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthServices.getToken()
      });

      final mensajeResponse = mensajesResponseFromJson(resp.body);

      return mensajeResponse.mensajes;
    } catch (e) {
      return [];
    }
  }
}

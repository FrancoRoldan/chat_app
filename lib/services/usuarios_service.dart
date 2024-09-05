import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/usuarios.dart';
import 'package:chat_app/models/usuarios_response.dart';
import 'package:chat_app/services/storage_services.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get(Uri.parse('${Enviroment.apiUrl}/usuarios'),
          headers: {
            'Content-Type': 'application/json',
            'x-token': await StorageService.getToken()
          });

      final usuariosResponse = usuariosResponseFromJson(resp.body);

      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}

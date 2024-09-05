import 'dart:convert';

import 'package:chat_app/services/storage_services.dart';
import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/usuarios.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthServices extends ChangeNotifier {
  Usuario? _usuario;
  bool _autenticando = false;
  bool _registrando = false;

  final StorageService _storage = StorageService();

  bool get autenticando => _autenticando;
  bool get registrando => _registrando;
  Usuario? get usuario => _usuario;

  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  set registrando(bool valor) {
    _registrando = valor;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;

    final data = {'email': email, 'password': password};

    final resp = await http.post(Uri.parse('${Enviroment.apiUrl}/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      _usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String email, String nombre, String password) async {
    autenticando = true;

    final data = {'email': email, 'nombre': nombre, 'password': password};

    final resp = await http.post(Uri.parse('${Enviroment.apiUrl}/login/new'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      _usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.getData(StorageService.sharedPrefTokenData);

    final resp = await http.get(Uri.parse('${Enviroment.apiUrl}/login/renew'),
        headers: {'Content-Type': 'application/json', 'x-token': token});

    autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      _usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);

      return true;
    } else {
      _logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.cacheData(token, StorageService.sharedPrefTokenData);
  }

  Future _logout() async {
    return await _storage.removeCacheData(StorageService.sharedPrefTokenData);
  }
}

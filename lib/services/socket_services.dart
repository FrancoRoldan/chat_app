import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/services/storage_services.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late io.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  io.Socket get socket => _socket;
  Function get emit => _socket.emit;

  void connect() async {
    final token = await StorageService.getToken();

    _socket = io.io(
        '${Enviroment.socketUrl}?token=$token',
        io.OptionBuilder()
            .setTransports(['websocket']) // Use WebSocket transport
            .enableForceNew()
            .build());

    _socket.on('connect', (_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    //emit.call('connect');
  }

  void disconnect() {
    _socket.disconnect();
  }
}

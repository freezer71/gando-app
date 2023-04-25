import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/models/chat/chat.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  final StreamController<Chat> _socketResponse =
      StreamController<Chat>.broadcast();
  final StreamController<bool> _typingController =
      StreamController<bool>.broadcast();

  late IO.Socket _socket;

  Stream<Chat> get getResponse => _socketResponse.stream;
  Stream<bool> get getTyping => _typingController.stream;

  String _idClient = "";

  void setClientId(String userId) {
    _idClient = userId;
  }

  void connectAndListen() {
    _socket = IO.io(
        API_URL,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setQuery({'userId': _idClient}) // optional
            .build());

    _socket.connect();

    _socket.onConnect((_) {
      print('connected $_idClient');
    });
    _socket.onConnectError((_) => print('connected Error '));
    _socket.onError((_) => print('connected Error '));

    //When an event recieved from server, data is added to the stream
    _socket.on('newMessage', (data) {
      _socketResponse.sink.add(Chat(
          sender: data["sender"],
          body: data["content"],
          sendDate: DateTime.now().toUtc()));
    });

    _socket.on('writting', (data) {
      print("datawritting $data ${data["isWritting"]}");
      _typingController.sink.add(data["isWritting"]);
    });
  }

  void isTyping(
      {required String senderId,
      required String recipientId,
      required bool isWriting}) {
    _socket.emit(
      "writting",
      {
        "senderId": senderId,
        "recipientId": recipientId,
        "isWritting": isWriting,
      },
    );
  }

  void isMessageSeen({
    required String messageId,
  }) {
    _socket.emit("messageSeen", messageId);
  }

  void dispose() {
    _socket.dispose();
    _socket.destroy();
    _socket.close();
    _socket.disconnect();
    _typingController.close();
    _socketResponse.close();
  }
}

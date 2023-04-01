import 'package:gando/config/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  SocketClient();

  String idClient = "";
  IO.Socket? _socket;

  IO.Socket init() {
    IO.Socket socket = IO.io(
        API_URL,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setQuery({'userId': idClient}) // optional
            .build());
    return socket;
  }

  IO.Socket connexion() {
    if (_socket == null) {
      _socket = init();
      _socket?.connect();
    }
    return _socket!;
  }

  IO.Socket disconnect() {
    _socket ??= connexion();
    _socket?.disconnect();
    return _socket!;
  }
}

import 'package:socket_io_client/socket_io_client.dart';

//
class SocketClient {
  late Socket socket;

  SocketClient._internal() {
    print("Connecting Socket....");
    socket = io(
        'http://192.168.43.244:3000',
        OptionBuilder()
            .setPath('/socket.io')
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
  }

  static final SocketClient _instance = SocketClient._internal();

  factory SocketClient() => _instance;

  String? get socketID => socket.id;

  void emitEvent(String eventName, dynamic data) {
    socket.emit(eventName, data);
  }

  void listenEvent(String eventName, Function(dynamic data) callback) {
    socket.on(eventName, callback);
  }
}

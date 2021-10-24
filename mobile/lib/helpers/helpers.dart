import 'package:socket_io_client/socket_io_client.dart' as IO;

// ignore: constant_identifier_names
const BASE_URL = /*"https://whiteboard-guipahtlfa-ew.a.run.app";*/ "http://192.168.1.129:8080";


final IO.Socket appSocket = IO.io(
  BASE_URL,
  <String, dynamic>{
    'transports': ['websocket'],
  },
);
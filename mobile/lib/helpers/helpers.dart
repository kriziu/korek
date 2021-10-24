import 'package:socket_io_client/socket_io_client.dart' as IO;

// ignore: constant_identifier_names
const BASE_URL = "https://korekapp.herokuapp.com";


final IO.Socket appSocket = IO.io(
  BASE_URL,
  <String, dynamic>{
    'transports': ['websocket'],
  },
);
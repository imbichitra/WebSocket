import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketState extends ChangeNotifier{

  static const _url = 'ws://echo.websocket.org';
  WebSocketChannel channel;
  final List<String> list = [];
  TextEditingController controller = TextEditingController(); 


  WebSocketState(){
    _initializeScoket();
  }

  void _initializeScoket(){
    channel= IOWebSocketChannel.connect(_url);
    channel.stream.listen((data) { 
        list.add(data);
        notifyListeners();
    });
  }

  ListView getMessageList() {
    List<Widget> listWidget = [];

    for (String message in list) {
      listWidget.add(ListTile(
        title: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 22),
            ),
          ),
          color: Colors.teal[50],
          height: 60,
        ),
      ));
    }

    return ListView(children: listWidget);
  }

  void sendDate(String data){
    channel.sink.add(data);
  }

  void disposeChannel() {
    controller.dispose();
    channel.sink.close();
  }

  @override
  void dispose() {
    disposeChannel();
    super.dispose();
  }
}
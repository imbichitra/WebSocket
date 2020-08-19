import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket/states/web_socket_state.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: WebSocketState())
  ],
  child: MyApp(),));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'WebSocket Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final webSocketState = Provider.of<WebSocketState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: webSocketState.controller,
              decoration: InputDecoration(
                  labelText: "Send message", border: OutlineInputBorder()),
            ),

            Expanded(
              child: webSocketState.getMessageList(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (webSocketState.controller.text.isNotEmpty) {
            print(webSocketState.controller.text);
            webSocketState.sendDate(webSocketState.controller.text);
            
            webSocketState.controller.text = '';
          }
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

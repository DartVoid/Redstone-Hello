import 'dart:io';
import 'package:redstone/server.dart' as app;

@app.Route('/hello', matchSubPaths: true)
hello() => "Hello world!";

@app.Route('/hello/:message')
helloMessage(String message) => "Hello $message!";

void main() {
  var portEnv = Platform.environment['PORT'];
  var port = portEnv == null ? 9090 : int.parse(portEnv);

  app.setupConsoleLog();
  app.start(port: port);
}


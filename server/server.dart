import 'dart:io';
import 'package:shelf/shelf.dart' as shelf;
import 'package:redstone/server.dart' as app;

@app.Route('/hello', matchSubPaths: true)
hello() => "Hello world!";

@app.Route('/hello/:message')
helloMessage(String message) => "Hello $message!";

// Support for CORS
@app.Interceptor(r'/.*')
  handleResponseHeader() {
  if (app.request.method == "OPTIONS") {
    // Overwrite the current response and interrupt the chain.
    app.response = new shelf.Response.ok(null, headers: _createCorsHeader());
    app.chain.interrupt();
  } else {
    // Process the chain and wrap the response
    app.chain.next(() => app.response.change(headers: _createCorsHeader()));
  }
}

_createCorsHeader() =>  {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "Content-type",
  "Access-Control-Allow-Methods": "OPTIONS, HEAD, GET, POST, PUT, DELETE"
};

void main() {
  var portEnv = Platform.environment['PORT'];
  var port = portEnv == null ? 9090 : int.parse(portEnv);

  app.setupConsoleLog();
  app.start(port: port);
}


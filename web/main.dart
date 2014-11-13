import 'dart:html';

void main() {
  InputElement formInput    = querySelector("#form-input");
  ButtonElement formSubmit  = querySelector("#form-submit");
  InputElement formClear    = querySelector("#form-clear");
  DivElement respWrap       = querySelector("#response-wrapper");
  DivElement formResp       = querySelector("#response");

  String serviceUrl = "/hello";

  formSubmit.onClick.listen((e) {
    // Prevent form submit
    e.preventDefault();

    // Setup url (port 9090 for during development locally, otherwise use
    // standard port 80 for production)
    Uri uri = Uri.parse(window.location.href);
    var port = uri.port != 8080 ? 80 : 9090;
    Uri url = Uri.parse("http://${uri.host}:${port}/hello/${Uri.encodeQueryComponent(formInput.value)}");

    respWrap.classes = ["pure-u-1-1", "well"];

    HttpRequest.request(url.toString(), method: "GET").then((response) {
      formResp.append(new ParagraphElement()..text = "${Uri.decodeQueryComponent(response.responseText)}");
    }).catchError((e) {
      formResp.appendHtml("<p>Unable to connect to the server</p>");
    });
  });

  formClear.onClick.listen((e) {
    respWrap.classes = ["pure-u-1-1"];
    formResp.children.clear();
  });
}


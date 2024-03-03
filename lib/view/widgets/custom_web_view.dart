import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class MyWebViewScreen extends StatefulWidget {
  const MyWebViewScreen({super.key, required this.url});
  final String url;

  @override
  State<MyWebViewScreen> createState() => _MyWebViewScreenState();
}

class _MyWebViewScreenState extends State<MyWebViewScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel("messageHandler", onMessageReceived: (message) async {
        print("message from the web view=\"${message.message}\"");
        final script = "document.getElementById('value').innerText=\"${message.message}\"";
        // _webViewController?.evaluateJavascript(script);
        if (message.message != "") {
          final prefs = await SharedPreferences.getInstance();
          var trId = prefs.getString("trId");

          log("NEW TRY_ID $trId");
          log("NEW TRY_ID MESSAGE ${message.message}");
          //SPATTOSERVICESONLINE


            // ignore: use_build_context_synchronously
            Navigator.pop(context, jsonDecode(message.message));

        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
          // Navigator.pop(context);
        }
      })
      ..loadRequest(Uri.parse(widget.url));

    log(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WebViewWidget(controller: _webViewController)

        /* WebView(
        initialUrl: 'about:blank',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _webViewController = webViewController;
          _webViewController?.loadUrl(widget.url);
          //String fileContent = await rootBundle.loadString('assets/index.html');
          // _webViewController?.loadUrl(Uri.dataFromString(fileContent,
          //     mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
          //     .toString());
        },
        javascriptChannels: <JavascriptChannel>{
          JavascriptChannel(
            name: 'messageHandler',
            onMessageReceived: (JavascriptMessage message) async {
              print("message from the web view=\"${message.message}\"");
              final script =
                  "document.getElementById('value').innerText=\"${message.message}\"";
              _webViewController?.evaluateJavascript(script);
              if (message.message != "") {
                final prefs = await SharedPreferences.getInstance();
                var trId = prefs.getString("trId");

                log("NEW TRY_ID $trId");
                //SPATTOSERVICESONLINE
                http.get(Uri.parse("https://spatto.in/payment/checksum.php"
                    "?merchantId=SPATTOSERVICESONLINE&merchantTransactionId=$trId")).then((value) {

                  log("NEW TRY_RESPONSE ${jsonDecode(value.body)}");

                  Navigator.pop(context, jsonDecode(value.body));
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Something went wrong")));
                // Navigator.pop(context);
              }
            },
          )
        },
      ),*/
        );
  }
}

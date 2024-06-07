import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'res/listData.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AlipayWebView extends StatefulWidget {
  final String alipayUrl;

  AlipayWebView({required this.alipayUrl});

  @override
  _AlipayWebViewState createState() => _AlipayWebViewState();
}

class _AlipayWebViewState extends State<AlipayWebView> {
  // ignore: unused_field
  static const platform = MethodChannel('com.example.yourapp/alipay');

  @override
  void dispose() {
    _sendPopMsgToH5();
    super.dispose();
  }

  _sendPopMsgToH5() {
    dataViewController?.evaluateJavascript(source: "window.alerCallback('{\"action\":\"paySuccess\"}')");
  }

  Future<void> _openAlipay(String url) async {
    try {
      final bool result = await platform.invokeMethod('openAlipay', {'url': url});
      print('Alipay opened: $result');
    } on PlatformException catch (e) {
      print('Failed to open Alipay: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('去充值'),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          // wViewController = webViewController;
          webViewController.loadHtmlString(PayHtmlData);
        },
        navigationDelegate: (NavigationRequest request) async {
          String url = Uri.decodeComponent(request.url);
          print("-----alipay url-----$url");
          if (request.url.startsWith('alipays://')) {
            _openAlipay(request.url);
            return NavigationDecision.prevent;
          } else if(request.url.contains('xjkyplay')){
            _sendPopMsgToH5();
            Navigator.pop(context);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
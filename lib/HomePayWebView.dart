import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app01/res/listData.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class PayWebView extends StatefulWidget {
  const PayWebView({super.key});

  @override
  State<PayWebView> createState() => _PayWebViewState();
}

class _PayWebViewState extends State<PayWebView> {
  InAppWebViewController? webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _sendPopMsgToH5();
    super.dispose();
  }

  _sendPopMsgToH5() {
    dataViewController?.evaluateJavascript(source: "window.alerCallback('{\"action\":\"paySuccess\"}')");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('支付'),
      ),
      body: InAppWebView(
        initialData: InAppWebViewInitialData(data: PayHtmlData),
        initialOptions: InAppWebViewGroupOptions(
          android: AndroidInAppWebViewOptions(
            allowFileAccess: true,
            useHybridComposition: true,
          ),
          crossPlatform: InAppWebViewOptions(userAgent: 'Custom User Agent WWJ.cn', allowFileAccessFromFileURLs: true, javaScriptEnabled: true),
          ios: IOSInAppWebViewOptions(
            allowsInlineMediaPlayback: true,
          ),
        ),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          var uri = navigationAction.request.url;
          print("shouldOverrideUrlLoading: $uri");
          if (uri != null) {
            if (uri.scheme == "alipay") {
              // Handle the Alipay URL scheme
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
                return NavigationActionPolicy.CANCEL;
              }
            }
          }
          return NavigationActionPolicy.ALLOW;
        },
        onLoadStart: (controller, url) async {
          print("onLoadStart: $url");
        },
        onLoadStop: (controller, url) async {
          print('onLoadStop:----->$url');
          if (url != null) {
            _handleAlipayScheme(url.toString());
          }
        },
        onLoadError: (controller, url, code, message) {
          print("Page failed to load: $url  --  $code  --  $message");
        },
        onConsoleMessage: (controller, consoleMessage) {
          print(consoleMessage.message);
        },
      ),
    );
  }

  Future<void> _handleAlipayScheme(String? url) async {
    print('alipay:----->$url');
    if (url!.contains("alipays://")) {
      String contentUrl = url + '&' + 'fromAppUrlScheme=xjkyplay';
      print('contentUrl:----->$contentUrl');
      if (await canLaunchUrl(Uri.parse(contentUrl))) {
        await launchUrl(Uri.parse(contentUrl));
      } else {
        throw 'Could not launch $contentUrl';
      }
    }
  }
}

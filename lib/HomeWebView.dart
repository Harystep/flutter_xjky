import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'res/listData.dart';
import 'res/dioL.dart';

class HomeWebViewUI extends StatefulWidget {
  const HomeWebViewUI({super.key});

  @override
  State<HomeWebViewUI> createState() => _HomeWebViewUIState();
}

class _HomeWebViewUIState extends State<HomeWebViewUI> with AutomaticKeepAliveClientMixin {
  //http://camera.emugif.com
  //http://h5.hyjjc.cn
  String initUrl = 'http://h5.hyjjc.cn?token=$access_token&channelKey=$Channel_key&coinType=2&uiskin4=0&scoreType=0';
  InAppWebViewController? webViewController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _queryUserInfoAPI();
  }

  _queryUserInfoAPI() async {
    Map dic = await getUserInfoAPI();
    print('HomeWebViewUI--->$dic');
    if (dic['errMsg'] == 'OK') {
    } else {
      deleteToken();
      Navigator.pushReplacementNamed(context, '/login');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("登录已过期，请重新登录"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.black26,
        ),
      );
    }
  }

  _queryPayOrderInfo(String productId) async {
    print('productId------>$productId');
    Map dic = await alipayOrderInfo(productId, access_token);
    if (dic['errMsg'] == 'OK') {
      String data = dic['data'];
      PayHtmlData = data;
      //HomePayWebView              HomeLocalWebView
      Navigator.pushNamed(context, '/AlipayWebView', arguments: {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(dic['errMsg'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        Scaffold(
            resizeToAvoidBottomInset: false,
            body: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(initUrl)),
                initialSettings: InAppWebViewSettings(
                    allowBackgroundAudioPlaying: true,
                    allowFileAccess: true,
                    allowsInlineMediaPlayback: true,
                    userAgent: "Custom User Agent WWJ.cn",
                    javaScriptEnabled: true),
                onLoadStop: (controller, url) {
                  setState(() {
                    isLoading = false;
                  });
                },
                onWebViewCreated: (controller) {
                  webViewController = controller;
                  dataViewController = controller;
                  webViewController?.addJavaScriptHandler(
                      handlerName: 'logoutGame',
                      callback: (args) {
                        print('logoutGame------->$args');
                        deleteToken();
                        Navigator.pushReplacementNamed(context, '/login');
                      });
                  webViewController?.addJavaScriptHandler(
                      handlerName: 'buyItem',
                      callback: (args) {
                        List arr = args;
                        String productId = arr[0];
                        _queryPayOrderInfo(productId);
                      });
                  webViewController?.addJavaScriptHandler(
                      handlerName: 'exitGame',
                      callback: (args) {
                        print('exitGame------->$args');
                      });
                })),
        if (isLoading)
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/launch_image.png'), // 替换为你的图片路径
                fit: BoxFit.cover,
              ),
            ),
          ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

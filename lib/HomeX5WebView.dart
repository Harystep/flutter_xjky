import 'package:flutter/material.dart';
import 'package:x5_webview/x5_sdk.dart';
import 'package:x5_webview/x5_webview.dart';
import 'res/listData.dart';
import 'package:permission_handler/permission_handler.dart';
import 'res/dioL.dart';

class HomeX5WebViewUI extends StatefulWidget {
  const HomeX5WebViewUI({super.key});

  @override
  State<HomeX5WebViewUI> createState() => _HomeX5WebViewUIState();
}

class _HomeX5WebViewUIState extends State<HomeX5WebViewUI> with AutomaticKeepAliveClientMixin {
  String initUrl = 'http://h5.hyjjc.cn?token=$access_token&channelKey=tuibiwangzhe&coinType=2&uiskin4=0&scoreType=0';
  late X5WebViewController webViewController;
  var crashInfo;
  bool isLoadOk = false;

  @override
  void initState() {
    super.initState();
    loadX5();
    _queryUserInfoAPI();
  }

  _queryUserInfoAPI() async {
    Map dic = await getUserInfoAPI();
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
    return Scaffold(
      body: X5WebView(
          url: initUrl,
          javaScriptEnabled: true,
          userAgentString: "userAgent : 'Custom User Agent WWJ.cn'",
          javascriptChannels: JavascriptChannels(["logoutGame", "buyItem", "exitGame"], (name, data) {
            switch (name) {
              case "logoutGame":
                print('logoutGame------->');
                deleteToken();
                Navigator.pushReplacementNamed(context, '/login');
              case "buyItem":
                print('buyItem------->$data');
                _queryPayOrderInfo(data);
              case "exitGame":
                print('exitGame------->');
            }
          }),
          onWebViewCreated: (controller) {
            webViewController = controller;
          }),
    );
  }

  Future<bool> _requestPermissions() async {
    Map<Permission, PermissionStatus> permissions = await [Permission.storage, Permission.phone].request();
    List<bool> results = permissions.values.toList().map((status) {
      return status == PermissionStatus.granted;
    }).toList();
    return !results.contains(false);
  }

  void loadX5() async {
    if (isLoadOk) {
      print("你已经加载过x5内核了,如果需要重新加载，请重启");
      return;
    }
    if (!await _requestPermissions()) {
      print("权限未打开");
      return;
    }
    //没有x5内核，是否在非wifi模式下载内核。默认false
    await X5Sdk.setDownloadWithoutWifi(true);
    await X5Sdk.setX5SdkListener(X5SdkListener(onInstallFinish: (int code) {
      print("X5内核安装完成");
    }, onDownloadFinish: (int code) {
      print("X5内核下载完成");
    }, onDownloadProgress: (int progress) {
      print("X5内核下载中---$progress%");
    }));
    print("----开始加载内核----");
    var isOk = await X5Sdk.init();
    print(isOk ? "X5内核成功加载" : "X5内核加载失败");

    var x5CrashInfo = await X5Sdk.getCrashInfo();
    print(x5CrashInfo);
    if (isOk) {
      x5CrashInfo = "tbs_core_version${x5CrashInfo.split("tbs_core_version")[1]}";
    }
    setState(() {
      isLoadOk = isOk;
      crashInfo = x5CrashInfo;
    });
    isLoadOk = true;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

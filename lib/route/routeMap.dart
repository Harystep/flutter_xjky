import 'package:flutter/material.dart';
import 'package:flutter_app01/AlipayWebView.dart';
import 'package:flutter_app01/LoginView.dart';
import '../pages/tabs/Tabs.dart';
import '../HomeWebView.dart';
import '../HomePayWebView.dart';

//配置路由
Map routeMap = {
  '/tabs': (context, {arguments}) => const Tabs(),
  '/login': (context, {arguments}) => const LoginScreenUI(),
  '/HomeWebView': (context, {arguments}) => const HomeWebViewUI(),
  '/HomePayWebView': (context, {arguments}) => const PayWebView(),
  '/AlipayWebView': (context, {arguments}) => AlipayWebView(alipayUrl: '',),
};

var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function pageContentBuidler = routeMap[name] as Function;
  // ignore: unnecessary_null_comparison
  if (pageContentBuidler != null) {
    final Route route = MaterialPageRoute(builder: (context) => pageContentBuidler(context, arguments: settings.arguments));
    return route;
  } else {
    final Route route = MaterialPageRoute(builder: (context) => pageContentBuidler(context));
    return route;
  }
};

import 'package:flutter/material.dart';
import '../../HomeWebView.dart';
import '../../HomeX5WebView.dart';
import 'package:flutter/foundation.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with AutomaticKeepAliveClientMixin {
  // final List<Widget> _pageList = defaultTargetPlatform == TargetPlatform.android ? [const HomeX5WebViewUI()] : [const HomeWebViewUI()];
  final List<Widget> _pageList = [HomeWebViewUI()];

//HomeWebView
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
        length: 1,
        animationDuration: const Duration(microseconds: 10), //设置动画过渡时间 0.01秒
        child: Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(), //禁止滑动切换页面
            children: _pageList,
          ),
        ));
  }

// 自定义页面过渡样式

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

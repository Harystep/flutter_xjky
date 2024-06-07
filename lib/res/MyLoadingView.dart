import 'package:flutter/material.dart';

class MyLoadingScreen extends StatefulWidget {
  @override
  _MyLoadingScreenState createState() => _MyLoadingScreenState();
}

class _MyLoadingScreenState extends State<MyLoadingScreen> {
  bool _isLoading = false;

  // 模拟数据加载
  void _loadData() {
    setState(() {
      _isLoading = true;
    });

    // 模拟耗时操作
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

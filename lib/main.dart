import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'LoginView.dart';
import 'res/listData.dart';
import 'pages/tabs/Tabs.dart';
import 'route/routeMap.dart';
// ignore: unused_import

void main() async {
  runApp(const GotoLoginUI());
}

class GotoLoginUI extends StatefulWidget {
  const GotoLoginUI({super.key});

  @override
  State<GotoLoginUI> createState() => _GotoLoginUIState();
}

class _GotoLoginUIState extends State<GotoLoginUI> {
  bool isLogginIn = false;
  bool delayFlag = true;
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _delayStartDataStatus();
  }

  _delayStartDataStatus() {
    // 延迟一秒钟后执行的操作
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        delayFlag = false;
      });
    });
  }

  _checkLoginStatus() async {
    String? token = await getToken();
    print('token------> $token');
    if (token != null) {
      access_token = token;
      setState(() {
        isLogginIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // // 设置状态栏透明
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color.fromARGB(231, 114, 156, 170)), // 未获得焦点时的颜色
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: const Color.fromARGB(255, 98, 160, 211)), // 获得焦点时的颜色
            ),
          ),
        ),
        home: isLogginIn ? const Tabs() : const LoginScreenUI(),
        // Stack(
        //   children: [
        //     if (delayFlag == false) isLogginIn ? const Tabs() : const LoginScreenUI(),
        //     if (delayFlag)
        //       Container(
        //         decoration: BoxDecoration(
        //           image: DecorationImage(
        //             image: AssetImage('images/launch_image.png'), // 替换为你的图片路径
        //             fit: BoxFit.fill,
        //           ),
        //         ),
        //       ),
        //   ],
        // ),
        onGenerateRoute: onGenerateRoute);
  }
}

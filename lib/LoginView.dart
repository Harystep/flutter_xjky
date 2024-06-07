import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'res/listData.dart';
import 'res/LoginBackModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'res/dioL.dart';

class LoginScreenUI extends StatefulWidget {
  const LoginScreenUI({super.key});

  @override
  State<LoginScreenUI> createState() => _LoginScreenUIState();
}

class _LoginScreenUIState extends State<LoginScreenUI> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  Timer? _timer;
  int _start = 60;
  bool _isButtonDisabled = false;
  bool _sureAgreeFlag = false;
  String? loginFlag;
  bool _checkBoxFlag = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLoginStatus();
  }

  _checkLoginStatus() async {
    String? token = await getToken();
    loginFlag = await getLoginOnceFlag();
    print('token------> $token');
    if (token != null) {
      access_token = token;
      setState(() {
        _checkBoxFlag = true;
      });
    } else {
      if (loginFlag == null) {
        _showUserAgreementDialog(context);
      }
    }
  }

  void startTimer() {
    if (_phoneController.text.length == 0) {
      _showAlertViewWithContent('请输入手机号');
      return;
    }
    if (_phoneController.text.length != 11) {
      _showAlertViewWithContent('手机号填写有误');
      return;
    }
    _sendPhoneCode(_phoneController.text);
  }

  void _showUserAgreementDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              '温馨提示',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                          text: '请您务必阅读并理解“用户协议”和“隐私政策”中的内容，包括但不限于：为了更好的向您提供服务以及相关功能，我们会收集、使用必要的信息，未经您同意，我们不会向第三方提供或共享您的信息，我们会采取先进的安全措施保证您的信息安全。您可阅读'),
                      TextSpan(
                          text: '《用户协议》',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              String url = User_Agreement_URL;
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              } else {
                                throw 'Could not launch $url';
                              }
                            }),
                      TextSpan(text: '和'),
                      TextSpan(
                          text: '《隐私政策》',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              String url = User_Policy_URL;
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              } else {
                                throw 'Could not launch $url';
                              }
                              // 添加点击事件处理逻辑
                            }),
                      TextSpan(text: '了解详细信息。如果您同意，请点击下面同意按钮。'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('不同意'),
              onPressed: () {
                setState(() {
                  _sureAgreeFlag = false;
                  _checkBoxFlag = false;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                '同意',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                setState(() {
                  _sureAgreeFlag = true;
                  _checkBoxFlag = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    //销毁定时器
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
          child: Text('登录'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0), // 设置圆角大小
              child: Image.asset(
                'images/logo.png',
                height: 120.0,
                width: 120.0,
                fit: BoxFit.cover,
              ), // 替换为你的图片资源路径
            ),
            SizedBox(height: 30),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration:
                  InputDecoration(labelText: '手机号', prefixIcon: Icon(Icons.phone), border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red))),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _codeController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: '验证码', prefixIcon: Icon(Icons.lock), border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red))),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(onPressed: _isButtonDisabled ? null : startTimer, child: Text(_isButtonDisabled ? '重新发送（$_start）' : '发送验证码')),
              ],
            ),
            SizedBox(height: 50),
            Container(
              width: 300.0,
              child: ElevatedButton(
                onPressed: () {
                  // 登录操作
                  String phone = _phoneController.text;
                  String code = _codeController.text;
                  _loginWithCode(phone, code);
                },
                child: Text('登录'),
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(
                  height: 32,
                  width: 32,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _checkBoxFlag = !_checkBoxFlag;
                        _sureAgreeFlag = _checkBoxFlag;
                      });
                    },
                    icon: _checkBoxFlag ? Image.asset('images/login_sel.png') : Image.asset('images/login_nor.png'),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: '请您仔细阅读'),
                      TextSpan(
                          text: '《用户协议》',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              String url = User_Agreement_URL;
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            }),
                      TextSpan(text: '和'),
                      TextSpan(
                          text: '《隐私政策》',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              String url = User_Policy_URL;
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                              // 添加点击事件处理逻辑
                            }),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _sendPhoneCode(String phone) async {
    Map dic = await sendCodeAPI(phone);
    print('code back------> $dic');
    if (dic['errMsg'] == 'OK') {
      setState(() {
        _isButtonDisabled = true;
      });
      const oneSec = Duration(seconds: 1);
      _timer = Timer.periodic(oneSec, (timer) {
        if (_start == 0) {
          //倒计时结束
          setState(() {
            timer.cancel();
            _isButtonDisabled = false;
            _start = 60;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      });
    }
  }

  _showAlertViewWithContent(String content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      duration: Duration(seconds: 1),
    ));
  }

  _loginWithCode(String phone, String code) async {
    if (!_sureAgreeFlag) {
      _showUserAgreementDialog(context);
      return;
    }
    if (phone.length == 0 || code.length == 0) {
      _showAlertViewWithContent('手机号和验证码不能为空');
      return;
    }
    if (_phoneController.text.length != 11) {
      _showAlertViewWithContent('手机号填写有误');
      return;
    }
    LoginBackModel? model = await loginWithCodeAPI(phone, code);
    if (model != null && model.errCode == 0) {
      _timer?.cancel();
      saveToken(model.data.accessToken.accessToken);
      saveLoginOnceFlag('1');
      access_token = model.data.accessToken.accessToken;
      Navigator.pushNamed(context, '/tabs');
    } else {
      _showAlertViewWithContent(model?.errMsg as String);
    }
  }
}

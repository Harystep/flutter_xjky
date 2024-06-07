// ignore_for_file: avoid_types_as_parameter_names

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'LoginBackModel.dart';

String Address_host = 'xjapi.yyzyxt.cn';
String Channel_key = 'xjky';
String User_Agreement_URL = 'http://xjapi.yyzyxt.cn/user-xjky.html';
String User_Policy_URL = 'http://xjapi.yyzyxt.cn/policy-xjky.html';
Map<String, String>? headerDic = {'channelKey': Channel_key, 'appversion': '1.0.7'};

Future<Map> sendCodeAPI(String phone) async {
  var url = new Uri.https(Address_host, '/api/mobile/captcha');
  var response = await http.post(url, headers: {'channelKey': Channel_key, 'appversion': '1.0.7'}, body: {'mobile': phone});
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    Map dict = jsonResponse;
    // final model = LoginBackModel.fromJson(dict);
    // print('err:${model.errCode}  message:${model.errMsg}'); //打印一下看看
    return dict;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return {};
  }
}

// Future<LoginBackModel?> loginWithCodeAPI(String phone, String code) async {
//   var url = new Uri.https(Address_host, '/api/login');
//   var response = await http.post(url, headers: {'channelKey': Channel_key, 'appversion': '1.0.7'}, body: {'mobile': phone, 'code': code, 'platform': '3'});
//   if (response.statusCode == 200) {
//     var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
//     Map dict = jsonResponse;
//     final model = LoginBackModel.fromJson(dict);
//     print('err:${model.errCode}  data:${dict}'); //打印一下看看
//     return model;
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//     return null;
//   }
// }

Future<Map> getUserInfoAPI() async {
  var url = new Uri.https(Address_host, '/api/user/info/v2');
  var response = await http.get(url, headers: {'channelKey': Channel_key, 'accessToken': access_token});
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    Map dict = jsonResponse;
    return dict;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return {};
  }
}

Future<Map> queryPayOrderInfoAPI(String productId) async {
  var url = new Uri.https(Address_host, '/api/charge/ali/buy/v2');
  var response = await http.post(url, headers: {'channelKey': Channel_key, 'appversion': '1.0.7', 'accessToken': access_token}, body: {'productId': productId});
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    Map dict = jsonResponse;
    return dict;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return {};
  }
}

final secureStorage = new FlutterSecureStorage();
String access_token = '';
String PayHtmlData = '';

InAppWebViewController? dataViewController;

// 保存数据
Future<void> saveToken(String token) async {
  await secureStorage.write(key: 'token', value: token);
}

// 读取数据
Future<String?> getToken() async {
  return await secureStorage.read(key: 'token');
}

// 删除数据
Future<void> deleteToken() async {
  await secureStorage.delete(key: 'token');
}

// 保存登录状态
Future<void> saveLoginOnceFlag(String flag) async {
  await secureStorage.write(key: 'loginOnceFlag', value: flag);
}

// 获取登录状态
Future<String?> getLoginOnceFlag() async {
  return await secureStorage.read(key: 'loginOnceFlag');
}

import 'package:dio/dio.dart';
import 'package:flutter_app01/res/listData.dart';
import 'LoginBackModel.dart';
import 'dart:convert' as convert;

Future<Map> alipayOrderInfo(String productId, String token) async {
  // 初始化 Dio 实例
  final Dio dio = Dio();

  // 设置请求选项，包括 Content-Type
  final Options options = Options(
    method: 'POST', // 或者 'GET', 'PUT', 'DELETE' 等
    headers: {
      // 'Content-Type': 'applicaon/json; charset=utf-8',
      'accessToken': token,
      'channelKey': Channel_key,
      // 'appversion': '1.0.7'
      // 设置 Content-Type
      // 你可以添加其他头部信息
    },
  );

  // 发送请求
  try {
    Response response = await dio.request(
      'https://$Address_host/api/charge/ali/buy/v2',
      queryParameters: {"productId": productId}, // 对于 POST 或 PUT 请求，传递请求体
      options: options, // 传递请求选项
    );
    // 处理响应
    return response.data;
  } catch (error) {
    // 处理错误
    print('error---->$error');
  }
  return {};
}

Future<LoginBackModel?> loginWithCodeAPI(String phone, String code) async {
  // 初始化 Dio 实例
  final Dio dio = Dio();

  // 设置请求选项，包括 Content-Type
  final Options options = Options(
    method: 'POST', // 或者 'GET', 'PUT', 'DELETE' 等
    headers: {
      // 'Content-Type': 'application/json; charset=utf-8',
      'channelKey': Channel_key,
      'appversion': '1.0.7'
      // 设置 Content-Type
      // 你可以添加其他头部信息
    },
  );

  // 发送请求
  try {
    Response response = await dio.request(
      'https://$Address_host/api/login',
      queryParameters: {"mobile": phone, "code": code, "platform": "3"}, // 对于 POST 或 PUT 请求，传递请求体
      options: options, // 传递请求选项
    );
    // 处理响应
    if (response.statusCode == 200) {
      Map dict = response.data;
      final model = LoginBackModel.fromJson(dict);
      return model;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  } catch (error) {
    // 处理错误
    print('error---->$error');
  }
  return null;
}

/*

Future<LoginBackModel?> loginWithCodeAPI(String phone, String code) async {
  var url = new Uri.https(Address_host, '/api/login');
  var response = await http.post(url, headers: {'channelKey': Channel_key, 'appversion': '1.0.7'}, body: {'mobile': phone, 'code': code, 'platform': '3'});
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    Map dict = jsonResponse;
    final model = LoginBackModel.fromJson(dict);
    print('err:${model.errCode}  data:${dict}'); //打印一下看看
    return model;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return null;
  }
}
*/

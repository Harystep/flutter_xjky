import 'package:dio/dio.dart';
import 'listData.dart';
import 'package:convert/convert.dart';
import 'dart:convert' as convert;

/// 请求方法
enum DioMethod {
  get,
  post,
  put,
  delete,
  patch,
  head,
}

class DioUtil {
  /// 单例模式
  static DioUtil? _instance;
  factory DioUtil() => _instance ?? DioUtil._internal();
  static DioUtil? get instance => _instance ?? DioUtil._internal();

  /// 连接超时时间
  static const int connectTimeout = 60;

  /// 响应超时时间
  static const int receiveTimeout = 60;

  /// Dio实例
  static Dio _dio = Dio();

  /// 初始化
  DioUtil._internal() {
    // 初始化基本选项
    BaseOptions options =
        BaseOptions(baseUrl: 'https://pms.cn', connectTimeout: Duration(seconds: connectTimeout), receiveTimeout: Duration(seconds: receiveTimeout));
    _instance = this;
    // 初始化dio
    _dio = Dio(options);
    // 添加拦截器
    _dio.interceptors.add(InterceptorsWrapper(onRequest: _onRequest, onResponse: _onResponse, onError: _onError));
  }

  /// 请求拦截器
  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 对非open的接口的请求参数全部增加userId
    if (!options.path.contains("open")) {
      // options.queryParameters["userId"] = "xxx";
    }

    // 头部添加token
    options.headers["Content-Type"] = "application/json; charset=utf-8";
    options.headers["channelKey"] = "cjzww";
    options.headers["access_token"] = access_token;
    // 更多业务需求
    handler.next(options);
    // super.onRequest(options, handler);
  }

  /// 相应拦截器
  void _onResponse(Response response, ResponseInterceptorHandler handler) async {
    // 请求成功是对数据做基本处理
    if (response.requestOptions.baseUrl.contains("???????")) {
      // 对某些单独的url返回数据做特殊处理
    }
    if (response.statusCode == 200) {
      // ....
    } else {
      // ....
    }
    handler.next(response);
  }

  /// 错误处理
  void _onError(DioError error, ErrorInterceptorHandler handler) {
    handler.next(error);
  }

  /// 请求类
  Future<T> request<T>(
    String path, {
    DioMethod method = DioMethod.get,
    Map<String, dynamic>? params,
    data,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    const _methodValues = {
      DioMethod.get: 'get',
      DioMethod.post: 'post',
      DioMethod.put: 'put',
      DioMethod.delete: 'delete',
      DioMethod.patch: 'patch',
      DioMethod.head: 'head'
    };
    options ??= Options(method: _methodValues[method]);
    try {
      Response response;
      response = await _dio.request(path,
          data: data,
          queryParameters: params,
          cancelToken: cancelToken,
          options: options,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } on DioError catch (e) {
      rethrow;
    }
  }

  /// 开启日志打印
  /// 需要打印日志的接口在接口请求前 DioUtil.instance?.openLog();
  void openLog() {
    _dio.interceptors.add(LogInterceptor(responseHeader: false, responseBody: true));
  }
}

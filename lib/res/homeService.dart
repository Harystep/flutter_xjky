import 'dio_request.dart';

class GameService {
  /// 单例模式
  static GameService? _instance;
  factory GameService() => _instance ?? GameService._internal();
  static GameService? get instance => _instance ?? GameService._internal();

  /// 初始化
  GameService._internal() {
    // 初始化基本选项
  }

  /// 获取权限列表
  getGameRoomListInfo() async {
    /// 开启日志打印
    DioUtil.instance?.openLog();

    /// 发起网络接口请求
    var result = await DioUtil().request('/api/room/group/list/V5', method: DioMethod.get);
    return result;
  }
}

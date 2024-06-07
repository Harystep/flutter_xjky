class LoginBackModel {
  int errCode = 0;

  String errMsg = '';

  DataModel data = DataModel();

  LoginBackModel();

  LoginBackModel.fromJson(Map json) {
    errCode = safe(errCode, json['errCode']);
    errMsg = safe(errMsg, json['errMsg']);
    data = DataModel.fromJson(safe(<String, dynamic>{}, json['data']));
  }

  T safe<T>(dynamic oldValue, dynamic newValue) {
    if (oldValue.runtimeType == newValue.runtimeType || (oldValue is Map && newValue is Map) || oldValue == null) {
      return newValue;
    } else if ((oldValue is double) && (newValue is int)) {
      return (newValue.toDouble() as T);
    }
    return oldValue;
  }
}

class DataModel {
  int memberId = 0;

  String mobile = '';

  int money = 0;

  int gender = 0;

  int authStatus = 0;

  String avatar = '';

  String hxId = '';

  int hxPwd = 0;

  AccessTokenModel accessToken = AccessTokenModel();

  int inviteCode = 0;

  String aliasId = '';

  int type = 0;

  int goldCoin = 0;

  int account = 0;

  String nickname = '';

  int points = 0;

  String registerTime = '';

  DataModel();

  DataModel.fromJson(Map json) {
    memberId = safe(memberId, json['memberId']);
    mobile = safe(mobile, json['mobile']);
    money = safe(money, json['money']);
    gender = safe(gender, json['gender']);
    authStatus = safe(authStatus, json['authStatus']);
    avatar = safe(avatar, json['avatar']);
    hxId = safe(hxId, json['hxId']);
    hxPwd = safe(hxPwd, json['hxPwd']);
    accessToken = AccessTokenModel.fromJson(safe(<String, dynamic>{}, json['accessToken']));
    inviteCode = safe(inviteCode, json['inviteCode']);
    aliasId = safe(aliasId, json['aliasId']);
    type = safe(type, json['type']);
    goldCoin = safe(goldCoin, json['goldCoin']);
    account = safe(account, json['account']);
    nickname = safe(nickname, json['nickname']);
    points = safe(points, json['points']);
    registerTime = safe(registerTime, json['registerTime']);
  }

  T safe<T>(dynamic oldValue, dynamic newValue) {
    if (oldValue.runtimeType == newValue.runtimeType || (oldValue is Map && newValue is Map) || oldValue == null) {
      return newValue;
    } else if ((oldValue is double) && (newValue is int)) {
      return (newValue.toDouble() as T);
    }
    return oldValue;
  }
}

class AccessTokenModel {
  String accessToken = '';

  String refreshToken = '';

  int expireTime = 0;

  AccessTokenModel();

  AccessTokenModel.fromJson(Map json) {
    accessToken = safe(accessToken, json['accessToken']);
    refreshToken = safe(refreshToken, json['refreshToken']);
    expireTime = safe(expireTime, json['expireTime']);
  }

  T safe<T>(dynamic oldValue, dynamic newValue) {
    if (oldValue.runtimeType == newValue.runtimeType || (oldValue is Map && newValue is Map) || oldValue == null) {
      return newValue;
    } else if ((oldValue is double) && (newValue is int)) {
      return (newValue.toDouble() as T);
    }
    return oldValue;
  }
}

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserTokenModel {
  late String accessToken;
  late String refreshToken;
  late String expireTime;

  UserTokenModel(this.accessToken, this.refreshToken, this.expireTime);
}

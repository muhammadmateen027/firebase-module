import 'package:json_annotation/json_annotation.dart';
import 'package:user_repository/user_repository.dart';

part 'follower_info.g.dart';

///
@JsonSerializable()
class FollowerInfo {
  ///
  const FollowerInfo({
    String? id,
    String? profilePicture,
    String? fullName,
    String? handle,
  })  : _id = id,
        _profilePicture = profilePicture,
        _fullName = fullName,
        _handle = handle;

  ///
  factory FollowerInfo.fromJson(Map<String, dynamic> json) =>
      _$FollowerInfoFromJson(json);

  /// Get FollowerInfo from UserPersonalInfo
  factory FollowerInfo.fromUserPersonalInfo(
    UserPersonalInfo userPersonalInfo,
  ) =>
      FollowerInfo(
        id: userPersonalInfo.id,
        profilePicture: userPersonalInfo.profilePicture,
        fullName: userPersonalInfo.fullName,
        handle: userPersonalInfo.handle,
      );

  final String? _id;
  final String? _profilePicture;
  final String? _fullName;
  final String? _handle;

  ///
  @JsonKey(name: 'id', defaultValue: '')
  String? get id => _id;

  ///
  @JsonKey(name: 'profile_picture', defaultValue: '')
  String? get profilePicture => _profilePicture;

  ///
  @JsonKey(name: 'full_name', defaultValue: '')
  String? get fullName => _fullName;

  ///
  @JsonKey(name: 'handle', defaultValue: '')
  String? get handle => _handle;

  ///
  Map<String, dynamic> toJson() => _$FollowerInfoToJson(this);
}

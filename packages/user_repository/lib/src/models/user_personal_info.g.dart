// GENERATED CODE - DO NOT MODIFY BY HAND
//ignore_for_file: implicit_dynamic_parameter

part of 'user_personal_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPersonalInfo _$UserPersonalInfoFromJson(Map<String, dynamic> json) =>
    UserPersonalInfo(
      id: json['id'] as String? ?? '',
      profilePicture: json['profile_picture'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      banner: json['banner'] as String? ?? '',
      handle: json['handle'] as String? ?? '',
      description: json['description'] as String? ?? '',
      likes: json['likes'] as String? ?? '',
      followers: _getFollowers(json['followers']),
      followerCount: json['followerCount'] as int? ?? 0,
      following: _getFollowers(json['followers']),
      followingCount: json['followingCount'] as int? ?? 0,
      createdAt: _getParsedDate(json['created_at']),
      updatedAt: _getParsedDate(json['updated_at']),
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
    );

String _getParsedDate(dynamic object) {
  if (object == null || object == '') {
    return '';
  }

  return object.toString();
}

List<FollowerInfo> _getFollowers(dynamic object) {
  if (object == null || object == '') {
    return [];
  }

  List<dynamic>? objectList = <dynamic>[];
  if (object.runtimeType == String) {
    return [];
  } else {
    objectList = object as List<dynamic>?;
  }

  if (objectList == null || objectList.isEmpty) {
    return [];
  }

  return objectList
      .map((e) => FollowerInfo.fromJson(e as Map<String, dynamic>))
      .toList();
}

Map<String, dynamic> _$UserPersonalInfoToJson(UserPersonalInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profile_picture': instance.profilePicture,
      'full_name': instance.fullName,
      'banner': instance.banner,
      'handle': instance.handle,
      'description': instance.description,
      'likes': instance.likes,
      'followers': instance.followers,
      'followerCount': instance.followerCount,
      'following': instance.following,
      'followingCount': instance.followingCount,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
    };

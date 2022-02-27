// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowerInfo _$FollowerInfoFromJson(Map<String, dynamic> json) => FollowerInfo(
      id: json['id'] as String? ?? '',
      profilePicture: json['profile_picture'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      handle: json['handle'] as String? ?? '',
    );

Map<String, dynamic> _$FollowerInfoToJson(FollowerInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profile_picture': instance.profilePicture,
      'full_name': instance.fullName,
      'handle': instance.handle,
    };

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
      userName: json['user_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );

Map<String, dynamic> _$UserPersonalInfoToJson(UserPersonalInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profile_picture': instance.profilePicture,
      'full_name': instance.fullName,
      'user_name': instance.userName,
      'email': instance.email,
    };

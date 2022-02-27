import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_personal_info.g.dart';

@JsonSerializable()

/// All the information of a user
class UserPersonalInfo implements Equatable {
  ///
  const UserPersonalInfo({
    String? id,
    String? profilePicture,
    String? userName,
    String? fullName,
    String? email,
  })  : _id = id,
        _profilePicture = profilePicture,
        _userName = userName,
        _fullName = fullName,
        _email = email;
  ///
  factory UserPersonalInfo.fromJson(Map<String, dynamic> json) =>
      _$UserPersonalInfoFromJson(json);

  final String? _id;
  final String? _profilePicture;
  final String? _fullName;
  final String? _userName;
  final String? _email;

  /// Make a clone with new fields
  UserPersonalInfo copyWith({
    String? id,
    String? profilePicture,
    String? fullName,
    String? banner,
    String? userName,
    String? email,
  }) {
    return UserPersonalInfo(
      id: id ?? this.id,
      profilePicture: profilePicture ?? this.profilePicture,
      fullName: fullName ?? this.fullName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
    );
  }

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
  @JsonKey(name: 'user_name', defaultValue: '')
  String? get userName => _userName;

  ///
  @JsonKey(name: 'email', defaultValue: '')
  String? get email => _email;


  ///
  Map<String, dynamic> toJson() => _$UserPersonalInfoToJson(this);

  @override
  List<Object?> get props => [
        id,
        profilePicture,
        fullName,
        userName,
        email,
      ];

  @override
  bool? get stringify => throw UnimplementedError();
}

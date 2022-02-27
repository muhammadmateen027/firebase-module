import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_repository/user_repository.dart';

part 'user_personal_info.g.dart';

@JsonSerializable()

/// All the information of a user
class UserPersonalInfo implements Equatable {
  ///
  const UserPersonalInfo({
    String? id,
    String? profilePicture,
    String? fullName,
    String? banner,
    String? handle,
    String? description,
    String? likes,
    List<FollowerInfo> followers = const <FollowerInfo>[],
    int followerCount = 0,
    List<FollowerInfo> following = const <FollowerInfo>[],
    int followingCount = 0,
    String? createdAt,
    String? updatedAt,
    String? phoneNumber,
    String? email,
  })  : _id = id,
        _profilePicture = profilePicture,
        _fullName = fullName,
        _banner = banner,
        _handle = handle,
        _description = description,
        _likes = likes,
        _followers = followers,
        _followerCount = followerCount,
        _following = following,
        _followingCount = followingCount,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _email = email,
        _phoneNumber = phoneNumber;

  ///
  factory UserPersonalInfo.fromJson(Map<String, dynamic> json) =>
      _$UserPersonalInfoFromJson(json);

  final String? _id;
  final String? _profilePicture;
  final String? _fullName;
  final String? _banner;
  final String? _handle;
  final String? _description;
  final String? _likes;
  final List<FollowerInfo> _followers;
  final int _followerCount;
  final List<FollowerInfo> _following;
  final int _followingCount;
  final String? _updatedAt;
  final String? _createdAt;
  final String? _email;
  final String? _phoneNumber;

  /// Make a clone with new fields
  UserPersonalInfo copyWith({
    String? id,
    String? profilePicture,
    String? fullName,
    String? banner,
    String? handle,
    String? description,
    String? likes,
    List<FollowerInfo>? followers,
    int? followerCount,
    List<FollowerInfo>? following,
    int? followingCount,
    String? createdAt,
    String? updatedAt,
    String? phoneNumber,
    String? email,
  }) {
    return UserPersonalInfo(
      id: id ?? this.id,
      profilePicture: profilePicture ?? this.profilePicture,
      fullName: fullName ?? this.fullName,
      banner: banner ?? this.banner,
      handle: handle ?? this.handle,
      description: description ?? this.description,
      likes: likes ?? this.likes,
      followers: followers ?? this.followers,
      followerCount: followerCount ?? this.followerCount,
      following: following ?? this.following,
      followingCount: followingCount ?? this.followingCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
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
  @JsonKey(name: 'banner', defaultValue: '')
  String? get banner => _banner;

  ///
  @JsonKey(name: 'handle', defaultValue: '')
  String? get handle => _handle;

  ///
  @JsonKey(name: 'description', defaultValue: '')
  String? get description => _description;

  ///
  @JsonKey(name: 'likes', defaultValue: '')
  String? get likes => _likes;

  ///
  @JsonKey(name: 'followers', defaultValue: <FollowerInfo>[])
  List<FollowerInfo> get followers => _followers;

  /// The size of the followers list
  @JsonKey(name: 'followerCount', defaultValue: 0)
  int get followerCount => _followerCount;

  ///
  @JsonKey(name: 'following', defaultValue: <FollowerInfo>[])
  List<FollowerInfo> get following => _following;

  /// The size of the following list
  @JsonKey(name: 'followingCount', defaultValue: 0)
  int get followingCount => _followingCount;

  ///
  @JsonKey(name: 'created_at', defaultValue: '')
  String? get createdAt => _createdAt;

  ///
  @JsonKey(name: 'updated_at', defaultValue: '')
  String? get updatedAt => _updatedAt;

  ///
  @JsonKey(name: 'email', defaultValue: '')
  String? get email => _email;

  ///
  @JsonKey(name: 'phoneNumber', defaultValue: '')
  String? get phoneNumber => _phoneNumber;

  ///
  Map<String, dynamic> toJson() => _$UserPersonalInfoToJson(this);

  @override
  List<Object?> get props => [
        id,
        profilePicture,
        fullName,
        handle,
        description,
        likes,
        followers,
        followerCount,
        following,
        followingCount,
        createdAt,
        updatedAt,
        email,
        phoneNumber,
      ];

  @override
  bool? get stringify => throw UnimplementedError();
}

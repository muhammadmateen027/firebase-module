import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

/// Report reasons
enum ReportReason {
  /// Unset
  @JsonValue('unset')
  unset,

  /// Suspicious or Spam
  @JsonValue('spam')
  spam,

  /// Contains abusive or hateful information
  @JsonValue('abuse')
  abuse,

  /// Pretending to be me or someone else
  @JsonValue('identityStealing')
  identityStealing,

  /// Inappropriate content
  @JsonValue('inappropriate')
  inappropriate,
}

/// Report type
enum ReportType {
  /// Unset
  @JsonValue('unset')
  unset,

  /// Profile report
  @JsonValue('profile')
  profile,

  /// Comment report
  @JsonValue('comment')
  comment,

  /// Post report
  @JsonValue('post')
  post,
}

/// Report entity
@JsonSerializable()
class Report {
  /// Report entity
  const Report({
    required ReportReason reason,
    required String description,
    required DateTime createdAt,
    required ReportType type,
    required String reportedContentPoster,
    required String reportedContentId,
  })  : _reason = reason,
        _description = description,
        _createdAt = createdAt,
        _type = type,
        _reportedContentPoster = reportedContentPoster,
        _reportedContentId = reportedContentId;

  /// From json report constructor
  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  final ReportReason _reason;
  final String _description;
  final DateTime _createdAt;
  final ReportType _type;
  final String _reportedContentPoster;
  final String _reportedContentId;

  /// Report reason
  @JsonKey(name: 'reason', defaultValue: ReportReason.unset)
  ReportReason get reason => _reason;

  /// Report description
  @JsonKey(name: 'description', defaultValue: '')
  String get description => _description;

  /// Report creation date
  @JsonKey(
    name: 'created_at',
    toJson: _timestampToJson,
    fromJson: _timestampFromJson,
  )
  DateTime get createdAt => _createdAt;

  /// Report type
  @JsonKey(name: 'report_type', defaultValue: ReportType.unset)
  ReportType get type => _type;

  /// Reported content poster
  @JsonKey(name: 'reported_content_poster', defaultValue: '')
  String get reportedContentPoster => _reportedContentPoster;

  /// Reported content id
  /// Will be the same as reportedContentPoster if report type == profile
  @JsonKey(name: 'reported_content_id', defaultValue: '')
  String get reportedContentId => _reportedContentId;

  /// Return a json containing the report data
  Map<String, dynamic> toJson() => _$ReportToJson(this);

  static DateTime _timestampFromJson(Timestamp timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);

  static Timestamp _timestampToJson(DateTime date) => Timestamp.fromDate(date);
}

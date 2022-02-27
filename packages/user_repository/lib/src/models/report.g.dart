// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      reason: $enumDecodeNullable(_$ReportReasonEnumMap, json['reason']) ??
          ReportReason.unset,
      description: json['description'] as String? ?? '',
      createdAt: Report._timestampFromJson(json['created_at'] as Timestamp),
      type: $enumDecodeNullable(_$ReportTypeEnumMap, json['report_type']) ??
          ReportType.unset,
      reportedContentPoster: json['reported_content_poster'] as String? ?? '',
      reportedContentId: json['reported_content_id'] as String? ?? '',
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'reason': _$ReportReasonEnumMap[instance.reason],
      'description': instance.description,
      'created_at': Report._timestampToJson(instance.createdAt),
      'report_type': _$ReportTypeEnumMap[instance.type],
      'reported_content_poster': instance.reportedContentPoster,
      'reported_content_id': instance.reportedContentId,
    };

const _$ReportReasonEnumMap = {
  ReportReason.unset: 'unset',
  ReportReason.spam: 'spam',
  ReportReason.abuse: 'abuse',
  ReportReason.identityStealing: 'identityStealing',
  ReportReason.inappropriate: 'inappropriate',
};

const _$ReportTypeEnumMap = {
  ReportType.unset: 'unset',
  ReportType.profile: 'profile',
  ReportType.comment: 'comment',
  ReportType.post: 'post',
};

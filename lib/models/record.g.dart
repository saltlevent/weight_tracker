// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Record _$RecordFromJson(Map<String, dynamic> json) => Record(
      weight: json['weight'] as int,
      dateTime: DateTime.parse(json['dateTime'] as String),
      note: json['note'] as String?,
      photoPath: json['photoPath'] as String?,
    );

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'weight': instance.weight,
      'dateTime': instance.dateTime.toIso8601String(),
      'note': instance.note,
      'photoPath': instance.photoPath,
    };

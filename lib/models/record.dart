import 'package:json_annotation/json_annotation.dart';

part 'record.g.dart';

@JsonSerializable()
class Record{
      final int weight;
      final DateTime dateTime;
      String? note;
      String? photoPath;

      Record({
        required this.weight,
        required this.dateTime,
        this.note,
        this.photoPath
      });

      factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

      Map<String, dynamic> toJson() => _$RecordToJson(this);

}
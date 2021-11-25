import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel{
  final String email;
  final String userName;
  String? photoPath;
  String? data;

  UserModel({
    required this.email,
    required this.userName,
    this.photoPath,
    this.data
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}
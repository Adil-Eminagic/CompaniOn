import 'package:companion_mobile/models/users.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aiConversation.g.dart';

@JsonSerializable(explicitToJson: true)
class AiConversation{
  Users? user;
  int? userId;
  String? question;
  String? response;
  String? sentimentAnalysis;
  DateTime? timestamp;
  int? id; 
  DateTime? createdAt;
  DateTime? modifiedAt;

  AiConversation(this.user, this.userId, this.question, this.response, this.sentimentAnalysis, this.timestamp, this.id, this.createdAt, this.modifiedAt);
  factory AiConversation.fromJson(Map<String, dynamic> json) => _$AiConversationFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AiConversationToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'aiConversationUpdate.g.dart';

@JsonSerializable(explicitToJson: true)
class AiConversationUpdate{
  int? id; 
  int? userId;
  String? question;
  String? response;
  String? sentimentAnalysis;
  DateTime? timestamp;

  AiConversationUpdate(this.userId, this.question, this.response, this.sentimentAnalysis, this.timestamp, this.id);
  factory AiConversationUpdate.fromJson(Map<String, dynamic> json) => _$AiConversationUpdateFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AiConversationUpdateToJson(this);
}
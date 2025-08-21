import 'package:json_annotation/json_annotation.dart';

part 'aiConversationInsert.g.dart';

@JsonSerializable(explicitToJson: true)
class AiConversationInsert{
  int? id; 
  int? userId;
  String? question;
  String? response;
  String? sentimentAnalysis;
  DateTime? timestamp;

  AiConversationInsert(this.userId, this.question, this.response, this.sentimentAnalysis, this.timestamp, this.id);
  factory AiConversationInsert.fromJson(Map<String, dynamic> json) => _$AiConversationInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AiConversationInsertToJson(this);
}
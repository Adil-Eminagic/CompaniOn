import 'package:json_annotation/json_annotation.dart';

part 'reminderInsert.g.dart';

@JsonSerializable()
class ReminderInsert{
  int? id; 
  final int userId;
  final String type;
  final String message;
  final DateTime time;
  final bool repeat;
  final bool isAcknowledged;

  // Constructor
  ReminderInsert({
    required this.id,
    required this.userId,
    required this.type,
    required this.message,
    required this.time,
    required this.repeat,
    required this.isAcknowledged
  });

  factory ReminderInsert.fromJson(Map<String, dynamic> json) => _$ReminderInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ReminderInsertToJson(this);
}
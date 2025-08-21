import 'package:json_annotation/json_annotation.dart';

part 'reminder.g.dart';

@JsonSerializable()
class Reminder {
  final int id;
  final int userId;
  final String type;
  final String message;
  final DateTime time;
  final bool repeat;
  bool isAcknowledged;

  // Constructor
  Reminder({
    required this.id,
    required this.userId,
    required this.type,
    required this.message,
    required this.time,
    required this.repeat,
    required this.isAcknowledged
  });

  // Generirane metode za JSON (fromJson i toJson)
  factory Reminder.fromJson(Map<String, dynamic> json) => _$ReminderFromJson(json);
  Map<String, dynamic> toJson() => _$ReminderToJson(this);
}

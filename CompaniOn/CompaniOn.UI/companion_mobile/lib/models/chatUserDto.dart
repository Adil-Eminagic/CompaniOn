import 'package:json_annotation/json_annotation.dart';

part 'chatUserDto.g.dart';

@JsonSerializable()
class ChatUserDto {
  final int userId;
  final String otherUserName;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final bool hasNewMessages;
  final int unreadCount;

  ChatUserDto(
    this.userId,
    this.otherUserName,
    this.lastMessage,
    this.lastMessageTime,
    this.hasNewMessages,
    this.unreadCount,
  );

  factory ChatUserDto.fromJson(Map<String, dynamic> json) =>
      _$ChatUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatUserDtoToJson(this);
}

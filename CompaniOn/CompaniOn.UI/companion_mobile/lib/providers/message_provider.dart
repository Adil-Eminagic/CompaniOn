import 'dart:convert';
import 'package:companion_mobile/models/chatUserDto.dart';
import 'package:companion_mobile/models/message.dart';
import 'package:companion_mobile/providers/base_provider.dart';
import 'package:http/http.dart';

class MessageProvider extends BaseProvider<Message> {
  MessageProvider() : super("Message");

  @override
  Message fromJson(data) {
    return Message.fromJson(data);
  }

  Future<List<ChatUserDto>> getChatUsers(int userId) async {
    var url = "${BaseProvider.baseUrl}api/$endpoint/chat-user-ids/$userId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    Response response = await get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      List<ChatUserDto> chatUsers = [];
      for (var u in data) {
        chatUsers.add(ChatUserDto.fromJson(u));
      }

      return chatUsers;
    } else {
      throw Exception("Failed to load chat users. Please try again.");
    }
  }

  Future<List<Message>> getMessagesBetweenUsers(
      int userId1, int userId2) async {
    var url =
        "${BaseProvider.baseUrl}api/$endpoint/conversation?userId1=$userId1&userId2=$userId2";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    Response response = await get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      List<Message> messages = [];
      for (var m in data) {
        messages.add(Message.fromJson(m));
      }

      return messages;
    } else {
      throw Exception("Failed to load messages. Please try again.");
    }
  }
}

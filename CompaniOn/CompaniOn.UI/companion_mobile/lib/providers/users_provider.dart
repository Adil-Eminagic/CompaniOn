import 'dart:convert';

import 'package:companion_mobile/models/users.dart';
import 'package:companion_mobile/providers/base_provider.dart';
import 'package:http/http.dart';

class UsersProvider extends BaseProvider<Users> {
  UsersProvider() : super("Users");

  @override
  Users fromJson(data) {
    return Users.fromJson(data);
  }

  Future<dynamic> changeEmail(int userId, String email) async {
    var url = "${BaseProvider.baseUrl}api/$endpoint/$userId";

    var uri = Uri.parse(url);

    List<Map<String, dynamic>> patchRequest = [
      {"op": "replace", "path": "/email", "value": email}
    ];
    var jsonRequest = jsonEncode(patchRequest);
    var headers = createHeaders();

    Response response = await patch(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      var result = data;

      return result;
    } else {
      throw Exception("Failed to update email. Please try again.");
    }
  }

  Future<dynamic> changePassword(dynamic object) async {
    var url = "${BaseProvider.baseUrl}api/$endpoint/ChangePassword";

    var uri = Uri.parse(url);

    var jsonRequest = jsonEncode(object);
    var headers = createHeaders();

    Response response = await put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
    } else {
      throw Exception("Failed to change password. Please try again.");
    }
  }

  Future<List<Users>> getBasicUsers(int userId) async {
    var url = "${BaseProvider.baseUrl}api/$endpoint/GetBasicUsers/$userId";

    var uri = Uri.parse(url);

    var headers = createHeaders();

    Response response = await get(uri, headers: headers);
    print(response.body);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      List<Users> users = [];
      for (var u in data) {
        users.add(Users.fromJson(u));
      }

      return users;
    } else {
      throw Exception("Failed to retrieve basic user. Please try again.");
    }
  }

  Future<void> updateVisibility(int userId, bool isVisible) async {
    var url = "${BaseProvider.baseUrl}api/$endpoint/$userId";
    var uri = Uri.parse(url);

    List<Map<String, dynamic>> patchRequest = [
      {"op": "replace", "path": "/isVisibleToOthers", "value": isVisible}
    ];
    var jsonRequest = jsonEncode(patchRequest);
    var headers = createHeaders();

    Response response = await patch(uri, headers: headers, body: jsonRequest);

    if (!isValidResponse(response)) {
      throw Exception("Failed to update visibility.");
    }
  }
}

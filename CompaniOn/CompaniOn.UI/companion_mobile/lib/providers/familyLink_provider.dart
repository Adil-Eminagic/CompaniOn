import 'dart:convert';
import 'package:companion_mobile/models/familyLink.dart';
import 'package:companion_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class FamilyLinkProvider extends BaseProvider<FamilyLink> {
  FamilyLinkProvider() : super("FamilyLink");

  @override
  FamilyLink fromJson(data) {
    return FamilyLink.fromJson(data);
  }

  Future<List<FamilyLink>> getByFamilyMembeId(int userId) async {
    var url = "${BaseProvider.baseUrl}api/$endpoint/GetByFamilyMemberId/$userId";

    var uri = Uri.parse(url);

    var headers = createHeaders();

    http.Response response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      List<FamilyLink> familyLinks = [];

      for (var u in data) {
        familyLinks.add(FamilyLink.fromJson(u));
      }

      return familyLinks;
    } else {
      throw Exception(
          "Failed to retrieve family links. Please check the user ID and try again.");
    }
  }

  Future<List<FamilyLink>> getByUserId(int userId) async {
    var url = "${BaseProvider.baseUrl}api/$endpoint/GetByUserId/$userId";

    var uri = Uri.parse(url);

    var headers = createHeaders();

    http.Response response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      List<FamilyLink> familyLinks = [];

      for (var u in data) {
        familyLinks.add(FamilyLink.fromJson(u));
      }

      return familyLinks;
    } else {
      throw Exception(
          "Failed to retrieve family links. Please check the user ID and try again.");
    }
  }
}

import 'dart:convert';

import 'package:companion_mobile/models/location.dart';
import 'package:companion_mobile/models/photos.dart';
import 'package:companion_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class LocationProvider extends BaseProvider<Location> {
  LocationProvider() : super("Location");

  @override
  Location fromJson(data) {
    return Location.fromJson(data);
  }

  Future<Location?> getLastByUserId(int userId) async {
    var url = "${BaseProvider.baseUrl}api/$endpoint/GetLastByUserId/$userId";

    var uri = Uri.parse(url);

    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 204) {
      return null;
    }

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw new Exception("Unknown error");
    }
  }
}

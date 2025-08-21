import 'dart:convert';
import 'package:companion_mobile/models/search_result.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  static String? baseUrl;
  String endpoint = "";
  String defUrl = "http://10.0.2.2:5208/";
  // String defUrl = "http://192.168.0.28:5000/";


  BaseProvider(String point) {
    endpoint = point;
    baseUrl =  String.fromEnvironment("baseUrl",
        defaultValue: defUrl);
  }

  Future<SearchResult<T>> getPaged({dynamic filter}) async {
    var url = "${baseUrl}api/$endpoint/GetPaged";

    if (filter != null) {
      var querryString = getQueryString(filter);
      url = "$url?$querryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      var result = SearchResult<T>();

      result.hasNextPage = data['hasNextPage'];
      result.pageNumber = data['pageNumber'];
      result.pageSize = data['pageSize'];
      result.pageCount = data['pageCount'];
      result.totalCount = data['totalCount'];
      result.hasPreviousPage = data['hasPreviousPage'];
      result.isFirstPage = data['isFirstPage'];
      result.isLastPage = data['isLastPage'];

      for (var item in data['items']) {
        result.items.add(fromJson(item));
      }

      return result;
    } else {
      throw new Exception("Upps, something went wrong");
    }
  }

  Future<T> getById(int id) async {
    var url = "${baseUrl}api/$endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw new Exception(
          "Failed to retrieve data. Please check the provided ID and try again.");
    }
  }

  Future<T> getLastEntry(int id) async {
    var url = "${baseUrl}api/$endpoint/GetLastEntry?id=$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw new Exception("Unknown error");
    }
  }

  Future<T> insert(dynamic request) async {
    var url = "${baseUrl}api/$endpoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Failed to insert data. Please try again.");
    }
  }

  T fromJson(data) {
    throw Exception("Method not implemented");
  }

  Future<T> update([dynamic request]) async {
    var url = "${baseUrl}api/$endpoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw new Exception("Failed to update data. Please try again.");
    }
  }

  Future<bool> delete(int id) async {
    var url = "${baseUrl}api/$endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.delete(uri, headers: headers);

    if (isValidResponse(response)) {
      return true;
    } else {
      throw new Exception("Failed to delete data. Please try again.");
    }
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw new Exception("Unauthorised");
    } else {
      throw new Exception("Upps, something went wrong");
    }
  }

  Map<String, String> createHeaders() {
    String jwt = Autentification.token ?? '';

    String jwtAuth = "Bearer $jwt";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": jwtAuth
    };

    return headers;
  }

  String getQueryString(Map params,
      {String prefix = '&', bool inRecursion = false}) {
    String query = '';
    params.forEach((key, value) {
      if (inRecursion) {
        if (key is int) {
          key = '[$key]';
        } else if (value is List || value is Map) {
          key = '.$key';
        } else {
          key = '.$key';
        }
      }
      if (value is String || value is int || value is double || value is bool) {
        var encoded = value;
        if (value is String) {
          encoded = Uri.encodeComponent(value);
        }
        query += '$prefix$key=$encoded';
      } else if (value is DateTime) {
        query += '$prefix$key=${(value).toIso8601String()}';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return query;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:companion_mobile/providers/sign_provide.dart';

class SignProvider extends ChangeNotifier {
  static String? baseUrl;
  String endpoint = "api/Access/SignIn";
  String defUrl = "http://10.0.2.2:5208/";
  // String defUrl = "http://192.168.0.28:5000/";

  SignProvider() {
    baseUrl = String.fromEnvironment("baseUrl",
        defaultValue: defUrl);
  }

  Future<dynamic> signIn(String em, String ps) async {
    endpoint = "api/Access/SignIn";
    var url = "$baseUrl$endpoint";

    var uri = Uri.parse(url);
    var jsonRequest = jsonEncode({'email': em, 'password': ps});

    Response response = await post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonRequest);

    if (await isValidResponse(response)) {
      var data = jsonDecode(response.body);

      var result = data;

      return result;
    } else {
      throw Exception(
          "Sign-in failed. Please check your email and password and try again.");
    }
  }

  Future<dynamic> signUp(dynamic object) async {
    endpoint = "api/Access/SignUp";
    var url = "$baseUrl$endpoint";

    var uri = Uri.parse(url);

    var jsonRequest = jsonEncode(object);

    Response response = await post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonRequest);
    // Check for empty response body
    if (response.body.isEmpty) {
      throw Exception("Empty response from the server.");
    }

    // Debugging: Print the response
    print("Response body: ${response.body}");

    if (isValidResponse(response)) {
    } else {
      throw Exception(
          "Registration failed. Please check your details and try again.");
    }
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("Your session has expired. Please log in again.");
    } else {
      throw Exception(
          "An error occurred while processing your request., Status code: ${response.statusCode}");
    }
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

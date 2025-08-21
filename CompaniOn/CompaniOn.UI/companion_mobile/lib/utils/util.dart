import 'dart:convert';

import 'package:companion_mobile/models/users.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Authorization {
  static String? email;
  static String? password;
}

class Autentification {
  static String? token;
  static Map? tokenDecoded;
}

Users? loggedUser;

dynamic dateEncode(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}

const String mfield = "Field is mandatory";


// Image imageFromBase64String(String base64Image) {
//   return Image.memory(
//     base64Decode(base64Image),
//     height: 250,
//     width: 250,
//   );
// }

// ButtonStyle buttonStyleSecondary = ElevatedButton.styleFrom(
//     primary: Colors.brown[100], onPrimary: Colors.black);

class Info {
  static String? name;
  static String? surname;
  static String? image;
  static int? id;
}

Image imageFromBase64String(String base64Image) {
  return Image.memory(base64Decode(base64Image));
}

String formatNumber(dynamic) {
  var f = NumberFormat('###,00');

  if (dynamic == null) {
    return "";
  }

  return f.format(dynamic);
}

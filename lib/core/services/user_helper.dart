import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';

class UserHelper {
  /// Hashing password
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Membuat nama depan jadi huruf kapital
  static String titleMaker(String title) {
    final listTitle = title.split(' ');
    String newTitle = '';
    for (var t in listTitle) {
      newTitle += "${t[0].toUpperCase()}${t.substring(1, t.length)} ";
    }
    return newTitle.trim();
  }

  /// membuat nama panggilan dari nama lengkap
  static String nicknameGenerator(String fullname) {
    final listName = fullname.trim().split(' ');
    if (listName.length <= 1) {
      return fullname;
    } else {
      return listName[1];
    }
  }
}

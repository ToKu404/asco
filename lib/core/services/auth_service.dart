import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';

class AuthService {
  static const nowPasswordTemp =
      '186cf774c97b60a1c106ef718d10970a6a06e06bef89553d9ae65d938a886eae';

  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}

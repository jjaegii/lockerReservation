import 'package:crypto/crypto.dart';
import 'dart:convert';

String pwHashing(String pw) {
  var bytesToHash = utf8.encode(pw);
  var hashedPw = sha256.convert(bytesToHash);
  return hashedPw.toString();
}

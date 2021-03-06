import 'dart:io';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences prefs;

  static encrypt.Encrypter encrypter;

  static encrypt.IV iv;

  static bool get isSupport =>
      kIsWeb ||
      Platform.isIOS ||
      Platform.isAndroid ||
      Platform.isMacOS ||
      Platform.isLinux ||
      Platform.isWindows;

  static Future<SharedPreferences> init({
    @required encrypt.Key key,
    @required encrypt.IV iv,
  }) async {
    if (isSupport) {
      prefs = await SharedPreferences.getInstance();
      encrypter = encrypt.Encrypter(
        encrypt.AES(
          key,
          mode: encrypt.AESMode.cbc,
        ),
      );
      Preferences.iv = iv;
    }
    return prefs;
  }

  static Future<void> setString(String key, String data) async {
    await prefs?.setString(key, data);
  }

  static String getString(String key, String defaultValue) {
    return prefs?.getString(key) ?? defaultValue;
  }

  static Future<void> setStringSecurity(String key, String data) async {
    await prefs?.setString(
      key,
      encrypter.encrypt(data, iv: iv).base64,
    );
  }

  static String getStringSecurity(String key, String defaultValue) {
    final String data = prefs?.getString(key) ?? '';
    if (data == '') {
      return defaultValue;
    } else {
      return encrypter.decrypt64(data, iv: iv);
    }
  }

  static Future<void> setInt(String key, int data) async {
    await prefs?.setInt(key, data);
  }

  static int getInt(String key, int defaultValue) {
    return prefs?.getInt(key) ?? defaultValue;
  }

  static Future<void> setDouble(String key, double data) async {
    await prefs?.setDouble(key, data);
  }

  static double getDouble(String key, double defaultValue) {
    return prefs?.getDouble(key) ?? defaultValue;
  }

  // ignore: avoid_positional_boolean_parameters
  static Future<void> setBool(String key, bool data) async {
    await prefs?.setBool(key, data);
  }

  // ignore: avoid_positional_boolean_parameters
  static bool getBool(String key, bool defaultValue) {
    return prefs?.getBool(key) ?? defaultValue;
  }

  static Future<void> setStringList(String key, List<String> data) async {
    await prefs?.setStringList(key, data);
  }

  static List<String> getStringList(String key, List<String> defaultValue) {
    return prefs?.getStringList(key) ?? defaultValue;
  }

  static Future<bool> remove(String key) {
    return prefs?.remove(key);
  }
}

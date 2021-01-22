import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Store {
  static String key = "com.awesome.ilock";
  static final storage = new FlutterSecureStorage();

  static read(String key) async {
    String value = await storage.read(key: key);
    return value;
  }

  static readAll() async {
    Map<String, String> allValues = await storage.readAll();
    return allValues;
  }

  static save(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static remove(String key) async {
    await storage.delete(key: key);
    // await storage.deleteAll();
  }
}

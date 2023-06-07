import 'package:car_accident_management/datamodel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class TokenService {
  final storage = FlutterSecureStorage();
  Future<bool> hasToken() async{

    String? token = await storage.read(key: 'token');
    return token != null;

  }
  Future<void> writeTokenUser(String token, returenData user) async{
    final jsonString = jsonEncode(user.toJson());
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'user', value: jsonString);

  }

  Future<String?> readToken() async{
    String? token = await storage.read(key: 'token');
    return token;
  }

  Future<returenData?> readUser() async{
    final jsonString = await storage.read(key: 'user');
    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);
      return returenData.fromJson(jsonMap);
    }
    return null;
  }

  Future<void> removeTokenUser() async{
    await storage.delete(key: 'token');
    await storage.delete(key: 'user');
  }

}
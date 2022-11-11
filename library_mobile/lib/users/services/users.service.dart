// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:library_mobile/shared/constants/server.constant.dart';
import 'package:library_mobile/shared/secure_storage.service.dart';
import 'package:library_mobile/users/models/user.model.dart';

class UsersService {
  static const _baseUrl = SERVER_URL;
  final SecureStorageService _storageService = SecureStorageService();

  Future<List<Users>> getAllUsers() async {
    final response = await http.get(Uri.parse('$_baseUrl/users/'));

    List<dynamic> _resp = jsonDecode(response.body);
    var _data = (_resp.map((e) => Users.fromMap(e as Map<String, dynamic>)))
        .toList()
        .cast<Users>();
    return _data;
  }

  Future<Users> getUsersById(int id) async {
    String? _accessToken = await _storageService.readSecureData(SECURE_KEY);
    final String _body = json.encode(id);
    var res = await http
        .get(Uri.parse('$_baseUrl/users/$id'),
        headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_accessToken',
        });
    Map<String, dynamic> _resp = jsonDecode(res.body);
    var _data = Users.fromMap(_resp);
    return _data;
  }

  Future<Users> getUsersProfile() async {
    String? _accessToken = await _storageService.readSecureData(SECURE_KEY);
    var res = await http
        .get(Uri.parse('$_baseUrl/auth/status'), 
        headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_accessToken',
        });
    Map<String, dynamic> _resp = jsonDecode(res.body);
    var _data = Users.fromMap(_resp);
    return _data;
  }

  Future<Users> updateUsers(Users user) async {
    String? _accessToken = await _storageService.readSecureData(SECURE_KEY);
    var res = await http.patch(Uri.parse('$_baseUrl/users/'),
        body: jsonEncode(user),
        headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_accessToken',
        });
    Map<String, dynamic> _resp = jsonDecode(res.body);
    var _data = Users.fromMap(_resp);
    return _data;
  }

  Future<void> deleteUsers(int id) async {
    String? _accessToken = await _storageService.readSecureData(SECURE_KEY);
    var res = await http
        .delete(Uri.parse('$_baseUrl/users/$id'), 
        headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_accessToken',
        });
    Map<String, dynamic> _resp = jsonDecode(res.body);
    Users.fromMap(_resp);
  }
}

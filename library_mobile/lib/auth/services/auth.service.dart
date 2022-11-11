// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_mobile/auth/models/login.model.dart';
import 'package:library_mobile/auth/models/login.response.dart';
import 'package:library_mobile/auth/models/register.model.dart';
import 'package:library_mobile/shared/constants/server.constant.dart';
import 'package:library_mobile/shared/secure_storage.service.dart';
import 'package:library_mobile/users/models/user.model.dart';

SnackBar alertSnackbar(String message) {
  return SnackBar(
    content: Text(message),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {},
    ),
  );
}

class AuthService {
  static const _baseUrl = SERVER_URL;

  final SecureStorageService _storageService = SecureStorageService();

  Future<int?> getCurrentUser() async {
    String? currentUser = await _storageService.readSecureData(CURRENT_USER);
    late int? userId;
    if (currentUser.isNotEmpty) {
      userId = int.parse(currentUser);
    } else {
      userId = null;
    }
    return userId;
  }


   Future<void> logoutUser() async {
     await _storageService.deleteSecureData(SECURE_KEY);
     await _storageService.deleteSecureData(CURRENT_USER);
     
  }

  Future<LoginResponseDto> loginUser(LoginUserDto loginDto) async {
    final String _body = json.encode(loginDto);
    var res = await http.post(Uri.parse('$_baseUrl/auth/login/'),
        body: _body,
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    if (res.statusCode == 400) {
      dynamic message = jsonDecode(res.body);
      alertSnackbar(message.message);
    } else if (res.statusCode == 500) {
      dynamic message = jsonDecode(res.body);
      alertSnackbar(message.message);
    } else {
      Map<String, dynamic> _resp = jsonDecode(res.body);
      var _data = LoginResponseDto.fromMap(_resp);
      _storageService.writeSecureData(SECURE_KEY, _data.accessToken);
      _storageService.writeSecureData(CURRENT_USER, _data.user.id.toString());
      return _data;
    }
    throw const HttpException('Generic Error');
  }

  Future<Users> registerUser(RegisterUserDto registerDto) async {
    final String _body = json.encode(registerDto);
    var res = await http.post(Uri.parse('$_baseUrl/auth/register/'),
        body: _body,
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    if (res.statusCode == 400) {
      dynamic message = jsonDecode(res.body);
      alertSnackbar(message.message);
    } else if (res.statusCode == 500) {
      dynamic message = jsonDecode(res.body);
      alertSnackbar(message.message);
    } else {
      Map<String, dynamic> _resp = jsonDecode(res.body);
      var _data = Users.fromMap(_resp);
      return _data;
    }
    throw const HttpException('Generic Error');
  }
}

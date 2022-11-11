// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:library_mobile/books/models/books.dto.dart';
import 'package:library_mobile/books/models/books.model.dart';
import 'package:library_mobile/shared/constants/server.constant.dart';
import 'package:library_mobile/shared/secure_storage.service.dart';

class BooksService {
  static const _baseUrl = SERVER_URL;
  final SecureStorageService _storageService = SecureStorageService();
  Future<List<Books>> getAllBooks() async {
    final response = await http.get(Uri.parse('$_baseUrl/books/'));

    List<dynamic> _resp = jsonDecode(response.body);
    var _data = (_resp.map((e) => Books.fromMap(e as Map<String, dynamic>)))
        .toList()
        .cast<Books>();
    return _data;
  }

  Future<Books> getBooksById(int id) async {
    String? _accessToken = await _storageService.readSecureData(SECURE_KEY);
    final String _body = json.encode(id);
    var res = await http
        .get(Uri.parse('$_baseUrl/books/$id'), headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_accessToken',
    });
    Map<String, dynamic> _resp = jsonDecode(res.body);
    var _data = Books.fromMap(_resp);
    return _data;
  }

  Future<List<Books>> getCurrentUserBooks() async {
    String? _accessToken = await _storageService.readSecureData(SECURE_KEY);
    var res = await http
        .get(Uri.parse('$_baseUrl/books/page/data'), headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_accessToken',
    });
    List<dynamic> _resp = jsonDecode(res.body);
    var _data = (_resp.map((e) => Books.fromMap(e as Map<String, dynamic>)))
        .toList()
        .cast<Books>();
    return _data;
  }

  Future<List<Books>> getUserBooksById(int id) async {
    String? _accessToken = await _storageService.readSecureData(SECURE_KEY);
    final String _body = json.encode(id);
    var res = await http
        .get(Uri.parse('$_baseUrl/books/author/$id'), headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_accessToken',
    });
    List<dynamic> _resp = jsonDecode(res.body);

    var _data = (_resp.map((e) => Books.fromMap(e as Map<String, dynamic>)))
        .toList()
        .cast<Books>();
    return _data;
  }

  Future<Books> createBook(BookDto book) async {
    String? _accessToken = await _storageService.readSecureData(SECURE_KEY);
    var res = await http.post(Uri.parse('$_baseUrl/books'),
        body: jsonEncode(
          <String, String>{
            "title": book.title,
            "description": book.description,
            "public": book.public.toString(),
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_accessToken',
        });
    Map<String, dynamic> _resp = jsonDecode(res.body);
    var _data = Books.fromMap(_resp);
    return _data;
  }

  Future<Books> updateBooks(BookDto book) async {
    String? _accessToken = await _storageService.readSecureData(SECURE_KEY);
    final String _body = json.encode(book);
    var res = await http.patch(Uri.parse('$_baseUrl/books/'),
        body: jsonEncode(
          <String, String>{
            "id": book.id.toString(),
            "title": book.title,
            "description": book.description,
            "public": book.public.toString(),
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_accessToken',
        });
    Map<String, dynamic> _resp = jsonDecode(res.body);
    var _data = Books.fromMap(_resp);
    return _data;
  }

  Future<void> deleteBooks(int id) async {
    String? _accessToken = await _storageService.readSecureData(SECURE_KEY);
    var res = await http
        .delete(Uri.parse('$_baseUrl/books/$id'), headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_accessToken',
    });
    jsonDecode(res.body);
  }
}

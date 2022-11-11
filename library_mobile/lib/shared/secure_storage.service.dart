import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _secureStorage = const FlutterSecureStorage();

  Future<void> writeSecureData(String key, String item) async {
    await _secureStorage.write(key: key, value: item);
  }

  Future<String> readSecureData(String key) async {
    var readData = await _secureStorage.read(key: key);
    if(readData != null){
      return readData;
    }else {
      return '';
    };
  }

  Future<void> deleteSecureData(String item) async {
    await _secureStorage.delete(key: item);
  }
}

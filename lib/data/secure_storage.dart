import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageFrave {
  final secureStorage = FlutterSecureStorage();

  Future<void> userToken(String token) async {
    await secureStorage.write(key: 'bearer', value: token);
  }

  Future<String?> readUserToken() async {
    return await secureStorage.read(key: 'bearer');
  }

  Future<void> persistenToken(String token) async {
    await secureStorage.write(key: 'token', value: token);
  }

  Future<String?> readToken() async {
    return await secureStorage.read(key: 'token');
  }

  Future<void> deleteToken() async {
    await secureStorage.delete(key: 'token');
  }

  Future<void> persistenCartId(String token) async {
    await secureStorage.write(key: 'CartId', value: token);
  }

  Future<String?> readCartId() async {
    return await secureStorage.read(key: 'CartId');
  }

  Future<void> deleteCartId() async {
    await secureStorage.delete(key: 'CartId');
  }
}

final secureStorage = SecureStorageFrave();

import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  final _key =
      encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1'); // 32 bytes key
  final _iv = encrypt.IV.fromLength(16); // 16 bytes IV

  String encryptData(String data) {
    final crypto = encrypt.Encrypter(encrypt.AES(_key));
    final encrypted = crypto.encrypt(data, iv: _iv);
    return encrypted.base64;
  }

  String decryptData(String encryptedData) {
    final crypto = encrypt.Encrypter(encrypt.AES(_key));
    final decrypted = crypto.decrypt64(encryptedData, iv: _iv);
    return decrypted;
  }
}

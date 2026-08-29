//In this section we build the machine responsable for configure the our secure storage.
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  const SecureStorage();

  final _secureStorage = const FlutterSecureStorage();

                          // save the user data throut the firebase when the user do the signUp.
                                             // them move on to de home screen.
  Future<void> write({required String key, required String value}) async {
    await _secureStorage.write(
      key: key,
      value: value,
    );
  }
                                              //Secure metodes definitions
  Future<String?> readOne({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  Future<Map<String, String>> readAll() async {
    return await _secureStorage.readAll();
  }

  Future<void> deleteOne({required String key}) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }
} 
                                        //now we can use this metods on our projetc.
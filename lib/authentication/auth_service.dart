import 'package:authentication_with_bloc/authentication/secure_storage.dart';
import 'package:authentication_with_bloc/models/user.dart';

abstract class AuthenticationService {
  Future<User?> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void>? signOut();
}

class FakeAuthenticationService extends AuthenticationService {
  final SecureStorage secureStorage = SecureStorage();

  @override
  Future<User?> getCurrentUser() async {
    var email = await secureStorage.readSecureData('email');
    if (email != null) {
      return User(name: 'Test User', email: email);
    }
    return null;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));

    if (email.toLowerCase() != 'example@email.com' || password != '12345678') {
      throw Exception('Wrong username or password');
    }
    await secureStorage.writeSecureData('email', email);
    await secureStorage.writeSecureData('password', password);
    return User(name: 'Test User', email: email);
  }

  @override
  Future<void>? signOut() {
    secureStorage.deleteSecureData('email');
    secureStorage.deleteSecureData('password');
    return null;
  }
}

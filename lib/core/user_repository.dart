import 'package:firebase_auth/firebase_auth.dart';

class UserAuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  Future signUp({required String email, required String password}) async {
    await _firebaseAuth.setSettings(appVerificationDisabledForTesting: true);
    await _firebaseAuth.setLanguageCode('en');
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("12$e");
      if (e.code == 'user-not-found') {
        throw Exception('user not found');
      }
      if (e.code == 'weak-password') {
        throw Exception("Password is weak");
      }
      if (e.code == "email-already-in-use") {
        throw Exception('This account already exists!');
      }
      if (e.code == "invalid-email") {
        throw Exception("Incorrect mail id!");
      }
      if (e.code == "invalid-credential") {
        throw Exception("This Id is not available please sign up!");
      }
    } catch (e) {
      print("12$e");
      throw Exception(e);
    }
  }

  Future signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        throw Exception('user not found');
      }
      if (e.code == 'weak-password') {
        throw Exception("Password is weak");
      }
      if (e.code == "email-already-in-use") {
        throw Exception('This account already exists!');
      }
      if (e.code == "invalid-email") {
        throw Exception("Incorrect mail id!");
      }
      if (e.code == "invalid-credential") {
        throw Exception("This Id is not available please sign up!");
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<void> logOut() async => await _firebaseAuth.signOut();

  Future<User?> getCurrentUser() async => _firebaseAuth.currentUser;
}

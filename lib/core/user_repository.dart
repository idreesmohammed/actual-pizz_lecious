import 'package:firebase_auth/firebase_auth.dart';
import 'package:pizz_lecious/core/common_firebase_firestore_instance.dart';
import 'package:pizz_lecious/core/user_model.dart';

class UserAuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  Future signUp({required String email, required String password}) async {
    await _firebaseAuth.setSettings(appVerificationDisabledForTesting: true);
    await _firebaseAuth.setLanguageCode('en');
    try {
      final data = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return data.user;
    } on FirebaseAuthException catch (e) {
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
      final data = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return data.user;
    } on FirebaseAuthException catch (e) {
      print("try ${e.code}");
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
      print("catch $e");
      throw Exception(e);
    }
  }

  Future<void> logOut() async => await _firebaseAuth.signOut();

  Future<User?> getCurrentUser() async => _firebaseAuth.currentUser;
  Future setUserData(
      {required UserModel userModel, required String docName}) async {
    return CommonFirebaseFirestoreInstance.snapShot
        .collection('users')
        .doc(docName)
        .set(userModel.toMap());
  }
}

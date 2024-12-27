import 'package:cloud_firestore/cloud_firestore.dart';

// ? added this class to avoid creating instance often
class CommonFirebaseFirestoreInstance {
  static final snapShot = FirebaseFirestore.instance;
}

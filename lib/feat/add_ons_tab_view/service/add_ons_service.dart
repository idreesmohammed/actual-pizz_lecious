import 'package:pizz_lecious/core/common_firebase_firestore_instance.dart';
import 'package:pizz_lecious/feat/add_ons_tab_view/models/add_ons_model.dart';

class AddOnsService {
  Future<List<AddOnsModel>> getAddOnData() async {
    final snapShot = await CommonFirebaseFirestoreInstance.snapShot
        .collection('pizzas')
        .doc('add-ons')
        .collection('add_on_list')
        .get();
    return snapShot.docs
        .map((e) => AddOnsModel.fromDocument(e.data()))
        .toList();
  }
}

import 'package:pizz_lecious/core/common_firebase_firestore_instance.dart';
import 'package:pizz_lecious/feat/home/models/pizza_model.dart';

class GetAllProductsRepositoryService {
  Future<List<PizzaModel>> getAllProducts() async {
    final snapShot = await CommonFirebaseFirestoreInstance.snapShot
        .collection('pizzas')
        .doc('pizzas')
        .collection('1')
        .get();
    final data =
        snapShot.docs.map((e) => PizzaModel.fromDocument(e.data())).toList();
    return data;
  }
}

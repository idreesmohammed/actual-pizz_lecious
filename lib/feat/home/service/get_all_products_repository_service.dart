import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizz_lecious/feat/home/models/pizza_model.dart';

class GetAllProductsRepositoryService {
  Future<List<PizzaModel>> getAllProducts() async {
    final snapShot = await FirebaseFirestore.instance
        .collection('pizzas')
        .doc('pizzas')
        .collection('1')
        .get();
    final data =
        snapShot.docs.map((e) => PizzaModel.fromDocument(e.data())).toList();
    print("$data 1313 ");
    return data;
  }
}

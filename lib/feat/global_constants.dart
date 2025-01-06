import 'package:logger/logger.dart';
import 'package:pizz_lecious/feat/add_ons_tab_view/models/add_ons_model.dart';
import 'package:pizz_lecious/feat/cart_detail_view/models/cart_product_model.dart';
import 'package:pizz_lecious/feat/home/models/pizza_model.dart';

List<int> addedProductId = [];
List<PizzaModel> pizzaDataList = [];
List<AddOnsModel> addOnsDataModelList = [];
Logger l = Logger();
List<CartProductModel> cartList = [];
List<String> pizzaList = [
  'assets/whole-cheese-pizza-with-slice-removebg-preview.png',
  'assets/pizza3-removebg-preview.png',
  'assets/pizza3-removebg-preview.png',
  'assets/whole-cheese-pizza-with-slice-removebg-preview.png',
  'assets/whole-cheese-pizza-with-slice-removebg-preview.png',
  'assets/pizza3-removebg-preview.png',
  'assets/pizza3-removebg-preview.png',
  'assets/whole-cheese-pizza-with-slice-removebg-preview.png',
];

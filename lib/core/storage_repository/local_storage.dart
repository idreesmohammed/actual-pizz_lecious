import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const cartKey = 'cartkey';
  Future<void> saveIdList(List<int> itemId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        cartKey, itemId.map((e) => e.toString()).toList());
  }

  Future<void> getIdList() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getStringList(cartKey);
  }
}

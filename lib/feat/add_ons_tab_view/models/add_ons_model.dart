class AddOnsModel {
  String image;
  String type;
  int id;
  int calories;
  AddOnsModel(
      {required this.calories,
      required this.id,
      required this.image,
      required this.type});
  factory AddOnsModel.fromDocument(Map<String, dynamic> doc) {
    return AddOnsModel(
        calories: doc['calories'],
        id: doc['id'],
        image: doc['image'],
        type: doc['type']);
  }
}

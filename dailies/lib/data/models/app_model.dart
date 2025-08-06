abstract class AppModel {
  int? _id;

  AppModel({required int? id}) : _id = id;

  set id(int id) {
    _id = id;
  }

  int get id => _id ?? -1;

  bool get isNotSaved => _id == null;
}

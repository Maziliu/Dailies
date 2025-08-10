abstract class AppModel {
  int? _id;

  AppModel({required int? id}) : _id = id;

  set id(int id) {
    _id = id;
  }

  int get id => _id ?? -1;

  bool get isNotSaved => _id == null;

  @override
  bool operator ==(Object other) => identical(this, other) || other.runtimeType == runtimeType && other is AppModel && other.id == id;

  @override
  int get hashCode => Object.hash(runtimeType, id);
}

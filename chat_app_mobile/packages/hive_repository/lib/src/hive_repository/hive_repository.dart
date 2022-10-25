import 'package:hive/hive.dart';
import 'package:hive_repository/src/hive_repository/ihive_repository.dart';

class HiveRepository<T> implements IHiveRepository<T> {
  HiveRepository(this._box);

  final Box _box;

  @override
  Future<T>? get(key) {
    if (boxIsClosed) {
      return null;
    }
    return _box.get(key);
  }

  @override
  Future<void> add(T object) async {
    if (boxIsClosed) {
      return;
    }
    await _box.add(object);
  }

  bool get boxIsClosed => _box.isOpen;
}

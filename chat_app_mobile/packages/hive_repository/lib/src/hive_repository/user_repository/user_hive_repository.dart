import 'package:hive_repository/src/hive_repository/ihive_repository.dart';
import 'package:hive_repository/src/models/user.dart';

class UserHiveRepository implements IHiveRepository<User> {
  UserHiveRepository({required IHiveRepository<User> cache}) : _cache = cache;

  final IHiveRepository<User> _cache;

  @override
  Future<void> add(User object) async {
    await _cache.add(object);
  }

  @override
  Future<User>? get(id) async {
    final cachedUser = await _cache.get(id);
    if (cachedUser != null) {
      return cachedUser;
    }
    return User.empty;
  }
}

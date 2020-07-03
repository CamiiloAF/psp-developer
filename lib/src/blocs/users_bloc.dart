import 'package:psp_developer/src/blocs/Validators.dart';
import 'package:psp_developer/src/models/users_model.dart';
import 'package:psp_developer/src/repositories/users_repository.dart';

class UsersBloc with Validators {
  final _usersProvider = UsersRepository();

  Future<int> updateUser(UserModel user) async =>
      await _usersProvider.updateUser(user);

  Future<int> changePassword(Map<String, String> passwords) async =>
      await _usersProvider.changePassword(passwords);
}

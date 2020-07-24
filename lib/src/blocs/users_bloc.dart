import 'package:psp_developer/src/blocs/validators/validators.dart';
import 'package:psp_developer/src/models/users_model.dart';
import 'package:psp_developer/src/repositories/users_repository.dart';

class UsersBloc with Validators {
  final _usersRepository = UsersRepository();

  Future<int> updateUser(UserModel user) async =>
      await _usersRepository.updateUser(user);

  Future<int> changePassword(Map<String, String> passwords) async =>
      await _usersRepository.changePassword(passwords);
}

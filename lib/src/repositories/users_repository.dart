import 'dart:convert';
import 'dart:io';

import 'package:psp_developer/src/models/users_model.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/network_bound_resources/insert_and_update_bound_resource.dart';

class UsersRepository {
  Future<int> updateUser(UserModel user) async {
    final url = '${Constants.baseUrl}/users/${user.id}';
    return await _UsersUpdateBoundResource()
        .executeUpdate(userModelToJson(user), user, url);
  }

  Future<int> changePassword(Map<String, String> passwords) async {
    try {
      final url = '${Constants.baseUrl}/users/password';
      final body = json.encode(passwords);

      final resp =
          await http.patch(url, headers: Constants.getHeaders(), body: body);

      return resp.statusCode;
    } on SocketException catch (e) {
      return e.osError.errorCode;
    } on http.ClientException catch (_) {
      return 7;
    } catch (e) {
      return -1;
    }
  }
}

class _UsersUpdateBoundResource
    extends InsertAndUpdateBoundResource<UserModel> {
  @override
  UserModel buildNewModel(payload) => null;

  //En este caso no se guarda en la BD sino en las preferencias de usuario
  @override
  void doOperationInDb(UserModel model) async =>
      Preferences().curentUser = userModelToJson(model);
}

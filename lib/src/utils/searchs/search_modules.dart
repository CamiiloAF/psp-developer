import 'package:flutter/cupertino.dart';
import 'package:psp_developer/src/blocs/modules_bloc.dart';
import 'package:psp_developer/src/models/modules_model.dart';
import 'package:psp_developer/src/utils/searchs/search_delegate.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

class SearchModules extends DataSearch {
  final ModulesBloc _modulesBloc;
  final int _projectId;

  SearchModules(this._modulesBloc, this._projectId);

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return super.textNoResults(context);

    final modules = _modulesBloc?.lastValueModulesController?.item2 ?? [];
    if (modules.isNotEmpty && modules != null) {
      return Container(
          child: ListView(
        children: modules
            .where((module) => _areItemContainQuery(module, query))
            .map((module) {
          return CustomListTile(
            title: module.name,
            onTap: () {
              close(context, null);
              Navigator.pushNamed(context, 'programs', arguments: module.id);
            },
            subtitle: module.description,
          );
        }).toList(),
      ));
    } else {
      return super.textNoResults(context);
    }
  }

  bool _areItemContainQuery(ModuleModel module, String query) {
    return module.projectsId == _projectId &&
                module.name.toLowerCase().contains(query.toLowerCase()) ||
            module.description.toLowerCase().contains(query.toLowerCase())
        ? true
        : false;
  }
}

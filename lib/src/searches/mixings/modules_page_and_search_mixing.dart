import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psp_developer/src/models/modules_model.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

mixin ModulesPageAndSearchMixing {
  Widget buildItemList(BuildContext context, ModuleModel module, int projectId,
      {Function closeSearch}) {
    return CustomListTile(
      title: module.name,
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        if (closeSearch != null) closeSearch();
        Navigator.pushNamed(context, 'programs', arguments: module.id);
      },
      subtitle: module.description,
    );
  }
}

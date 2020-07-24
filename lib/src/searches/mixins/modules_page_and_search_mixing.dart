import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psp_developer/src/models/modules_model.dart';
import 'package:psp_developer/src/pages/programs/programs_page.dart';
import 'package:psp_developer/src/pages/project_module_detail/project_module_detail_page.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

mixin ModulesPageAndSearchMixing {
  Widget buildItemList(BuildContext context, ModuleModel module, int projectId,
      {Function closeSearch}) {
    return CustomListTile(
      title: module.name,
      trailing: IconButton(
        icon: Icon(Icons.info_outline),
        onPressed: () => Navigator.pushNamed(
            context, ProjectModuleDetailPage.ROUTE_NAME,
            arguments: module),
      ),
      onTap: () {
        if (closeSearch != null) closeSearch();
        Navigator.pushNamed(context, ProgramsPage.ROUTE_NAME,
            arguments: module.id);
      },
      subtitle: module.description,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psp_developer/src/models/projects_model.dart';
import 'package:psp_developer/src/pages/modules/modules_page.dart';
import 'package:psp_developer/src/pages/project_module_detail/project_module_detail_page.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

mixin ProjectsPageAndSearchMixing {
  Widget buildItemList(BuildContext context, ProjectModel project,
      {Function closeSearch}) {
    return CustomListTile(
      title: project.name,
      trailing: IconButton(
        icon: Icon(Icons.info_outline),
        onPressed: () => Navigator.pushNamed(
            context, ProjectModuleDetailPage.ROUTE_NAME,
            arguments: project),
      ),
      onTap: () {
        if (closeSearch != null) closeSearch();
        Navigator.pushNamed(context, ModulesPage.ROUTE_NAME,
            arguments: project.id);
      },
      subtitle: project.description,
    );
  }
}

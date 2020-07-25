import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psp_developer/src/models/programs_model.dart';
import 'package:psp_developer/src/pages/program_summary/program_summary_page.dart';
import 'package:psp_developer/src/pages/programs/program_info_page.dart';
import 'package:psp_developer/src/pages/programs/program_parts/program_parts_page.dart';
import 'package:psp_developer/src/pages/time_logs/time_logs_page.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

mixin ProgramsPageAndSearchMixing {
  Widget buildItemList(BuildContext context, ProgramModel program, int moduleId,
      {Function closeSearch}) {
    return CustomListTile(
      title: program.name,
      trailing: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () => _goToProgramInfo(context, program)),
      onTap: () {
        if (closeSearch != null) closeSearch();
        onTapItemList(context, program);
      },
      subtitle: program.description,
    );
  }

  void _goToProgramInfo(BuildContext context, ProgramModel program) {
    Navigator.pushNamed(context, ProgramInfoPage.ROUTE_NAME,
        arguments: program);
  }

  void onTapItemList(BuildContext context, ProgramModel program) {
    if (program.totalLines == null) {
      navigatorPush(context, ProgramPartsPage(program: program));
    } else {
      final routeName = (program.deliveryDate == null)
          ? TimeLogsPage.ROUTE_NAME
          : ProgramSummary.ROUTE_NAME;

      Navigator.pushNamed(context, routeName, arguments: program.id);
    }
  }
}

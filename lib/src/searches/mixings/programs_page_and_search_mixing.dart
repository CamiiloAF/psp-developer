import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psp_developer/src/models/programs_model.dart';
import 'package:psp_developer/src/pages/programs/program_parts/program_parts_page.dart';
import 'package:psp_developer/src/pages/time_logs/time_logs_page.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

mixin ProgramsPageAndSearchMixing {
  Widget buildItemList(BuildContext context, ProgramModel program, int moduleId,
      {Function closeSearch}) {
    return CustomListTile(
      title: program.name,
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        if (closeSearch != null) closeSearch();
        onTapItemList(context, program);
      },
      subtitle: program.description,
    );
  }

  void onTapItemList(BuildContext context, ProgramModel program) {
    if (program.totalLines == null) {
      navigatorPush(context, ProgramPartsPage(program: program));
    } else {
      Navigator.pushNamed(context, TimeLogsPage.ROUTE_NAME,
          arguments: program.id);
    }
  }
}

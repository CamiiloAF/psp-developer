import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/models/new_parts_model.dart';
import 'package:psp_developer/src/providers/models/time_log_pending_interruption.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';
import 'package:psp_developer/src/pages/new_parts/new_part_edit_page.dart';

mixin NewPartsPageAndSearchMixing {
  Widget buildItemList(BuildContext context, NewPartModel newPart,
      {Function closeSearch}) {

    final isEnabled =
        Provider.of<TimelogPendingInterruptionModel>(context).isListItemsEnable;

    return CustomListTile(
      title: newPart.name,
      isEnabled: isEnabled,
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        if (closeSearch != null) closeSearch;
        Navigator.pushNamed(context, NewPartEditPage.ROUTE_NAME,
            arguments: newPart);
      },
      subtitle: '${S.of(context).labelPlannedLinesBase} ${newPart.plannedLines}',
    );
  }
}

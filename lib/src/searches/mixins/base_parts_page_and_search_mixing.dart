import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/models/base_parts_model.dart';
import 'package:psp_developer/src/pages/base_parts/base_part_edit_page.dart';
import 'package:psp_developer/src/providers/models/time_log_pending_interruption.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

mixin BasePartsPageAndSearchMixing {
  Widget buildItemList(BuildContext context, BasePartModel basePart,
      {Function closeSearch}) {
    final isEnabled =
        Provider.of<TimelogPendingInterruptionModel>(context).isListItemsEnable;

    return CustomListTile(
      title: 'id: ${basePart.id}',
      isEnabled: isEnabled,
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        if (closeSearch != null) closeSearch();
        Navigator.pushNamed(context, BasePartEditPage.ROUTE_NAME,
            arguments: basePart);
      },
      subtitle:
          '${S.of(context).labelPlannedLinesBase}: ${basePart.plannedLinesBase}',
    );
  }
}

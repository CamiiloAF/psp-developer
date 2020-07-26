import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/models/reusable_parts_model.dart';
import 'package:psp_developer/src/providers/models/time_log_pending_interruption.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';
import 'package:psp_developer/src/pages/reusable_parts/reusable_part_edit_page.dart';

mixin ReusablePartsPageAndSearchMixing {
  Widget buildItemList(BuildContext context, ReusablePartModel reusablePart,
      {Function closeSearch}) {
    final isEnabled =
        Provider.of<TimelogPendingInterruptionModel>(context).isListItemsEnable;

    return CustomListTile(
      title: '${S.of(context).labelPlannedLines} ${reusablePart.plannedLines}',
      isEnabled: isEnabled,
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        if (closeSearch != null) closeSearch();
        Navigator.pushNamed(context, ReusablePartEditPage.ROUTE_NAME,
            arguments: reusablePart);
      },
    );
  }
}

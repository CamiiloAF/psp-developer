import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/models/reusable_parts_model.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

mixin ReusablePartsPageAndSearchMixing {
  Widget buildItemList(BuildContext context, ReusablePartModel reusablePart,
      {Function closeSearch}) {
    return CustomListTile(
      title: '${S.of(context).labelPlannedLines} ${reusablePart.plannedLines}',
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        if (closeSearch != null) closeSearch();
        Navigator.pushNamed(
            context, 'ReusablePartDetailPage.ROUTE_NAME', //TODO PONER LA RUTA
            arguments: reusablePart);
      },
    );
  }
}
